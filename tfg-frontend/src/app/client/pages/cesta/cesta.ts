import { Component, PLATFORM_ID, inject, signal } from '@angular/core';
import { AsyncPipe, DecimalPipe, isPlatformBrowser } from '@angular/common';
import { RouterModule, Router } from '@angular/router';
import { forkJoin, of, firstValueFrom, Observable } from 'rxjs';
import { switchMap, map, catchError, startWith, tap } from 'rxjs/operators';
import { ClientService } from '../../services/client.service';

interface CestaVM {
  cargando: boolean;
  error: string;
}

@Component({
  selector: 'app-cesta',
  standalone: true,
  imports: [AsyncPipe, DecimalPipe, RouterModule],
  templateUrl: './cesta.html',
})
export class Cesta {

  private clientService = inject(ClientService);
  private router = inject(Router);
  private platformId = inject(PLATFORM_ID);

  items = signal<any[]>([]);
  hoveredId = signal<number | null>(null);
  procesando = signal(new Set<number>());
  vm$: Observable<CestaVM> = this.inicializarCesta();

  private inicializarCesta(): Observable<CestaVM> {
    if (!isPlatformBrowser(this.platformId) || !this.clientService.getToken()) {
      return of({ cargando: false, error: '' });
    }
    return this.cargarCesta();
  }

  private cargarCesta(): Observable<CestaVM> {
    return this.clientService.getMisDetallesCarrito().pipe(
      switchMap((detalles: any[]) => {
        if (!detalles?.length) return of({ detalles: [], productos: [] as any[] });
        const peticiones = detalles.map((d: any) =>
          this.clientService.getProducto(d.id_producto).pipe(catchError(() => of(null)))
        );
        return forkJoin(peticiones).pipe(map(productos => ({ detalles, productos })));
      }),
      tap(({ detalles, productos }) => {
        this.items.set(detalles.map((d: any) => ({
          ...d,
          producto: (productos as any[]).find((p: any) => p?.id_producto === d.id_producto) || null
        })));
      }),
      map(() => ({ cargando: false, error: '' })),
      catchError(() => of({ cargando: false, error: 'No se pudo cargar la cesta.' })),
      startWith({ cargando: true, error: '' })
    );
  }

  destacado(items: any[]): any {
    return items.find(i => i.id_detalle_carrito === this.hoveredId()) ?? items[0] ?? null;
  }

  hover(id: number) {
    this.hoveredId.set(id);
  }

  totalItem(item: any): string {
    return (item.precio_unitario * item.cantidad).toFixed(2);
  }

  total(items: any[]): string {
    return items
      .reduce((s: number, i: any) => s + i.precio_unitario * i.cantidad, 0)
      .toFixed(2);
  }

  async cambiarCantidad(item: any, cantidad: number) {
    const id = item.id_detalle_carrito;

    if (this.procesando().has(id)) return;

    const nuevaCantidad = item.cantidad + cantidad;

    if (nuevaCantidad < 0) return;

    // para no permitir pulsar varias veces + o - mientras carga
    this.procesando.update(s => { const n = new Set(s); n.add(id); return n; });

    if (nuevaCantidad === 0) {
      if (this.hoveredId() === id) this.hoveredId.set(null);
      this.items.update(list => list.filter(i => i.id_detalle_carrito !== id));
    } else {
      this.items.update(list => list.map(i =>
        i.id_detalle_carrito === id ? { ...i, cantidad: nuevaCantidad } : i
      ));
    }

    try {
      if (nuevaCantidad === 0) {
        await firstValueFrom(this.clientService.deleteDetalleCarrito(id));
      } else {
        await firstValueFrom(this.clientService.updateDetalleCarrito(id, { cantidad: nuevaCantidad }));
      }
    } catch {
      if (nuevaCantidad === 0) {
        this.items.update(list => [...list, item]);
      } else {
        this.items.update(list => list.map(i =>
          i.id_detalle_carrito === id ? { ...i, cantidad: item.cantidad } : i
        ));
      }
    } finally {
      this.procesando.update(s => { const n = new Set(s); n.delete(id); return n; });
    }
  }

  tramitar() {
    this.clientService.autorizar();
    this.router.navigate(['/checkout']);
  }
}