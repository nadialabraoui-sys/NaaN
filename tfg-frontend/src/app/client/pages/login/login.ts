import { Component, OnInit, PLATFORM_ID, inject, ChangeDetectorRef } from '@angular/core';
import { CommonModule, isPlatformBrowser } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router, RouterModule } from '@angular/router';
import { ClientService } from '../../services/client.service';

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [CommonModule, FormsModule, RouterModule],
  templateUrl: './login.html',
})
export class Login implements OnInit {

  private clientService = inject(ClientService);
  private router = inject(Router);
  private platformId = inject(PLATFORM_ID);
  private cdr = inject(ChangeDetectorRef);

  email = '';
  contrasena = '';
  recordar = false;
  cargando = false;
  error = '';
  verContrasena = false;

  ngOnInit() {
    if (isPlatformBrowser(this.platformId) && this.clientService.getToken()) {
      this.router.navigate(['/perfil']);
    }
  }

  acceder() {
    this.error = '';
    this.cargando = true;

    this.clientService.login(this.email, this.contrasena).subscribe({
      next: (res: any) => {
        const esAdmin = res.usuario?.rol === 'admin';
        this.clientService.guardarSesion(res.token, res.usuario, this.recordar || esAdmin);
        this.cargando = false;
        this.router.navigate([esAdmin ? '/admin' : '/perfil']);
      },
      error: () => {
        this.cargando = false;
        this.error = 'Correo electrónico o contraseña incorrectos';
        this.cdr.detectChanges();
      }
    });
  }
}
