import { Component, PLATFORM_ID, inject, signal } from '@angular/core';
import { AsyncPipe, DecimalPipe, isPlatformBrowser } from '@angular/common';
import { RouterModule, ActivatedRoute, Router } from '@angular/router';
import { forkJoin, Observable, of, firstValueFrom } from 'rxjs';
import { switchMap, map, catchError, startWith, tap, take } from 'rxjs/operators';
import { ClientService } from '../../services/client.service';
import { Navbar } from '../../shared/components/navbar/navbar';
import { Header } from '../../shared/components/header/header';
import { BotonFavorito } from '../../shared/components/boton-favorito/boton-favorito';
import { Modal3d } from './modal-3d/modal-3d';

interface ProductoVM {
  producto: any;
  esFavorito: boolean;
  cargando: boolean;
  error: string;
}

@Component({
  selector: 'app-producto-detalle',
  standalone: true,
  imports: [AsyncPipe, DecimalPipe, RouterModule, Navbar, Header, BotonFavorito, Modal3d],
  templateUrl: './producto.html',
})
export class ProductoDetalle {

  private route = inject(ActivatedRoute);
  private router = inject(Router);
  private clientService = inject(ClientService);
  private platformId = inject(PLATFORM_ID);

  tallas = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];

  tallasDisponibles = signal(new Set<string>());
  tallaSeleccionada = signal('');
  esFavorito = signal(false);
  mensajeCesta = signal(false);
  agregandoCesta = signal(false);
  modal3dAbierto = signal(false);

  private tallasConSoporte3d = new Set(['S', 'M', 'L']);
  private productosConSoporte3d = new Set([5, 6]);

  vm$: Observable<ProductoVM> = this.inicializarProducto();


  private inicializarProducto(): Observable<ProductoVM> {
    return this.route.paramMap.pipe(
      switchMap(params => {
        const id = Number(params.get('id'));
        return this.cargarProducto(id);
      })
    );
  }

  private cargarProducto(id: number): Observable<ProductoVM> {

    const estadoInicial: ProductoVM = { producto: null, esFavorito: false, cargando: true,  error: '' };
    const estadoError: ProductoVM = { producto: null, esFavorito: false, cargando: false, error: 'Producto no encontrado.' };

    return forkJoin({
      producto: this.pedirProducto(id),
      esFavorito: this.pedirFavorito(id)
    }).pipe(

      map(({ producto, esFavorito }) => {
        if (!producto) return estadoError;
        return { producto, esFavorito, cargando: false, error: '' };
      }),

      tap(vm => {
        if (!vm.cargando && vm.producto) {
          this.esFavorito.set(vm.esFavorito);
          this.inicializarTallas(vm.producto);
        }
      }),

      catchError(() => of(estadoError)),
      startWith(estadoInicial)
    );
  }

  private pedirProducto(id: number): Observable<any> {
    return this.clientService.getProducto(id).pipe(
      catchError(() => of(null))
    );
  }

  private pedirFavorito(id: number): Observable<boolean> {
    if (!isPlatformBrowser(this.platformId) || !this.clientService.getToken()) {
      return of(false);
    }

    return this.clientService.getMisFavoritos().pipe(
      map((favs: any[]) => favs.some(f => f.id_producto === id)),
      catchError(() => of(false))
    );
  }

  private inicializarTallas(producto: any): void {
    if (producto.talla) {
      this.tallasDisponibles.set(new Set([producto.talla]));
      this.tallaSeleccionada.set(producto.talla);
    } else {
      this.tallasDisponibles.set(new Set(this.tallas));
      this.tallaSeleccionada.set(this.tallas[2]);
    }
  }


  tiene3d(producto: any): boolean {
    return this.productosConSoporte3d.has(producto?.id_producto) &&
           this.tallasConSoporte3d.has(this.tallaSeleccionada());
  }

  abrir3d() { this.modal3dAbierto.set(true);  }
  cerrar3d() { this.modal3dAbierto.set(false); }

  seleccionarTalla(t: string) {
    if (this.tallasDisponibles().has(t)) {
      this.tallaSeleccionada.set(t);
    }
  }

  disponible(t: string) {
    return this.tallasDisponibles().has(t);
  }

  compartir() {
    if (isPlatformBrowser(this.platformId)) {
      navigator.clipboard?.writeText(window.location.href);
    }
  }


  private addToCart(producto: any) {
    return forkJoin([
      this.clientService.getCarritoIdCached(),
      this.clientService.getMisDetallesCarrito()
    ]).pipe(
      take(1),
      switchMap(([idCarrito, detalles]: [number, any[]]) => {
        const existente = detalles.find(
          d => d.id_producto === producto.id_producto &&
               d.talla === this.tallaSeleccionada()
        );

        if (existente) {
          return this.clientService.updateDetalleCarrito(existente.id_detalle_carrito, {
            cantidad: existente.cantidad + 1
          });
        }

        return this.clientService.addDetalleCarrito({
          id_carrito: idCarrito,
          id_producto: producto.id_producto,
          cantidad: 1,
          precio_unitario: producto.precio,
          talla: this.tallaSeleccionada(),
        });
      }),
      catchError(() => of(null))
    );
  }

  async agregarCesta(producto: any) {
    if (!this.clientService.getToken()) { this.router.navigate(['/login']); return; }
    if (this.agregandoCesta()) return;

    this.agregandoCesta.set(true);
    try {
      await firstValueFrom(this.addToCart(producto));
      this.mensajeCesta.set(true);
      setTimeout(() => this.mensajeCesta.set(false), 3000);
    } finally {
      this.agregandoCesta.set(false);
    }
  }

  async comprar(producto: any) {
    if (!this.clientService.getToken()) { this.router.navigate(['/login']); return; }
    if (this.agregandoCesta()) return;

    this.agregandoCesta.set(true);
    try {
      await firstValueFrom(this.addToCart(producto));
      this.router.navigate(['/cesta']);
    } finally {
      this.agregandoCesta.set(false);
    }
  }
}