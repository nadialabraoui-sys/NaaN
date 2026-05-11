import { Component, OnInit, PLATFORM_ID, inject, signal } from '@angular/core';
import { isPlatformBrowser } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router, RouterModule } from '@angular/router';
import { ClientService } from '../../services/client.service';

@Component({
  selector: 'app-registro',
  standalone: true,
  imports: [FormsModule, RouterModule],
  templateUrl: './registro.html',
})
export class Registro implements OnInit {

  private clientService = inject(ClientService);
  private router = inject(Router);
  private platformId = inject(PLATFORM_ID);

  nombre = '';
  apellido  = '';
  segundoApellido = '';
  email = '';
  contrasena = '';
  repetirContrasena = '';
  fechaNacimiento = '';
  aceptaCondiciones = false;
  aceptaPrivacidad = false;
  recibirNotificaciones = false;

  cargando = signal(false);
  error = signal('');
  verContrasena = false;
  verRepetir = false;

  ngOnInit() {
    if (isPlatformBrowser(this.platformId) && this.clientService.getToken()) {
      this.router.navigate(['/perfil']);
    }
  }

  private soloLetras = /^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ\s]+$/;

  crearCuenta() {
    this.error.set('');

    if (!this.nombre.trim()) {
      this.error.set('El nombre es obligatorio.'); return;
    }
    if (!this.soloLetras.test(this.nombre.trim())) {
      this.error.set('El nombre solo puede contener letras.'); return;
    }
    if (!this.apellido.trim()) {
      this.error.set('El apellido es obligatorio.'); return;
    }
    if (!this.soloLetras.test(this.apellido.trim())) {
      this.error.set('El apellido solo puede contener letras.'); return;
    }
    if (this.segundoApellido.trim() && !this.soloLetras.test(this.segundoApellido.trim())) {
      this.error.set('El segundo apellido solo puede contener letras.'); return;
    }
    if (!this.email.trim() || !this.email.includes('@')) {
      this.error.set('Introduce un correo electrónico válido.'); return;
    }
    if (!this.fechaNacimiento) {
      this.error.set('La fecha de nacimiento es obligatoria.'); return;
    }
    const hoy = new Date();
    const nac = new Date(this.fechaNacimiento);
    const edad = hoy.getFullYear() - nac.getFullYear() -
      (hoy < new Date(hoy.getFullYear(), nac.getMonth(), nac.getDate()) ? 1 : 0);
    if (edad < 12) {
      this.error.set('Debes tener al menos 12 años para registrarte.'); return;
    }
    if (!this.aceptaCondiciones) {
      this.error.set('Debes aceptar los Términos y Condiciones para continuar.'); return;
    }
    if (!this.aceptaPrivacidad) {
      this.error.set('Debes aceptar la Política de Privacidad para continuar.'); return;
    }
    if (this.contrasena.length < 6) {
      this.error.set('La contraseña debe tener al menos 6 caracteres.'); return;
    }
    if (this.contrasena !== this.repetirContrasena) {
      this.error.set('Las contraseñas no coinciden.'); return;
    }

    this.cargando.set(true);

    const nombreCompleto = [this.nombre, this.apellido, this.segundoApellido]
      .filter(s => s.trim())
      .join(' ');

    this.clientService.registro({
      nombre: nombreCompleto,
      email: this.email,
      contrasena: this.contrasena,
      fecha_nacimiento: this.fechaNacimiento || null
    }).subscribe({
      next: () => {
        this.cargando.set(false);
        this.router.navigate(['/login']);
      },
      error: (err) => {
        this.cargando.set(false);
        if (err.status === 422) {
          const errores = err.error?.errors;
          if (errores?.email) {
            this.error.set('Este correo electrónico ya está registrado');
          } else if (errores?.contrasena) {
            this.error.set('La contraseña debe tener al menos 6 caracteres');
          } else {
            this.error.set('Datos no válidos: ' + JSON.stringify(errores));
          }
        } else if (err.status === 0) {
          this.error.set('No se puede conectar con el servidor. Comprueba que el backend está activo');
        } else {
          this.error.set(`Error ${err.status}: ${err.error?.message || 'Error al crear la cuenta'}`);
        }
      }
    });
  }
}
