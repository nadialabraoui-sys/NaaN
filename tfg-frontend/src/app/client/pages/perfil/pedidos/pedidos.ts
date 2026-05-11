import { Component, inject, signal } from '@angular/core';
import { AsyncPipe, NgClass, TitleCasePipe } from '@angular/common';
import { Observable, of, forkJoin } from 'rxjs';
import { switchMap, map, catchError, startWith } from 'rxjs/operators';
import { ClientService } from '../../../services/client.service';

interface PedidosVM {
  pedidos: any[];
  cargando: boolean;
  error: string;
}

@Component({
  selector: 'app-mis-pedidos',
  standalone: true,
  imports: [AsyncPipe, NgClass, TitleCasePipe],
  templateUrl: './pedidos.html',
})
export class MisPedidos {

  private clientService = inject(ClientService);

  filtroEstado = signal('');

  readonly filtros = [
    { label: 'Todos', valor: '' },
    { label: 'Pendiente', valor: 'pendiente' },
    { label: 'Pagado', valor: 'pagado' },
    { label: 'Enviado', valor: 'enviado' },
    { label: 'Entregado', valor: 'entregado' },
    { label: 'Cancelado', valor: 'cancelado' },
  ];

  vm$: Observable<PedidosVM> = forkJoin({
    pedidos:  this.clientService.getMisPedidos().pipe(catchError(() => of<any[]>([]))),
    detalles: this.clientService.getMisDetallesPedidos().pipe(catchError(() => of<any[]>([])))
  }).pipe(
    switchMap(({ pedidos, detalles }: any) => {
      const idsProductos = [...new Set<number>(detalles.map((d: any) => d.id_producto))];
      if (idsProductos.length === 0) {
        return of({ pedidos, detalles, productos: [] as any[] });
      }
      return forkJoin(
        idsProductos.map(id => this.clientService.getProducto(id)) as Observable<any>[]
      ).pipe(
        map((productos: any[]) => ({ pedidos, detalles, productos })),
        catchError(() => of({ pedidos, detalles, productos: [] as any[] }))
      );
    }),
    map(({ pedidos, detalles, productos }: any) => ({
      pedidos:  this.construir(pedidos, detalles, productos),
      cargando: false,
      error:    ''
    })),
    catchError(() => of({ pedidos: [] as any[], cargando: false, error: 'No se han podido cargar los pedidos' })),
    startWith({ pedidos: [] as any[], cargando: true, error: '' })
  );

  private construir(pedidos: any[], detalles: any[], productos: any[]): any[] {
    return [...pedidos]
      .sort((a, b) => a.id_pedido - b.id_pedido)
      .map((pedido, index) => ({
        ...pedido,
        numero: index + 1,
        items: detalles
          .filter((d: any) => d.id_pedido === pedido.id_pedido)
          .map((d: any) => ({
            ...d,
            producto: productos.find((p: any) => p.id_producto === d.id_producto) || null
          }))
      }))
      .reverse();
  }

  pedidosFiltrados(pedidos: any[]): any[] {
    const f = this.filtroEstado();
    if (!f) return pedidos;
    return pedidos.filter(p => p.estado === f);
  }

  contarPorEstado(pedidos: any[], estado: string): number {
    if (!estado) return pedidos.length;
    return pedidos.filter(p => p.estado === estado).length;
  }

  subtotal(items: any[]): number {
    return items.reduce((acc, item) => acc + item.precio_en_el_momento * item.cantidad, 0);
  }

  formatearFecha(fecha: string): string {
    if (!fecha) return '';
    return new Date(fecha).toLocaleDateString('es-ES', {
      day: '2-digit', month: 'long', year: 'numeric'
    });
  }

  badgeClasses(estado: string): string {
    const map: Record<string, string> = {
      pendiente: 'bg-amber-100 text-amber-700',
      pagado: 'bg-green-100 text-green-700',
      enviado: 'bg-sky-100 text-sky-700',
      entregado: 'bg-emerald-100 text-emerald-700',
      cancelado: 'bg-red-100 text-red-700',
    };
    return map[estado] ?? 'bg-gray-100 text-gray-600';
  }
}
