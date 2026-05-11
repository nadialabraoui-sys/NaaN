import { Component, OnDestroy, PLATFORM_ID, viewChild, ElementRef, inject, signal } from '@angular/core';
import { isPlatformBrowser } from '@angular/common';
import { RouterModule } from '@angular/router';
import { Navbar } from '../../shared/components/navbar/navbar';
import { Header } from '../../shared/components/header/header';
import { HeaderLanding } from './header-landing/header-landing';
import { Novedades } from './novedades/novedades';

@Component({
  selector: 'app-landing',
  standalone: true,
  imports: [RouterModule, Navbar, Header, HeaderLanding, Novedades],
  templateUrl: './landing.html',
})
export class Landing implements OnDestroy {

  private platformId = inject(PLATFORM_ID);

  private snapContainer = viewChild.required<ElementRef<HTMLElement>>('snapContainer');

  seccionActual = signal(1);
  secciones = [1, 2];

  private scrollBloqueado = false;
  private scrollTimer?: ReturnType<typeof setTimeout>;

  ngOnDestroy() {
    clearTimeout(this.scrollTimer);
  }

  onWheel(e: WheelEvent) {
    if (!isPlatformBrowser(this.platformId)) return;

    e.preventDefault();

    if (this.scrollBloqueado) return;
    this.scrollBloqueado = true;
    clearTimeout(this.scrollTimer);

    if (e.deltaY > 0) {
      this.seccionActual.update(n => Math.min(n + 1, this.secciones.length));
    } else {
      this.seccionActual.update(n => Math.max(n - 1, 1));
    }

    const el = this.snapContainer().nativeElement;
    const h = el.clientHeight || window.innerHeight;

    el.scrollTo({
      top: (this.seccionActual() - 1) * h,
      behavior: 'smooth'
    });

    this.scrollTimer = setTimeout(() => {
      this.scrollBloqueado = false;
    }, 400);
  }

  irASeccion(n: number) {
    if (!isPlatformBrowser(this.platformId)) return;
    this.seccionActual.set(n);

    const el = this.snapContainer().nativeElement;
    const h = el.clientHeight || window.innerHeight;

    el.scrollTo({
      top: (n - 1) * h,
      behavior: 'smooth'
    });
  }

  anterior() {
    if (this.seccionActual() > 1) {
      this.irASeccion(this.seccionActual() - 1);
    }
  }

  siguiente() {
    if (this.seccionActual() < this.secciones.length) {
      this.irASeccion(this.seccionActual() + 1);
    }
  }
}