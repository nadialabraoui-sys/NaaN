import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { AdminService } from '../services/admin.service';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-auditoria',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './auditoria.html',
  styleUrl: './auditoria.css',
})
export class Auditoria implements OnInit {

  todasAuditorias: any[] = [];
  auditorias: any[] = [];

  constructor(private adminService: AdminService, private cdr: ChangeDetectorRef) {}

  ngOnInit() {
    this.cargar();
  }

  cargar() {
    this.adminService.getCategorias().subscribe(() => {
      this.adminService.getAuditorias().subscribe((data: any) => {
        const invertido = data.reverse();
        this.todasAuditorias = invertido;
        this.auditorias = [...invertido];
        this.cdr.detectChanges();
      });
    });
  }

  // Filtrado
  filtroBusqueda = '';
  filtroFecha = '';

  aplicarFiltros() {
    this.auditorias = this.todasAuditorias.filter(a => {
      const coincideTabla = a.tabla_afectada.toLowerCase().includes(this.filtroBusqueda.toLowerCase());
      const coincideFecha = !this.filtroFecha || a.fecha.includes(this.filtroFecha);
      return coincideTabla && coincideFecha;
    });
  }
}