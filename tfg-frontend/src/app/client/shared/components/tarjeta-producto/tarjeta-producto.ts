import { Component, input, output } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { BotonFavorito } from '../boton-favorito/boton-favorito';

@Component({
  selector: 'app-tarjeta-producto',
  standalone: true,
  imports: [CommonModule, RouterModule, BotonFavorito],
  templateUrl: './tarjeta-producto.html',
  host: { role: 'listitem' }
})
export class TarjetaProducto {
  producto = input.required<any>();
  activo = input(false);
  mostrarFavorito = input(true);
  eliminado = input(false);
  changed = output<boolean>();
}
