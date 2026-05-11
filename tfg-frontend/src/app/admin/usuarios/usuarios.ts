import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { AdminService } from '../services/admin.service';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-usuarios',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './usuarios.html',
  styleUrl: './usuarios.css',
})
export class Usuarios implements OnInit {

  todosUsuarios: any[] = [];
  usuarios: any[] = [];

  constructor(private adminService: AdminService, private cdr: ChangeDetectorRef) {}

  ngOnInit() {
    this.cargar();
  }

  cargar() {
    this.adminService.getCategorias().subscribe(() => {
      this.adminService.getUsuarios().subscribe((data: any) => {
        this.todosUsuarios = data;
        this.usuarios = data;
        this.cdr.detectChanges();
      });
    });
  }

  toggleAdmin(usuario: any) {
    const accion = usuario.rol === 'admin' ? 'quitar admin' : 'hacer admin';
    if (confirm(`¿Seguro que quieres ${accion} a ${usuario.nombre}?`)) {
      this.adminService.toggleAdmin(usuario.id_usuario).subscribe({
        next: () => this.cargar(),
        error: (err) => console.log('toggle error:', err)
      });
    }
  }

  // Filtrado
  filtroBusqueda = '';
  filtroRol = '';

  aplicarFiltros() {
    this.usuarios = this.todosUsuarios.filter(u => {
      const coincideNombre = u.nombre.toLowerCase().includes(this.filtroBusqueda.toLowerCase());
      const coincideRol = !this.filtroRol || u.rol === this.filtroRol;
      return coincideNombre && coincideRol;
    });
  }
}