import { Component, OnInit, PLATFORM_ID, inject, signal } from '@angular/core';
import { isPlatformBrowser, UpperCasePipe } from '@angular/common';
import { RouterModule, Router } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { firstValueFrom } from 'rxjs';
import { ClientService } from '../../../services/client.service';

@Component({
  selector: 'app-header-landing',
  standalone: true,
  imports: [RouterModule, FormsModule, UpperCasePipe],
  templateUrl: './header-landing.html',
})
export class HeaderLanding implements OnInit {

  private clientService = inject(ClientService);
  private router = inject(Router);
  private platformId = inject(PLATFORM_ID);

  menuExpandido = signal(false);
  categoriaActual = signal<'mujer' | 'hombre' | null>(null);

  subcategorias = signal<Record<string, { label: string; id: number }[]>>({
    mujer: [],
    hombre: []
  });

  sesionIniciada = signal(false);
  nombreCompleto = signal('');
  nombreUsuario = signal('');

  query = '';
  mostrarFiltros = signal(false);
  tallas = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];
  tallasMap: { [key: string]: boolean } = {};
  minPrecio: number | null = null;
  maxPrecio: number | null = null;

  colores = ['rojo','azul','verde','amarillo','negro','blanco','gris','rosa','morado','naranja','marron'];
  coloresSeleccionados: { [key: string]: boolean } = {};

  get iniciales(): string {
    const partes = this.nombreCompleto().trim().split(/\s+/);
    return ((partes[0]?.[0] || '') + (partes[1]?.[0] || '')).toUpperCase() || '?';
  }

  ngOnInit() {
    if (!isPlatformBrowser(this.platformId)) return;
    this.cargarCategorias();
    const usuario = this.clientService.getUsuarioLocal();
    if (usuario) {
      this.sesionIniciada.set(true);
      this.nombreCompleto.set(usuario.nombre || '');
      this.nombreUsuario.set((usuario.nombre || '').split(' ')[0]);
    }
  }

  abrirMenu(cat: 'mujer' | 'hombre') {
    this.menuExpandido.set(true);
    this.categoriaActual.set(cat);
  }

  salirDeCategoria() {
    this.categoriaActual.set(null);
  }

  cerrarMenu() {
    this.menuExpandido.set(false);
    this.categoriaActual.set(null);
  }

  irA(idCategoria: number, nombre: string) {
    this.router.navigate(['/productos'], { queryParams: { genero: this.categoriaActual(), categoria: idCategoria, nombre } });
  }

  irAGenero(genero: string) {
    this.router.navigate(['/productos'], { queryParams: { genero } });
  }

  toggleFiltros() { this.mostrarFiltros.update(v => !v); }

  buscar() {
    const tallasSeleccionadas = this.tallas.filter(t => this.tallasMap[t]);
    const coloresSelect = this.colores.filter(c => this.coloresSeleccionados[c]);
    const filterParams: any = {};
    if (this.query.trim()) filterParams.q = this.query.trim();
    if (this.minPrecio != null) filterParams.minPrecio = this.minPrecio;
    if (this.maxPrecio != null) filterParams.maxPrecio = this.maxPrecio;
    if (tallasSeleccionadas.length) filterParams.tallas = tallasSeleccionadas.join(',');
    if (coloresSelect.length) filterParams.colores = coloresSelect.join(',');
    if (Object.keys(filterParams).length === 0) return;
    this.router.navigate(['/productos'], { queryParams: filterParams });
    this.mostrarFiltros.set(false);
  }

  resetearFiltros() {
    this.tallasMap = {};
    this.coloresSeleccionados = {};
    this.minPrecio = null;
    this.maxPrecio = null;
    this.query = '';
    this.mostrarFiltros.set(false);
  }

  pulsarEnter(event: KeyboardEvent) {
    if (event.key === 'Enter') this.buscar();
  }

  async cargarCategorias() {
    try {
      const [catMujer, catHombre] = await Promise.all([
        firstValueFrom(this.clientService.getCategorias('mujer')),
        firstValueFrom(this.clientService.getCategorias('hombre'))
      ]);
      this.subcategorias.set({
        mujer:  (catMujer  as any[]).map((c: any) => ({ label: c.nombre, id: c.id_categoria })),
        hombre: (catHombre as any[]).map((c: any) => ({ label: c.nombre, id: c.id_categoria }))
      });
    } catch {}
  }
}
