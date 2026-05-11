import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
import { AdminService } from '../services/admin.service';

@Component({
  selector: 'app-dashboard',
  standalone: true,
  templateUrl: './dashboard.html',
  styleUrl: './dashboard.css'
})
export class Dashboard implements OnInit {

  totalProductos = 0;
  totalUsuarios = 0;
  totalPedidos = 0;
  totalCategorias = 0;
  totalAvatares = 0;

  constructor(private adminService: AdminService, private cdr: ChangeDetectorRef) {}

  ngOnInit() {
    this.adminService.getProductos().subscribe((data: any) => {
      this.totalProductos = data.length;
      this.cdr.detectChanges();
    });

    this.adminService.getUsuarios().subscribe((data: any) => {
      this.totalUsuarios = data.length;
      this.cdr.detectChanges();
    });

    this.adminService.getPedidos().subscribe((data: any) => {
      this.totalPedidos = data.length;
      this.cdr.detectChanges();
    });

    this.adminService.getCategorias().subscribe((data: any) => {
      this.totalCategorias = data.length;
      this.cdr.detectChanges();
    });

    this.adminService.getAvatares().subscribe((data: any) => {
      this.totalAvatares = data.length;
      this.cdr.detectChanges();
    });
  }
}