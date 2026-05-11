import { Component, inject, signal } from '@angular/core';
import { AsyncPipe } from '@angular/common';
import { Observable, of, forkJoin } from 'rxjs';
import { switchMap, map, catchError, startWith } from 'rxjs/operators';
import { ClientService } from '../../../services/client.service';
import { TarjetaProducto } from '../../../shared/components/tarjeta-producto/tarjeta-producto';
import { Paginacion } from '../../../shared/components/paginacion/paginacion';
import { environment } from '../../../../../environments/environment';

interface FavoritosVM {
  favoritos: any[];
  cargando: boolean;
  error: string;
}

@Component({
  selector: 'app-mis-favoritos',
  standalone: true,
  imports: [AsyncPipe, TarjetaProducto, Paginacion],
  templateUrl: './favoritos.html',
})
export class MisFavoritos {

  private clientService = inject(ClientService);

  readonly PAGINA_SIZE = environment.paginaSize;
  paginaActual = signal(1);
  eliminados = signal(new Set<number>());

  vm$: Observable<FavoritosVM> = this.clientService.getMisFavoritos().pipe(
    switchMap((favs: any[]) => {
      if (favs.length === 0) return of({ favoritos: [] as any[] });
      return forkJoin(
        favs.map(f => this.clientService.getProducto(f.id_producto)) as Observable<any>[]
      ).pipe(
        map((productos: any[]) => ({
          favoritos: favs.map((f: any, i: number) => ({ ...f, producto: productos[i] || null }))
        })),
        catchError(() => of({ favoritos: favs.map((f: any) => ({ ...f, producto: null })) }))
      );
    }),
    map(({ favoritos }) => ({ favoritos, cargando: false, error: '' })),
    catchError(() => of({ favoritos: [] as any[], cargando: false, error: 'No se han podido cargar los favoritos' })),
    startWith({ favoritos: [] as any[], cargando: true, error: '' })
  );

  totalPaginas(favoritos: any[]): number {
    return Math.ceil(favoritos.length / this.PAGINA_SIZE) || 1;
  }

  favoritosPagina(favoritos: any[]): any[] {
    const inicio = (this.paginaActual() - 1) * this.PAGINA_SIZE;
    return favoritos.slice(inicio, inicio + this.PAGINA_SIZE);
  }

  paginas(favoritos: any[]): number[] {
    return Array.from({ length: this.totalPaginas(favoritos) }, (_, i) => i + 1);
  }

  irAPagina(n: number, favoritos: any[]): void {
    if (n >= 1 && n <= this.totalPaginas(favoritos)) this.paginaActual.set(n);
  }

  estaEliminado(idProducto: number): boolean {
    return this.eliminados().has(idProducto);
  }

  onFavoritoChanged(idProducto: number, activo: boolean) {
    this.eliminados.update(s => {
      const next = new Set(s);
      activo ? next.delete(idProducto) : next.add(idProducto);
      return next;
    });
  }
}
