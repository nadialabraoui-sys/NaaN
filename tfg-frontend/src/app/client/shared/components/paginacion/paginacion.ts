import { Component, input, output } from '@angular/core';

@Component({
  selector: 'app-paginacion',
  standalone: true,
  templateUrl: './paginacion.html',
})
export class Paginacion {

  paginaActual = input(1);
  totalPaginas = input(1);
  paginas = input<number[]>([]);

  cambiarPagina = output<number>();

}