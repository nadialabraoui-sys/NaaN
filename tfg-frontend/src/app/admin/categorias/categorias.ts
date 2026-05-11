import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { AdminService } from '../services/admin.service';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-categorias',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './categorias.html',
  styleUrl: './categorias.css',
})
export class Categorias implements OnInit {

  categorias: any[] = [];

  constructor(private adminService: AdminService, private cdr: ChangeDetectorRef) {}

  ngOnInit() {
    this.cargar();
  }

  cargar() {
    this.adminService.getCategorias().subscribe((cats: any) => {
      this.categorias = cats;
      this.cdr.detectChanges();
    });
  }

  // Para el formulario
  modalAbierto = false;
  categoriaSeleccionada: any = null;
  formulario = {
    nombre: '',
    descripcion: ''
  };

  abrirModal(categoria: any) {
    this.categoriaSeleccionada = categoria;
    this.formulario = {
      nombre: categoria.nombre,
      descripcion: categoria.descripcion
    };
    this.modalAbierto = true;
  }

  cerrarModal() {
    this.modalAbierto = false;
    this.categoriaSeleccionada = null;
    this.cdr.detectChanges();
  }

  guardarCategoria() {
    if (this.categoriaSeleccionada) {
      this.adminService.editarCategoria(this.categoriaSeleccionada.id_categoria, this.formulario).subscribe({
        next: () => {
          this.cerrarModal();
          this.cargar();
        },
        error: (err) => console.log('editar error:', err)
      });
    } else {
      this.adminService.crearCategoria(this.formulario).subscribe({
        next: () => {
          this.cerrarModal();
          this.cargar();
        },
        error: (err) => console.log('crear error:', err)
      });
    }
  }

  eliminarCategoria(id: number) {
    if (confirm('¿Seguro que quieres eliminar esta categoría?')) {
      this.adminService.eliminarCategoria(id).subscribe({
        next: () => this.cargar(),
        error: (err) => console.log('eliminar error:', err)
      });
    }
  }

  // Modal para crear
  abrirModalCrear() {
    this.categoriaSeleccionada = null;
    this.formulario = {
      nombre: '',
      descripcion: ''
    };
    this.modalAbierto = true;
  }

  // Filtrado
  filtroBusqueda = '';

  get categoriasFiltradas(): any[] {
    return this.categorias.filter(c =>
      c.nombre.toLowerCase().includes(this.filtroBusqueda.toLowerCase())
    );
  }
}