import { Component, OnInit, PLATFORM_ID, signal, inject } from '@angular/core';
import { isPlatformBrowser } from '@angular/common';
import { Router, RouterModule } from '@angular/router';
import { ClientService } from '../../../services/client.service';

@Component({
  selector: 'app-perfil-layout',
  standalone: true,
  imports: [RouterModule],
  templateUrl: './perfil-layout.html',
})
export class PerfilLayout implements OnInit {

  private clientService = inject(ClientService);
  private router = inject(Router);
  private platformId = inject(PLATFORM_ID);

  nombreUsuario = signal('');
  emailUsuario  = signal('');
  esAdmin = signal(false);
  menuAbierto = signal(false);

  readonly navLinks = [
    { ruta: 'pedidos', label: 'Pedidos' },
    { ruta: 'datos', label: 'Perfil' },
    { ruta: 'favoritos', label: 'Favoritos ❤' },
    { ruta: 'metodos-pago', label: 'Métodos de pago' },
    { ruta: 'direcciones', label: 'Direcciones' },
    { ruta: 'ayuda', label: 'Ayuda' },
    { ruta: 'chat', label: 'Atención al cliente' },
  ];

  get iniciales(): string {
    const partes = this.nombreUsuario().trim().split(/\s+/);
    return ((partes[0]?.[0] || '') + (partes[1]?.[0] || '')).toUpperCase() || '?';
  }

  ngOnInit() {
    if (!isPlatformBrowser(this.platformId)) return;
    const usuario = this.clientService.getUsuarioLocal();
    if (usuario) {
      this.nombreUsuario.set(usuario.nombre || '');
      this.emailUsuario.set(usuario.email || '');
      this.esAdmin.set(usuario.rol === 'admin');
    }
  }

  cerrarSesion() {
    this.clientService.cerrarSesion();
    this.router.navigate(['/']);
  }
}
