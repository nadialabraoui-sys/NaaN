import { Component, signal } from '@angular/core';
import { RouterModule } from '@angular/router';

@Component({
  selector: 'app-ayuda',
  standalone: true,
  imports: [RouterModule],
  templateUrl: './ayuda.html',
})
export class Ayuda {

  abiertos = signal(new Set<number>());

  readonly faqs = [
    {
      pregunta: '¿Cuánto tarda en llegar mi pedido?',
      respuesta: 'Los pedidos estándar se entregan en 3-5 días laborables. Si eliges envío express, recibirás tu pedido en 24-48 horas. Durante épocas de alta demanda los plazos pueden aumentar ligeramente.'
    },
    {
      pregunta: '¿Puedo cambiar o cancelar mi pedido?',
      respuesta: 'Puedes cancelar o modificar tu pedido dentro de las 2 horas siguientes a realizarlo. Pasado ese tiempo, el pedido ya estará en preparación y no podrá modificarse. Contáctanos lo antes posible si necesitas hacer algún cambio.'
    },
    {
      pregunta: '¿Cómo realizo una devolución?',
      respuesta: 'Dispones de 30 días desde la recepción del pedido para devolver cualquier artículo en perfectas condiciones y con el etiquetado original. Para iniciar la devolución contacta con nuestro equipo indicando tu número de pedido.'
    },
    {
      pregunta: '¿Los gastos de envío son gratuitos?',
      respuesta: 'El envío es gratuito en pedidos superiores a 50 €. Para pedidos de menor importe, el coste de envío estándar es de 3,99 €.'
    },
    {
      pregunta: '¿Cómo puedo saber mi talla?',
      respuesta: 'En cada ficha de producto encontrarás una guía de tallas con las medidas exactas. Si tienes dudas, escríbenos y te ayudamos a elegir la talla correcta.'
    },
    {
      pregunta: '¿Puedo comprar sin registrarme?',
      respuesta: 'Sí, puedes realizar compras como invitado. Sin embargo, si te registras podrás seguir tus pedidos, guardar favoritos y gestionar tus datos de envío de forma más cómoda.'
    },
    {
      pregunta: '¿Qué métodos de pago aceptáis?',
      respuesta: 'Aceptamos tarjeta de crédito/débito (Visa, Mastercard), PayPal, Bizum y Google Pay. Todos los pagos se procesan de forma segura mediante cifrado SSL.'
    },
    {
      pregunta: '¿Dónde puedo ver el estado de mi pedido?',
      respuesta: 'En el apartado "Pedidos" de tu perfil puedes consultar en tiempo real el estado de todos tus pedidos, así como el número de seguimiento una vez que haya salido de nuestro almacén.'
    }
  ];

  toggle(i: number): void {
    this.abiertos.update(s => {
      const next = new Set(s);
      next.has(i) ? next.delete(i) : next.add(i);
      return next;
    });
  }
}
