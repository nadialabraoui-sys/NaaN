import { Component, OnInit, PLATFORM_ID, inject, signal } from '@angular/core';
import { isPlatformBrowser } from '@angular/common';
import { firstValueFrom } from 'rxjs';
import { ClientService } from '../../../services/client.service';
import { TarjetaProducto } from '../../../shared/components/tarjeta-producto/tarjeta-producto';

@Component({
  selector: 'app-novedades',
  standalone: true,
  imports: [TarjetaProducto],
  templateUrl: './novedades.html',
})
export class Novedades implements OnInit {

  private clientService = inject(ClientService);
  private platformId = inject(PLATFORM_ID);

  novedades = signal<any[]>([]);
  cargandoNovedades = signal(false);

  ngOnInit() {
    if (!isPlatformBrowser(this.platformId)) return;
    this.cargarNovedades();
  }

  async cargarNovedades() {
    this.cargandoNovedades.set(true);
    try {
      const productos: any[] = await firstValueFrom(this.clientService.getProductos());
      this.novedades.set(productos.slice(0, 7));
    } catch {}
    this.cargandoNovedades.set(false);
  }
}
