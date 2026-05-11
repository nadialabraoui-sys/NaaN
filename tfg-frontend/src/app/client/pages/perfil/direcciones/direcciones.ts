import { Component, inject, signal } from '@angular/core';
import { AsyncPipe } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Observable, of, firstValueFrom } from 'rxjs';
import { tap, map, catchError, startWith } from 'rxjs/operators';
import { ClientService } from '../../../services/client.service';

interface DireccionesVM {
  cargando: boolean;
  error: string;
}

@Component({
  selector: 'app-mis-direcciones',
  standalone: true,
  imports: [AsyncPipe, FormsModule],
  templateUrl: './direcciones.html',
})
export class MisDirecciones {

  private clientService = inject(ClientService);

  direcciones     = signal<any[]>([]);
  mostrarFormulario = signal(false);
  guardando       = signal(false);
  errorForm       = signal('');
  eliminandoId    = signal<number | null>(null);
  errorEliminar   = signal('');

  calle        = '';
  numero       = '';
  ciudad       = '';
  provincia    = '';
  codigoPostal = '';
  pais         = 'España';

  readonly paises = [
    'España', 'Portugal', 'Francia', 'Italia', 'Alemania',
    'Reino Unido', 'Estados Unidos', 'México', 'Argentina'
  ];

  private idUsuario: number | null = this.clientService.getUsuarioLocal()?.id_usuario ?? null;

  vm$: Observable<DireccionesVM> = this.clientService.getMisDirecciones().pipe(
    tap((dirs: any[]) => this.direcciones.set(dirs)),
    map(() => ({ cargando: false, error: '' })),
    catchError(() => of({ cargando: false, error: 'No se han podido cargar las direcciones.' })),
    startWith({ cargando: true, error: '' })
  );

  abrirFormulario() {
    this.calle = '';
    this.numero = '';
    this.ciudad = '';
    this.provincia = '';
    this.codigoPostal = '';
    this.pais = 'España';
    this.errorForm.set('');
    this.mostrarFormulario.set(true);
  }

  get cpValido(): boolean {
    return /^\d{5}$/.test(this.codigoPostal.trim());
  }

  cancelarFormulario() {
    this.mostrarFormulario.set(false);
  }

  async guardar() {
    if (!this.calle.trim()) { this.errorForm.set('La calle es obligatoria.'); return; }
    if (!/^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ\s.]+$/.test(this.calle.trim())) {
      this.errorForm.set('La calle solo puede contener letras y puntos.'); return;
    }
    if (!this.numero.trim()) { this.errorForm.set('El número es obligatorio.'); return; }
    if (!/^\d+$/.test(this.numero.trim())) {
      this.errorForm.set('El número solo puede contener dígitos.'); return;
    }
    if (!this.ciudad.trim()) { this.errorForm.set('La ciudad es obligatoria.'); return; }
    if (!/^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ\s]+$/.test(this.ciudad.trim())) {
      this.errorForm.set('La ciudad solo puede contener letras.'); return;
    }
    if (!this.provincia.trim()) { this.errorForm.set('La provincia es obligatoria.'); return; }
    if (!/^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ\s]+$/.test(this.provincia.trim())) {
      this.errorForm.set('La provincia solo puede contener letras.'); return;
    }
    if (!this.cpValido) { this.errorForm.set('El código postal debe tener 5 dígitos.'); return; }
    if (!this.idUsuario) return;

    this.guardando.set(true);
    this.errorForm.set('');

    try {
      const nueva = await firstValueFrom(this.clientService.addDireccion({
        id_usuario: this.idUsuario,
        calle: this.calle.trim(),
        numero: this.numero.trim(),
        ciudad: this.ciudad.trim(),
        provincia: this.provincia.trim(),
        codigo_postal: this.codigoPostal.trim(),
        pais: this.pais
      }));
      this.direcciones.update(ds => [...ds, nueva]);
      this.mostrarFormulario.set(false);
    } catch {
      this.errorForm.set('No se ha podido guardar la dirección.');
    } finally {
      this.guardando.set(false);
    }
  }

  async eliminar(direccion: any) {
    this.eliminandoId.set(direccion.id_direccion);
    this.errorEliminar.set('');
    try {
      await firstValueFrom(this.clientService.deleteDireccion(direccion.id_direccion));
      this.direcciones.update(ds => ds.filter(d => d.id_direccion !== direccion.id_direccion));
    } catch {
      this.errorEliminar.set('No se ha podido eliminar la dirección.');
    } finally {
      this.eliminandoId.set(null);
    }
  }
}
