import { Component, OnInit, OnDestroy, PLATFORM_ID, input, output, inject, signal } from '@angular/core';
import { CommonModule, isPlatformBrowser } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router, RouterModule, NavigationEnd } from '@angular/router';
import { Subscription } from 'rxjs';
import { filter } from 'rxjs/operators';
import { ClientService } from '../../../services/client.service';

@Component({
  selector: 'app-header',
  imports: [CommonModule, FormsModule, RouterModule],
  standalone: true,
  templateUrl: './header.html',
})
export class Header implements OnInit, OnDestroy {

  private clientService = inject(ClientService);
  private router = inject(Router);
  private platformId = inject(PLATFORM_ID);

  mostrarHamburguesa = input(false);
  hamburguesa = output<void>();

  query = '';
  mostrarFiltros = signal(false);
  sesionIniciada = signal(false);
  nombreUsuario = signal('');
  nombreCompleto = signal('');

  tallas = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];
  tallasMap: { [key: string]: boolean } = {};
  minPrecio: number | null = null;
  maxPrecio: number | null = null;

  readonly colores = ['rojo','azul','verde','amarillo','negro','blanco','gris','rosa','morado','naranja','marron'];
  coloresMap: { [key: string]: boolean } = {};

  private routerSub!: Subscription;

  ngOnInit() {
    if (isPlatformBrowser(this.platformId)) {
      const usuario = this.clientService.getUsuarioLocal();
      if (usuario) {
        this.sesionIniciada.set(true);
        this.nombreCompleto.set(usuario.nombre || '');
        this.nombreUsuario.set((usuario.nombre || '').split(' ')[0]);
      }
    }

    this.routerSub = this.router.events.pipe(
      filter(e => e instanceof NavigationEnd)
    ).subscribe(() => {
      const params = this.router.parseUrl(this.router.url).queryParams;
      const tieneFiltroPrecio = params['minPrecio'] != null || params['maxPrecio'] != null;
      const tieneFiltroTalla  = params['tallas']   != null;
      const tieneFiltroColor  = params['colores']  != null;
      if (!tieneFiltroPrecio && !tieneFiltroTalla && !tieneFiltroColor) {
        this.limpiarUI();
      }
      this.mostrarFiltros.set(false);
    });
  }

  ngOnDestroy() { this.routerSub?.unsubscribe(); }

  get iniciales(): string {
    const partes = this.nombreCompleto().trim().split(/\s+/);
    return ((partes[0]?.[0] || '') + (partes[1]?.[0] || '')).toUpperCase() || '?';
  }

  toggleFiltros() { this.mostrarFiltros.update(v => !v); }

  limpiarUI() {
    this.tallasMap  = {};
    this.coloresMap = {};
    this.minPrecio = null;
    this.maxPrecio = null;
    this.query = '';
  }

  resetearFiltros() {
    this.limpiarUI();

    const currentParams = { ...this.router.parseUrl(this.router.url).queryParams };
    delete currentParams['minPrecio'];
    delete currentParams['maxPrecio'];
    delete currentParams['tallas'];
    delete currentParams['colores'];
    delete currentParams['q'];

    this.router.navigate(['/productos'], { queryParams: currentParams });
    this.mostrarFiltros.set(false);
  }

  buscar() {
    const tallasSeleccionadas  = this.tallas.filter(t  => this.tallasMap[t]);
    const coloresSeleccionados = this.colores.filter(c => this.coloresMap[c]);
    const filterParams: any = {};

    if (this.query.trim()) filterParams.q = this.query.trim();
    if (this.minPrecio != null) filterParams.minPrecio = this.minPrecio;
    if (this.maxPrecio != null) filterParams.maxPrecio = this.maxPrecio;
    if (tallasSeleccionadas.length) filterParams.tallas = tallasSeleccionadas.join(',');
    if (coloresSeleccionados.length) filterParams.colores = coloresSeleccionados.join(',');

    if (Object.keys(filterParams).length === 0) return;

    const currentParams = { ...this.router.parseUrl(this.router.url).queryParams };
    const mergedParams = { ...currentParams, ...filterParams };

    this.router.navigate(['/productos'], { queryParams: mergedParams });
    this.mostrarFiltros.set(false);
  }

  pulsarEnter(event: KeyboardEvent) {
    if (event.key === 'Enter') this.buscar();
  }
}
