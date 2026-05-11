import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { AdminService } from '../services/admin.service';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-productos',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './productos.html',
  styleUrl: './productos.css',
})
export class Productos implements OnInit {

  productos: any[] = [];
  categorias: any[] = [];

  constructor(private adminService: AdminService, private cdr: ChangeDetectorRef) {}

  ngOnInit() {
    this.cargar();
  }

  cargar() {
    this.adminService.getCategorias().subscribe((cats: any) => {
      this.categorias = cats;
      this.adminService.getProductos().subscribe((prods: any) => {
        this.productos = prods;
        this.cdr.detectChanges();
      });
    });
  }

  getNombreCategoria(id: number): string {
    const cat = this.categorias.find(c => c.id_categoria === id);
    return cat ? cat.nombre : '-';
  }

  toggleActivo(producto: any) {
    const accion = producto.activo == 1 ? 'desactivar' : 'activar';
    if (confirm(`¿Seguro que quieres ${accion} este producto?`)) {
      this.adminService.toggleProducto(producto.id_producto).subscribe({
        next: () => {
          this.cargar();
        },
        error: (err) => {
          console.log('toggle error:', err);
        }
      });
    }
  }

  // Para el formulario
  modalAbierto = false;
  productoSeleccionado: any = null;
  formulario = {
    nombre: '',
    descripcion: '',
    precio: 0,
    stock: 0,
    id_categoria: '',
    imagen: '',
    color: '',
    sexo: '',
    talla: ''
  };

  abrirModal(producto: any) {
    this.productoSeleccionado = producto;
    this.formulario = {
      nombre: producto.nombre,
      descripcion: producto.descripcion,
      precio: producto.precio,
      stock: producto.stock,
      id_categoria: producto.id_categoria,
      imagen: producto.imagen,
      color: producto.color,
      sexo: producto.sexo,
      talla: producto.talla
    };
    this.modalAbierto = true;
  }

  cerrarModal() {
    this.modalAbierto = false;
    this.productoSeleccionado = null;
    this.cdr.detectChanges();
  }

  guardarProducto() {
    if (this.productoSeleccionado) {
      this.adminService.editarProducto(this.productoSeleccionado.id_producto, this.formulario).subscribe({
        next: () => {
          this.cerrarModal();
          this.cargar();
        },
        error: (err) => console.log('editar error:', err)
      });
    } else {
      this.adminService.crearProducto(this.formulario).subscribe({
        next: () => {
          this.cerrarModal();
          this.cargar();
        },
        error: (err) => console.log('crear error:', err)
      });
    }
  }



  // Modal para crear
  abrirModalCrear() {
    this.productoSeleccionado = null;
    this.formulario = {
      nombre: '',
      descripcion: '',
      precio: 0,
      stock: 0,
      id_categoria: '',
      imagen: '',
      color: '',
      sexo: '',
      talla: ''
    };
    this.modalAbierto = true;
  }

  readonly colores = ['rojo','azul','verde','amarillo','negro','blanco','gris','rosa','morado','naranja','marron'];

  // Filtrado
  filtroBusqueda = '';
  filtroCategoria = '';
  filtroEstado = '';

  // Hace de variable sin necesidad de poner () y angular en el HTML lo detecta como variable y no como funcion
  get productosFiltrados(): any[] {
    return this.productos.filter(p => {
      const coincideNombre = p.nombre.toLowerCase().includes(this.filtroBusqueda.toLowerCase());
      const coincideCategoria = !this.filtroCategoria || p.id_categoria == this.filtroCategoria;
      const coincideEstado = this.filtroEstado === '' || p.activo == this.filtroEstado;
      return coincideNombre && coincideCategoria && coincideEstado;
    });
  }
}