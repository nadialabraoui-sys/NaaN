import { Component, inject, signal } from '@angular/core';
import { AsyncPipe } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Observable, of } from 'rxjs';
import { tap, map, catchError, startWith } from 'rxjs/operators';
import { ClientService } from '../../../services/client.service';

interface PerfilVM {
  cargando: boolean;
  error: string;
}

@Component({
  selector: 'app-mis-datos',
  standalone: true,
  imports: [AsyncPipe, FormsModule],
  templateUrl: './perfil.html',
})
export class MisDatos {

  private clientService = inject(ClientService);

  usuario           = signal<any>(null);
  editandoPersonal  = signal(false);
  editandoContacto  = signal(false);
  guardandoPersonal = signal(false);
  guardandoContacto = signal(false);
  errorPersonal     = signal('');
  errorContacto     = signal('');
  okPersonal        = signal('');
  okContacto        = signal('');
  guardandoContra   = signal(false);
  errorContra       = signal('');
  okContra          = signal('');

  nombreEdit           = '';
  fechaEdit            = '';
  emailEdit            = '';
  codigoPaisEdit       = '+34';
  telefonoNumeroEdit   = '';
  contraActual         = '';
  contraNueva          = '';
  contraRepetir        = '';
  verActual            = false;
  verNueva             = false;
  verRepetir           = false;

  readonly paises = [
    { codigo: '+34',  bandera: '🇪🇸', nombre: 'España' },
    { codigo: '+351', bandera: '🇵🇹', nombre: 'Portugal' },
    { codigo: '+33',  bandera: '🇫🇷', nombre: 'Francia' },
    { codigo: '+39',  bandera: '🇮🇹', nombre: 'Italia' },
    { codigo: '+49',  bandera: '🇩🇪', nombre: 'Alemania' },
    { codigo: '+44',  bandera: '🇬🇧', nombre: 'Reino Unido' },
    { codigo: '+1',   bandera: '🇺🇸', nombre: 'Estados Unidos' },
    { codigo: '+52',  bandera: '🇲🇽', nombre: 'México' },
    { codigo: '+54',  bandera: '🇦🇷', nombre: 'Argentina' },
  ];

  vm$: Observable<PerfilVM> = this.clientService.getMiPerfil().pipe(
    tap((perfil: any) => this.usuario.set(perfil)),
    map(() => ({ cargando: false, error: '' })),
    catchError(() => of({ cargando: false, error: 'No se han podido cargar los datos del perfil' })),
    startWith({ cargando: true, error: '' })
  );

  get iniciales(): string {
    const partes = (this.usuario()?.nombre || '').trim().split(/\s+/);
    const a = partes[0]?.[0] || '';
    const b = partes[1]?.[0] || '';
    return (a + b).toUpperCase() || '?';
  }

  abrirPersonal() {
    this.nombreEdit   = this.usuario()?.nombre || '';
    this.fechaEdit    = this.usuario()?.fecha_nacimiento?.substring(0, 10) || '';
    this.errorPersonal.set('');
    this.okPersonal.set('');
    this.editandoPersonal.set(true);
  }

  cancelarPersonal() { this.editandoPersonal.set(false); }

  soloNumeros(e: KeyboardEvent) {
    if (!/\d/.test(e.key)) e.preventDefault();
  }

  guardarPersonal() {
    const nombre = this.nombreEdit.trim();
    if (!nombre) { this.errorPersonal.set('El nombre no puede estar vacío.'); return; }
    if (!/^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ\s]+$/.test(nombre)) {
      this.errorPersonal.set('El nombre solo puede contener letras.'); return;
    }
    this.guardandoPersonal.set(true);
    this.errorPersonal.set('');

    this.clientService.actualizarMiPerfil({
      nombre: this.nombreEdit.trim(),
      fecha_nacimiento: this.fechaEdit || null
    }).subscribe({
      next: (u: any) => {
        this.usuario.set(u);
        this.clientService.actualizarUsuarioLocal(u);
        this.editandoPersonal.set(false);
        this.guardandoPersonal.set(false);
        this.okPersonal.set('Datos actualizados correctamente.');
        setTimeout(() => this.okPersonal.set(''), 3500);
      },
      error: () => {
        this.errorPersonal.set('No se han podido guardar los cambios.');
        this.guardandoPersonal.set(false);
      }
    });
  }

  abrirContacto() {
    this.emailEdit = this.usuario()?.email || '';
    const tel = this.usuario()?.telefono || '';
    const match = tel.match(/^(\+\d+)\s*(.*)$/);
    if (match) {
      this.codigoPaisEdit = match[1];
      this.telefonoNumeroEdit = match[2];
    } else {
      this.codigoPaisEdit = '+34';
      this.telefonoNumeroEdit = tel;
    }
    this.errorContacto.set('');
    this.okContacto.set('');
    this.editandoContacto.set(true);
  }

  cancelarContacto() { this.editandoContacto.set(false); }

  guardarContacto() {
    if (!this.emailEdit.trim() || !this.emailEdit.includes('@')) {
      this.errorContacto.set('Introduce un email válido.'); return;
    }
    const tel = this.telefonoNumeroEdit.trim();
    if (tel && !/^\d+$/.test(tel)) {
      this.errorContacto.set('El teléfono solo puede contener números.'); return;
    }
    if (tel && tel.length > 9) {
      this.errorContacto.set('El teléfono no puede superar los 9 dígitos.'); return;
    }
    this.guardandoContacto.set(true);
    this.errorContacto.set('');

    this.clientService.actualizarMiPerfil({
      email: this.emailEdit.trim(),
      telefono: this.telefonoNumeroEdit.trim()
        ? `${this.codigoPaisEdit} ${this.telefonoNumeroEdit.trim()}`
        : null
    }).subscribe({
      next: (u: any) => {
        this.usuario.set(u);
        this.clientService.actualizarUsuarioLocal(u);
        this.editandoContacto.set(false);
        this.guardandoContacto.set(false);
        this.okContacto.set('Datos actualizados correctamente.');
        setTimeout(() => this.okContacto.set(''), 3500);
      },
      error: (err: any) => {
        this.errorContacto.set(
          err?.error?.errors?.email
            ? 'Ese email ya está en uso por otra cuenta.'
            : 'No se han podido guardar los cambios.'
        );
        this.guardandoContacto.set(false);
      }
    });
  }

  guardarContrasena() {
    if (!this.contraActual || !this.contraNueva || !this.contraRepetir) {
      this.errorContra.set('Rellena todos los campos.'); return;
    }
    if (this.contraNueva.length < 6) {
      this.errorContra.set('La nueva contraseña debe tener al menos 6 caracteres.'); return;
    }
    if (this.contraNueva !== this.contraRepetir) {
      this.errorContra.set('Las contraseñas no coinciden.'); return;
    }
    this.guardandoContra.set(true);
    this.errorContra.set('');

    this.clientService.cambiarContrasena({
      contrasena_actual: this.contraActual,
      nueva_contrasena:  this.contraNueva
    }).subscribe({
      next: () => {
        this.contraActual = '';
        this.contraNueva = '';
        this.contraRepetir = '';
        this.guardandoContra.set(false);
        this.okContra.set('Contraseña cambiada correctamente.');
        setTimeout(() => this.okContra.set(''), 4000);
      },
      error: (err: any) => {
        this.errorContra.set(
          err?.error?.Error === 'Contrasena actual incorrecta'
            ? 'La contraseña actual no es correcta.'
            : 'No se ha podido cambiar la contraseña.'
        );
        this.guardandoContra.set(false);
      }
    });
  }

  formatearFecha(fecha: string): string {
    if (!fecha) return '—';
    return new Date(fecha).toLocaleDateString('es-ES', {
      day: '2-digit', month: 'long', year: 'numeric'
    });
  }
}
