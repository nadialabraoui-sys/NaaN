import { Component, signal, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Observable, of, firstValueFrom } from 'rxjs';
import { tap, map, catchError, startWith } from 'rxjs/operators';
import { ClientService } from '../../../services/client.service';

interface MetodosPagoVM {
  cargando: boolean;
  error: string;
}

@Component({
  selector: 'app-mis-metodos-pago',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './metodos-pago.html',
})
export class MisMetodosPago {

  private clientService = inject(ClientService);

  metodos = signal<any[]>([]);
  mostrarFormulario = signal(false);
  guardando = signal(false);
  errorForm = signal('');
  eliminandoId = signal<number | null>(null);
  toglandoId = signal<number | null>(null);

  tipoSeleccionado: 'paypal' | 'tarjeta' | 'bizum' | 'google_pay' = 'tarjeta';
  campoTexto = '';
  fechaNueva = '';
  nombreTitular = '';
  codigoPaisBizum = '+34';
  telefonoNumeroBizum  = '';

  readonly paises: { codigo: string; bandera: string }[] = [
    { codigo: '+34', bandera: '🇪🇸' },
    { codigo: '+351', bandera: '🇵🇹' },
    { codigo: '+33', bandera: '🇫🇷' },
    { codigo: '+39', bandera: '🇮🇹' },
    { codigo: '+49', bandera: '🇩🇪' },
    { codigo: '+44', bandera: '🇬🇧' },
    { codigo: '+1', bandera: '🇺🇸' },
    { codigo: '+52', bandera: '🇲🇽' },
    { codigo: '+54', bandera: '🇦🇷' },
  ];

  readonly tipos: { valor: 'tarjeta' | 'paypal' | 'bizum' | 'google_pay'; label: string }[] = [
    { valor: 'tarjeta', label: 'Tarjeta' },
    { valor: 'paypal', label: 'PayPal' },
    { valor: 'bizum', label: 'Bizum' },
    { valor: 'google_pay', label: 'Google Pay' },
  ];

  private idUsuario: number | null = this.clientService.getUsuarioLocal()?.id_usuario ?? null;

  vm$: Observable<MetodosPagoVM> = this.clientService.getMisMetodosPago().pipe(
    tap((m: any[]) => this.metodos.set(m)),
    map(() => ({ cargando: false, error: '' })),
    catchError(() => of({ cargando: false, error: 'No se han podido cargar los métodos de pago.' })),
    startWith({ cargando: true, error: '' })
  );

  placeholderCampo(): string {
    switch (this.tipoSeleccionado) {
      case 'tarjeta': return '1234 5678 9012 3456';
      case 'paypal': return 'tu@paypal.com';
      case 'bizum': return '+34 600 000 000';
      case 'google_pay': return 'tu@gmail.com';
    }
  }

  labelCampo(): string {
    switch (this.tipoSeleccionado) {
      case 'tarjeta': return 'Número de tarjeta *';
      case 'paypal': return 'Email de PayPal *';
      case 'bizum': return 'Número de teléfono *';
      case 'google_pay': return 'Email de Google *';
    }
  }

  mostrarFecha(): boolean   { return this.tipoSeleccionado === 'tarjeta'; }
  mostrarTitular(): boolean { return this.tipoSeleccionado === 'tarjeta'; }

  abrirFormulario() {
    this.campoTexto = '';
    this.fechaNueva = '';
    this.nombreTitular = '';
    this.codigoPaisBizum = '+34';
    this.telefonoNumeroBizum = '';
    this.errorForm.set('');
    this.tipoSeleccionado = 'tarjeta';
    this.mostrarFormulario.set(true);
  }

  cancelarFormulario() { this.mostrarFormulario.set(false); }

  private mascararTarjeta(numero: string): string {
    return '**** **** **** ' + numero.replace(/\s/g, '').slice(-4);
  }

  async guardarMetodo() {
    if (this.tipoSeleccionado === 'bizum' && !this.telefonoNumeroBizum.trim()) {
      this.errorForm.set('Introduce un número de teléfono.'); return;
    }
    if (this.tipoSeleccionado !== 'bizum' && !this.campoTexto.trim()) {
      this.errorForm.set('Este campo es obligatorio.'); return;
    }
    if (this.tipoSeleccionado === 'tarjeta') {
      const digitos = this.campoTexto.replace(/\s/g, '');
      if (digitos.length !== 16 || !/^\d+$/.test(digitos)) {
        this.errorForm.set('El número de tarjeta debe tener exactamente 16 dígitos.'); return;
      }
      if (!this.fechaNueva) { this.errorForm.set('La fecha de caducidad es obligatoria.'); return; }
      if (!this.nombreTitular.trim()) { this.errorForm.set('El nombre del titular es obligatorio.'); return; }
      if (!/^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ\s]+$/.test(this.nombreTitular.trim())) {
        this.errorForm.set('El nombre del titular solo puede contener letras.'); return;
      }
    }
    if (!this.idUsuario) return;

    this.guardando.set(true);
    this.errorForm.set('');

    const enmascarado = this.tipoSeleccionado === 'tarjeta'
      ? this.mascararTarjeta(this.campoTexto)
      : this.tipoSeleccionado === 'bizum'
        ? `${this.codigoPaisBizum} ${this.telefonoNumeroBizum.trim()}`
        : this.campoTexto.trim();

    try {
      const nuevo = await firstValueFrom(this.clientService.addMetodoPago({
        id_usuario: this.idUsuario,
        tipo: this.tipoSeleccionado,
        numero_enmascarado: enmascarado,
        fecha_expiracion: this.fechaNueva || null,
        es_predeterminado: this.metodos().length === 0 ? 1 : 0
      }));
      this.metodos.update(ms => [...ms, nuevo]);
      this.mostrarFormulario.set(false);
    } catch {
      this.errorForm.set('No se ha podido guardar el método de pago.');
    } finally {
      this.guardando.set(false);
    }
  }

  async togglePredeterminado(metodo: any) {
    if (metodo.es_predeterminado || this.toglandoId()) return;
    this.toglandoId.set(metodo.id_metodo_pago);
    try {
      await firstValueFrom(this.clientService.toggleMetodoPredeterminado(metodo.id_metodo_pago));
      this.metodos.update(ms => ms.map(m => ({
        ...m,
        es_predeterminado: m.id_metodo_pago === metodo.id_metodo_pago ? 1 : 0
      })));
    } finally {
      this.toglandoId.set(null);
    }
  }

  async eliminar(metodo: any) {
    this.eliminandoId.set(metodo.id_metodo_pago);
    try {
      await firstValueFrom(this.clientService.eliminarMetodoPago(metodo.id_metodo_pago));
      this.metodos.update(ms => {
        const filtrado = ms.filter(m => m.id_metodo_pago !== metodo.id_metodo_pago);
        if (metodo.es_predeterminado && filtrado.length > 0) {
          filtrado[0] = { ...filtrado[0], es_predeterminado: 1 };
        }
        return filtrado;
      });
    } finally {
      this.eliminandoId.set(null);
    }
  }

  formatearFecha(fecha: string): string {
    if (!fecha) return '';
    const d = new Date(fecha);
    return `${String(d.getMonth() + 1).padStart(2, '0')}/${d.getFullYear()}`;
  }

  labelTipo(tipo: string): string {
    const labels: Record<string, string> = {
      paypal: 'PayPal', tarjeta: 'Tarjeta', bizum: 'Bizum', google_pay: 'Google Pay'
    };
    return labels[tipo] || tipo;
  }
}
