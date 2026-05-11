import { Component, PLATFORM_ID, inject, signal } from '@angular/core';
import { AsyncPipe, UpperCasePipe, isPlatformBrowser } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { RouterModule, ActivatedRoute } from '@angular/router';
import { combineLatest, Observable, of } from 'rxjs';
import { switchMap, map, catchError, startWith, tap } from 'rxjs/operators';
import { ClientService } from '../../services/client.service';
import { Navbar } from '../../shared/components/navbar/navbar';
import { Header } from '../../shared/components/header/header';
import { TarjetaProducto } from '../../shared/components/tarjeta-producto/tarjeta-producto';
import { Paginacion } from '../../shared/components/paginacion/paginacion';
import { environment } from '../../../../environments/environment';

interface ProductosVM {
  productos: any[];
  favoritos: Set<number>;
  cargando: boolean;
  error: string;
}

@Component({
  selector: 'app-productos',
  standalone: true,
  imports: [AsyncPipe, UpperCasePipe, FormsModule, RouterModule, Navbar, Header, TarjetaProducto, Paginacion],
  templateUrl: './productos.html',
})
export class Productos {

  private clientService = inject(ClientService);
  private route = inject(ActivatedRoute);
  private platformId = inject(PLATFORM_ID);

   PAGINA_SIZE = environment.paginaSize;

  paginaActual = signal(1);
  tituloSeccion = signal('Todos los productos');
  minPrecioFiltro = signal<number | null>(null);
  maxPrecioFiltro = signal<number | null>(null);
  tallasFiltro = signal<string[]>([]);
  coloresFiltro = signal<string[]>([]);

  vm$: Observable<ProductosVM> = this.inicializarProductos();

  private inicializarProductos(): Observable<ProductosVM> {
    return combineLatest([
      this.escucharParams(),
      this.cargarFavoritos()
    ]).pipe(
      map(([vm, favoritos]) => ({ ...vm, favoritos }))
    );
  }

  private cargarFavoritos(): Observable<Set<number>> {
    if (!isPlatformBrowser(this.platformId) || !this.clientService.getToken()) {
      return of(new Set<number>());
    }

    return this.clientService.getMisFavoritos().pipe(
      map((favs: any[]) => new Set<number>(favs.map(f => f.id_producto))),
      catchError(() => of(new Set<number>())),
      startWith(new Set<number>())
    );
  }

  private escucharParams(): Observable<Omit<ProductosVM, 'favoritos'>> {
    return this.route.queryParams.pipe(
      tap(params => this.actualizarFiltros(params)),
      switchMap(params => this.cargarProductos(params))
    );
  }

  private actualizarFiltros(params: any): void {
    this.minPrecioFiltro.set(params['minPrecio'] != null ? +params['minPrecio'] : null);
    this.maxPrecioFiltro.set(params['maxPrecio'] != null ? +params['maxPrecio'] : null);
    this.tallasFiltro.set(params['tallas'] ? params['tallas'].split(',') : []);
    this.coloresFiltro.set(params['colores'] ? params['colores'].split(',') : []);
    this.paginaActual.set(1);
    this.tituloSeccion.set(this.tituloDe(params));
  }

 private cargarProductos(params: any): Observable<Omit<ProductosVM, 'favoritos'>> {

    const estadoInicial = { productos: [] as any[], cargando: true,  error: '' };
    const estadoError   = { productos: [] as any[], cargando: false, error: 'No se pudieron cargar los productos.' };

    const apiParams: any = {};
    if (params['q']) apiParams.buscar = params['q'];
    if (params['genero'] && !params['categoria']) apiParams.sexo = params['genero'];
    if (params['categoria']) apiParams.categoria = params['categoria'];

    return this.clientService.getProductos(apiParams).pipe(
      map((data: any[]) => ({
        productos: data.sort((a, b) => a.nombre.localeCompare(b.nombre, 'es')),
        cargando: false,
        error: ''
      })),
      catchError(() => of(estadoError)),
      startWith(estadoInicial)
    );
  }

  
  private tituloDe(params: any): string {
    if (params['q']) return `Resultados para "${params['q']}"`;
    if (params['nombre']) return params['nombre'];
    if (params['cat']) return params['cat'].replace(/-/g, ' ');
    if (params['genero']) return params['genero'] === 'mujer' ? 'Mujer' : 'Hombre';
    return 'Todos los productos';
  }

  filtrados(productos: any[]): any[] {
    const min = this.minPrecioFiltro();
    const max = this.maxPrecioFiltro();
    const tallas  = this.tallasFiltro();
    const colores = this.coloresFiltro();

    return productos.filter(p => {
      if (min != null && p.precio < min) return false;
      if (max != null && p.precio > max) return false;
      if (tallas.length  > 0 && !tallas.includes(p.talla))   return false;
      if (colores.length > 0 && !colores.includes(p.color))  return false;
      return true;
    });
  }

  paginaItems(productos: any[]): any[] {
    const f = this.filtrados(productos);
    const inicio = (this.paginaActual() - 1) * this.PAGINA_SIZE;
    return f.slice(inicio, inicio + this.PAGINA_SIZE);
  }

  totalPaginas(productos: any[]): number {
    return Math.ceil(this.filtrados(productos).length / this.PAGINA_SIZE) || 1;
  }

  numPaginas(productos: any[]): number[] {
    return Array.from({ length: this.totalPaginas(productos) }, (_, i) => i + 1);
  }

  irAPagina(n: number, productos: any[]): void {
    if (n >= 1 && n <= this.totalPaginas(productos)) {
      this.paginaActual.set(n);
      if (isPlatformBrowser(this.platformId)) window.scrollTo({ top: 0 });
    }
  }
}