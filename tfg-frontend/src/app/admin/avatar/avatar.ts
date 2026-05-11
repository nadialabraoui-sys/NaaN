import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { AdminService } from '../services/admin.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-avatar',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './avatar.html',
  styleUrl: './avatar.css',
})
export class Avatar implements OnInit {

  avatares: any[] = [];
  usuarios: any[] = [];

  constructor(private adminService: AdminService, private cdr: ChangeDetectorRef, private router: Router) {}

  ngOnInit() {
    this.cargar();
  }

  cargar() {
    this.adminService.getCategorias().subscribe(() => {
      this.adminService.getUsuarios().subscribe((users: any) => {
        this.usuarios = users;
        this.adminService.getAvatares().subscribe((data: any) => {
          this.avatares = data;
          this.cdr.detectChanges();
        });
      });
    });
  }

  getEmailUsuario(id: number): string {
    const user = this.usuarios.find(u => u.id_usuario === id);
    return user ? user.email : '-';
  }

  eliminarAvatar(id: number) {
    if (confirm('¿Seguro que quieres eliminar este avatar?')) {
      this.adminService.eliminarAvatar(id).subscribe({
        next: () => this.recargar(),
        error: (err) => console.log('eliminar error:', err)
      });
    }
  }

  recargar() {
    this.router.navigateByUrl('/', { skipLocationChange: true }).then(() => {
      this.router.navigate(['/admin/avatar']);
    });
  }
}