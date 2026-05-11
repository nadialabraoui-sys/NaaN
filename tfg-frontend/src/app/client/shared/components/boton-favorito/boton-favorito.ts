import { Component, input, output, OnInit, OnDestroy, PLATFORM_ID, inject, effect } from '@angular/core';
import { isPlatformBrowser } from '@angular/common';
import { Router } from '@angular/router';
import { Subject, Subscription, EMPTY } from 'rxjs';
import { switchMap, catchError } from 'rxjs/operators';
import { ClientService } from '../../../services/client.service';

@Component({
  selector: 'button[app-boton-favorito]',
  standalone: true,
  template: `
    <svg
      width="60" height="60"
      xmlns="http://www.w3.org/2000/svg"
      viewBox="0 0 24 24"
      [attr.fill]="isActivo ? 'currentColor' : 'none'"
      stroke="currentColor" stroke-width="1"
      aria-hidden="true"
    >
      <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"/>
    </svg>
  `,
  host: {
    '(click)': 'onClick($event)',
    '[class.text-naan-red]': 'isActivo',
    '[attr.aria-pressed]': 'isActivo',
    '[attr.aria-label]': 'isActivo ? "Quitar de favoritos" : "Añadir a favoritos"',
  }
})
export class BotonFavorito implements OnInit, OnDestroy {

  private clientService = inject(ClientService);
  private router = inject(Router);
  private platformId = inject(PLATFORM_ID);

  activo = input(false);
  idProducto = input.required<number>();
  changed = output<boolean>();

  private _activo = false;
  private pendiente = false;
  private click$ = new Subject<boolean>();
  private sub?: Subscription;

  constructor() {
    effect(() => {
      const val = this.activo();
      if (!this.pendiente) this._activo = val;
    });
  }

  get isActivo() { return this._activo; }

  ngOnInit() {
    this.sub = this.click$.pipe(
      switchMap(nuevoEstado => {
        this.pendiente = true;
        const usuario = this.clientService.getUsuarioLocal();
        const accion = nuevoEstado
          ? this.clientService.addFavorito(usuario?.id_usuario, this.idProducto())
          : this.clientService.eliminarFavorito(this.idProducto());
        return accion.pipe(
          catchError(() => {
            this._activo = !nuevoEstado;
            this.changed.emit(this._activo);
            this.pendiente = false;
            return EMPTY;
          })
        );
      })
    ).subscribe(() => {
      this.pendiente = false;
    });
  }

  ngOnDestroy() {
    this.sub?.unsubscribe();
    this.click$.complete();
  }

  onClick(event: Event) {
    event.stopPropagation();
    event.preventDefault();

    if (!isPlatformBrowser(this.platformId)) return;
    if (!this.clientService.getToken()) { this.router.navigate(['/login']); return; }

    this._activo = !this._activo;
    this.changed.emit(this._activo);
    this.click$.next(this._activo);
  }
}
