import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { AdminService } from '../services/admin.service';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-pedidos',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './pedidos.html',
  styleUrl: './pedidos.css',
})
export class Pedidos implements OnInit {

  todosPedidos: any[] = [];
  pedidos: any[] = [];
  usuarios: any[] = [];

  constructor(private adminService: AdminService, private cdr: ChangeDetectorRef) {}

  ngOnInit() {
    this.cargar();
  }

  cargar() {
    this.adminService.getCategorias().subscribe(() => {
      this.adminService.getUsuarios().subscribe((users: any) => {
        this.usuarios = users;
        this.adminService.getPedidos().subscribe((data: any) => {
          this.todosPedidos = data;
          this.pedidos = data;
          this.cdr.detectChanges();
        });
      });
    });
  }

  avanzarEstado(pedido: any) {
    if (confirm(`¿Avanzar estado del pedido #${pedido.id_pedido}?`)) {
      this.adminService.avanzarEstado(pedido.id_pedido).subscribe({
        next: () => this.cargar(),
        error: (err) => console.log('avanzar error:', err)
      });
    }
  }

  cancelarPedido(pedido: any) {
    if (confirm(`¿Cancelar el pedido #${pedido.id_pedido}?`)) {
      this.adminService.cancelarPedido(pedido.id_pedido).subscribe({
        next: () => this.cargar(),
        error: (err) => console.log('cancelar error:', err)
      });
    }
  }

  puedeAvanzar(estado: string): boolean {
    return estado !== 'entregado' && estado !== 'cancelado';
  }

  puedeCancelar(estado: string): boolean {
    return estado !== 'entregado' && estado !== 'cancelado';
  }

  // Filtrado
  filtroBusqueda = '';
  filtroEstado = '';

  aplicarFiltros() {
    this.pedidos = this.todosPedidos.filter(p => {
      const coincideId = p.id_pedido.toString().includes(this.filtroBusqueda);
      const coincideEstado = !this.filtroEstado || p.estado === this.filtroEstado;
      return coincideId && coincideEstado;
    });
  }

  // Nombre en vez de ID
  getEmailUsuario(id: number): string {
    const user = this.usuarios.find(u => u.id_usuario === id);
    return user ? user.email : '-';
  }
}