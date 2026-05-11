import { Component, OnDestroy, NgZone, PLATFORM_ID, inject, signal, OnInit } from '@angular/core';
import { AsyncPipe, DecimalPipe, isPlatformBrowser } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { RouterModule, Router } from '@angular/router';
import { forkJoin, of, firstValueFrom, Observable } from 'rxjs';
import { switchMap, map, catchError, startWith, tap } from 'rxjs/operators';
import { loadStripe } from '@stripe/stripe-js';
import { ClientService } from '../../services/client.service';
import { environment } from '../../../../environments/environment';

const STRIPE_PUBLISHABLE_KEY = environment.stripeKey;

interface CheckoutVM {
  items: any[];
  direcciones: any[];
  cargando: boolean;
  error: string;
}

@Component({
  selector: 'app-checkout',
  standalone: true,
  imports: [AsyncPipe, DecimalPipe, FormsModule, RouterModule],
  templateUrl: './checkout.html',
})

export class Checkout implements OnInit, OnDestroy {

  private clientService = inject(ClientService);
  private router = inject(Router);
  private platformId = inject(PLATFORM_ID);
  private ngZone = inject(NgZone);

  vm$!: Observable<CheckoutVM>;

  metodosGuardados = signal<any[]>([]);
  idMetodoPago: number | null = null;
  idDireccion: number | null = null;

  private _items:    any[]         = [];
  private idUsuario: number | null = null;

  procesando = signal(false);
  errorPago = signal('');
  mostrarFormulario = signal(false);
  guardando = signal(false);
  errorForm = signal('');
  mostrarStripeModal = signal(false);
  stripeError = signal('');
  confirmando = signal(false);

  tipoSeleccionado: 'tarjeta' | 'paypal' | 'bizum' | 'google_pay' = 'tarjeta';
  campoTexto = '';
  fechaNueva = '';
  nombreTitular = '';
  codigoPaisBizum = '+34';
  telefonoNumeroBizum  = '';

  private stripeClientSecret = '';
  private stripe: any = null;
  private cardElement: any = null;

  GASTOS_ENVIO = 5.99;

  tipos: { valor: 'tarjeta' | 'paypal' | 'bizum' | 'google_pay'; label: string }[] = [
    { valor: 'tarjeta', label: 'Tarjeta'},
    { valor: 'paypal', label: 'PayPal'},
    { valor: 'bizum', label: 'Bizum'},
    { valor: 'google_pay', label: 'Google Pay' },
  ];

  paises = [
    { codigo: '+34',bandera: 'ES'},
    { codigo: '+351', bandera: '🇵🇹' },
    { codigo: '+33',bandera: '🇫🇷' },
    { codigo: '+39', bandera: '🇮🇹' },
    { codigo: '+49', bandera: '🇩🇪' },
    { codigo: '+44', bandera: '🇬🇧' },
    { codigo: '+1', bandera: '🇺🇸' },
    { codigo: '+52',bandera: '🇲🇽' },
    { codigo: '+54',bandera: '🇦🇷'},
  ];

  ngOnInit() {
    if (!isPlatformBrowser(this.platformId)) return;

    this.idUsuario = this.clientService.getUsuarioLocal()?.id_usuario ?? null;

    this.ngZone.runOutsideAngular(() =>
      loadStripe(STRIPE_PUBLISHABLE_KEY).then(s => { this.stripe = s; })
    );

    this.vm$ = this.cargarCheckout();
  }

  ngOnDestroy() {
    this.destruirCardElement();
  }

private cargarCheckout(): Observable<CheckoutVM> {

  const estadoInicial: CheckoutVM = { items: [], direcciones: [], cargando: true,  error: '' };
  const estadoError: CheckoutVM = { items: [], direcciones: [], cargando: false, error: 'No se pudo cargar el resumen.' };

  //pide todos los datos
  return forkJoin({
    metodos: this.clientService.getMisMetodosPago().pipe(catchError(() => of<any[]>([]))),
    direcciones: this.clientService.getMisDirecciones().pipe(catchError(() => of<any[]>([]))),
    detalles: this.clientService.getMisDetallesCarrito().pipe(catchError(() => of<any[]>([])))
  }).pipe(

    // guardamos metodos y direcciones en una variable para mostrar
  tap(({ metodos, direcciones }) => {
  this.metodosGuardados.set(metodos);

  this.idMetodoPago = metodos.find((m: any) => m.es_predeterminado)?.id_metodo_pago 
    ?? metodos[0]?.id_metodo_pago 
    ?? null;

  this.idDireccion = direcciones[0]?.id_direccion ?? null;
}),

  //saco metodos de pago para evitar recargas innecesarias al guardar uno nuevo
    switchMap(({ direcciones, detalles }) => {
      if (!detalles?.length) {
        return of({ direcciones, detalles: [], productos: [] });
      }

      //pide todos los productos que coincidan con la id y si hay algun error devuelve null
      const peticionesProductos = detalles.map((detalle: any) =>
        this.clientService.getProducto(detalle.id_producto).pipe(
          catchError(() => of(null))
        )
      );

      return forkJoin(peticionesProductos).pipe(
        map(productos => ({ direcciones, detalles, productos }))
      );
    }),

    // combinamos detalles con sus productos
    map(({ direcciones, detalles, productos }: any) => {
      const items = detalles.map((detalle: any) => ({
        ...detalle,
        producto: productos.find((p: any) => p?.id_producto === detalle.id_producto) || null
      }));

      //lo guardo en una variable para pagar
      this._items = items;

      return { items, direcciones, cargando: false, error: '' } as CheckoutVM;
    }),

    catchError(() => of(estadoError)),
    startWith(estadoInicial)
  );
}

  subtotal(items: any[]): number {
    return items.reduce((s: number, item: any) => s + item.precio_unitario * item.cantidad, 0);
  }

  totalFinal(items: any[]): string {
    return (this.subtotal(items) + this.GASTOS_ENVIO).toFixed(2);
  }

 labelMetodo(tipo: string): string {
  if (tipo === 'tarjeta') return 'Tarjeta';
  if (tipo === 'paypal') return 'PayPal';
  if (tipo === 'bizum') return 'Bizum';
  if (tipo === 'google_pay') return 'Google Pay';
  return tipo;
}

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

  mostrarFecha():   boolean { return this.tipoSeleccionado === 'tarjeta'; }
  mostrarTitular(): boolean { return this.tipoSeleccionado === 'tarjeta'; }

  // formulario de metodo de pago nuevo

  abrirFormulario() {
    this.campoTexto = '';
    this.fechaNueva = '';
    this.nombreTitular = '';
    this.codigoPaisBizum = '+34';
    this.telefonoNumeroBizum = '';
    this.tipoSeleccionado = 'tarjeta';
    this.errorForm.set('');
    this.mostrarFormulario.set(true);
  }

  cancelarFormulario() {
    this.mostrarFormulario.set(false);
  }

  private mascararTarjeta(numero: string): string {
    return '**** **** **** ' + numero.replace(/\s/g, '').slice(-4);
  }

  async guardarMetodo() {
    if (this.tipoSeleccionado === 'tarjeta') {
      if (!this.nombreTitular.trim()) { this.errorForm.set('El nombre del titular es obligatorio.'); return; }
      if (!this.campoTexto.trim()) { this.errorForm.set('Introduce el número de tarjeta.');       return; }
    } else if (this.tipoSeleccionado === 'bizum') {
      if (!this.telefonoNumeroBizum.trim()) { this.errorForm.set('Introduce un número de teléfono.'); return; }
    } else {
      if (!this.campoTexto.trim()) { this.errorForm.set('Este campo es obligatorio.'); return; }
    }

    if (!this.idUsuario) return;

    this.guardando.set(true);
    this.errorForm.set('');

    const numeroEnmascarado = this.tipoSeleccionado === 'tarjeta'
      ? this.mascararTarjeta(this.campoTexto)
      : this.tipoSeleccionado === 'bizum'
        ? `${this.codigoPaisBizum} ${this.telefonoNumeroBizum.trim()}`
        : this.campoTexto.trim();

    try {
      const nuevoMetodo = await firstValueFrom(this.clientService.addMetodoPago({
        id_usuario: this.idUsuario,
        tipo:this.tipoSeleccionado,
        numero_enmascarado: numeroEnmascarado,
        fecha_expiracion: this.tipoSeleccionado === 'tarjeta' ? (this.fechaNueva || null) : null,
        es_predeterminado: this.metodosGuardados().length === 0 ? 1 : 0
      }));

      this.metodosGuardados.update(metodos => [...metodos, nuevoMetodo]);
      this.idMetodoPago = nuevoMetodo.id_metodo_pago;
      this.mostrarFormulario.set(false);
    } catch {
      this.errorForm.set('No se ha podido guardar el método de pago.');
    } finally {
      this.guardando.set(false);
    }
  }

  // metodos de stripe

  async pagar() {
    this.errorPago.set('');

    if (!this.idMetodoPago) { this.errorPago.set('Selecciona un método de pago.'); return; }
    if (!this.idDireccion){ this.errorPago.set('Selecciona una dirección de envío.'); return; }
    if (!this._items.length) { this.errorPago.set('Tu carrito está vacío.'); return; }

    this.procesando.set(true);

    try {
      const total = parseFloat(this.totalFinal(this._items));
      const { client_secret } = await firstValueFrom(this.clientService.createPaymentIntent(total));
      this.stripeClientSecret = client_secret;

      if (!this.stripe) {
        this.stripe = await this.ngZone.run(() => loadStripe(STRIPE_PUBLISHABLE_KEY));
      }

      this.mostrarStripeModal.set(true);
      this.stripeError.set('');
      this.procesando.set(false);

      setTimeout(() => this.ngZone.run(() => this.montarCardElement()), 50);
    } catch {
      this.errorPago.set('No se pudo iniciar el pago. Inténtalo de nuevo.');
      this.procesando.set(false);
    }
  }

  private montarCardElement() {
    if (!this.stripe) return;
    this.destruirCardElement();

    const elements = this.stripe.elements({ locale: 'es' });
    this.cardElement = elements.create('card', {
      style: {
        base: {
          fontFamily: 'inherit',
          fontSize: '14px',
          color: '#000',
          '::placeholder': { color: '#bbb' },
        },
        invalid: { color: '#AE0000' },
      },
      hidePostalCode: true,
    });

    const container = document.getElementById('stripe-card-element');
    if (container) {
      this.cardElement.mount(container);
      this.cardElement.on('change', (event: any) => {
        this.ngZone.run(() => {
          this.stripeError.set(event.error ? event.error.message : '');
        });
      });
    }
  }

  async confirmarConStripe() {
    if (!this.stripe || !this.cardElement || !this.stripeClientSecret) return;

    this.confirmando.set(true);
    this.stripeError.set('');

    try {
      const { paymentIntent, error } = await this.stripe.confirmCardPayment(
        this.stripeClientSecret,
        { payment_method: { card: this.cardElement } }
      );

      if (error) {
        this.stripeError.set(error.message || 'Error al procesar la tarjeta.');
        return;
      }

      if (paymentIntent?.status === 'succeeded') {
        const usuario = this.clientService.getUsuarioLocal();
        const total   = parseFloat(this.totalFinal(this._items));

        await firstValueFrom(this.clientService.confirmarPedidoStripe({
          payment_intent_id: paymentIntent.id,
          id_usuario: usuario.id_usuario,
          id_metodo_pago:Number(this.idMetodoPago),
          id_direccion: Number(this.idDireccion),
          gastos_envio: this.GASTOS_ENVIO,
          total,
          items: this._items.map(item => ({
            id_producto: item.id_producto,
            cantidad:item.cantidad,
            precio_en_el_momento: item.precio_unitario,
          })),
        }));

        for (const item of this._items) {
          try {
            await firstValueFrom(this.clientService.deleteDetalleCarrito(item.id_detalle_carrito));
          } catch {}
        }

        this.router.navigate(['/perfil/pedidos']);
      }
    } catch {
      this.stripeError.set('El pago fue procesado pero hubo un error al crear el pedido. Contacta con soporte.');
    } finally {
      this.confirmando.set(false);
    }
  }

  cerrarStripeModal() {
    this.destruirCardElement();
    this.mostrarStripeModal.set(false);
    this.stripeError.set('');
    this.stripeClientSecret = '';
  }

  private destruirCardElement() {
    if (this.cardElement) {
      this.cardElement.destroy();
      this.cardElement = null;
    }
  }
}