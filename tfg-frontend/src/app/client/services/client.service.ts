import { Injectable, PLATFORM_ID, inject, signal } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable, of } from 'rxjs';
import { tap, map, shareReplay } from 'rxjs/operators';
import { isPlatformBrowser } from '@angular/common';
import { environment } from '../../../environments/environment';

@Injectable({
  providedIn: 'root'
})
export class ClientService {

  private http = inject(HttpClient);
  private platformId = inject(PLATFORM_ID);
  private autorizado = signal(false);

  private apiUrl = environment.apiUrl;

  // cache de categorias, persiste mientras la app esté abierta 
  private categoriasCache = new Map<string, Observable<any>>();

  private getHeaders() {
    return new HttpHeaders({
      'Authorization': `Bearer ${this.getToken()}`,
      'Content-Type': 'application/json'
    });
  }

  // auth

  login(email: string, contrasena: string): Observable<any> {
    return this.http.post(`${this.apiUrl}/login`, { email, contrasena });
  }

  registro(datos: any): Observable<any> {
    return this.http.post(`${this.apiUrl}/registro`, datos);
  }

  guardarSesion(token: string, usuario: any, recordar: boolean = true): void {
    if (isPlatformBrowser(this.platformId)) {
      const storage = recordar ? localStorage : sessionStorage;
      storage.setItem('token', token);
      storage.setItem('usuario', JSON.stringify(usuario));
    }
  }

  cerrarSesion(): void {
    if (isPlatformBrowser(this.platformId)) {
      localStorage.removeItem('token');
      localStorage.removeItem('usuario');
      localStorage.removeItem('id_carrito');
      sessionStorage.removeItem('token');
      sessionStorage.removeItem('usuario');
      sessionStorage.removeItem('id_carrito');
    }
  }

  getToken(): string | null {
    if (isPlatformBrowser(this.platformId)) {
      return localStorage.getItem('token') || sessionStorage.getItem('token');
    }
    return null;
  }

  getUsuarioLocal(): any {
    if (isPlatformBrowser(this.platformId)) {
      const u = localStorage.getItem('usuario') || sessionStorage.getItem('usuario');
      return u ? JSON.parse(u) : null;
    }
    return null;
  }

  estaLogueado(): boolean {
    return !!this.getToken();
  }

  actualizarUsuarioLocal(usuario: any): void {
    if (isPlatformBrowser(this.platformId)) {
      if (localStorage.getItem('usuario')) localStorage.setItem('usuario', JSON.stringify(usuario));
      if (sessionStorage.getItem('usuario')) sessionStorage.setItem('usuario', JSON.stringify(usuario));
    }
  }

  // categorias

  getCategorias(sexo?: string): Observable<any> {
    const key = sexo ?? '';
    if (!this.categoriasCache.has(key)) {
      const url = sexo
        ? `${this.apiUrl}/categorias?sexo=${encodeURIComponent(sexo)}`
        : `${this.apiUrl}/categorias`;
      this.categoriasCache.set(key, this.http.get(url).pipe(
        shareReplay({ bufferSize: 1, refCount: false })
      ));
    }
    return this.categoriasCache.get(key)!;
  }

  // productos

  getProducto(id: number): Observable<any> {
    return this.http.get(`${this.apiUrl}/productos/${id}`);
  }

  getProductos(params?: { buscar?: string; sexo?: string; nombre?: string; categoria?: number | string }): Observable<any> {
    let url = `${this.apiUrl}/productos`;
    const qs: string[] = [];
    if (params?.buscar)    qs.push(`buscar=${encodeURIComponent(params.buscar)}`);
    if (params?.sexo)      qs.push(`sexo=${encodeURIComponent(params.sexo)}`);
    if (params?.nombre)    qs.push(`nombre=${encodeURIComponent(params.nombre)}`);
    if (params?.categoria) qs.push(`categoria=${encodeURIComponent(params.categoria)}`);
    if (qs.length) url += '?' + qs.join('&');
    return this.http.get(url);
  }

  // carrito

  getMiCarrito(): Observable<any> {
    return this.http.get(`${this.apiUrl}/carrito/mi-carrito`, { headers: this.getHeaders() });
  }

 private readonly KEY = 'checkout_autorizado';

  autorizar() {
    sessionStorage.setItem(this.KEY, 'true');
  }

consumir(): boolean {
  const valor = sessionStorage.getItem(this.KEY) === 'true';
  sessionStorage.removeItem(this.KEY);  // ← añadir esto
  return valor;
}


  revocar() {
    sessionStorage.removeItem(this.KEY);
  }

  // guardar id del carrito en cache para evitar pedirlo cada vez que se añade algo a la cesta
  getCarritoIdCached(): Observable<number> {
    if (isPlatformBrowser(this.platformId)) {
      const storage = localStorage.getItem('token') ? localStorage : sessionStorage;
      const cached = storage.getItem('id_carrito');
      if (cached) return of(Number(cached));
    }
    return this.getMiCarrito().pipe(
      tap(carrito => {
        if (isPlatformBrowser(this.platformId)) {
          const storage = localStorage.getItem('token') ? localStorage : sessionStorage;
          storage.setItem('id_carrito', String(carrito.id_carrito));
        }
      }),
      map(carrito => carrito.id_carrito)
    );
  }

  getMisDetallesCarrito(): Observable<any> {
    return this.http.get(`${this.apiUrl}/detalle-carrito/mis-detalles-carrito`, { headers: this.getHeaders() });
  }

  addDetalleCarrito(datos: any): Observable<any> {
    return this.http.post(`${this.apiUrl}/detalle-carrito`, datos, { headers: this.getHeaders() });
  }

  updateDetalleCarrito(id: number, datos: any): Observable<any> {
    return this.http.put(`${this.apiUrl}/detalle-carrito/${id}`, datos, { headers: this.getHeaders() });
  }

  deleteDetalleCarrito(id: number): Observable<any> {
    return this.http.delete(`${this.apiUrl}/detalle-carrito/${id}`, { headers: this.getHeaders() });
  }

  // pedidos

  getMisPedidos(): Observable<any> {
    return this.http.get(`${this.apiUrl}/pedidos/mis-pedidos`, { headers: this.getHeaders() });
  }

  getMisDetallesPedidos(): Observable<any> {
    return this.http.get(`${this.apiUrl}/detalle-pedidos/mis-detalles`, { headers: this.getHeaders() });
  }

  crearPedido(datos: any): Observable<any> {
    return this.http.post(`${this.apiUrl}/pedidos`, datos, { headers: this.getHeaders() });
  }

  addDetallePedido(datos: any): Observable<any> {
    return this.http.post(`${this.apiUrl}/detalle-pedidos`, datos, { headers: this.getHeaders() });
  }

  // favs

  getMisFavoritos(): Observable<any> {
    return this.http.get(`${this.apiUrl}/favorito/mis-favoritos`, { headers: this.getHeaders() });
  }

  eliminarFavorito(idProducto: number): Observable<any> {
    return this.http.delete(`${this.apiUrl}/favorito/${idProducto}`, { headers: this.getHeaders() });
  }

  addFavorito(idUsuario: number, idProducto: number): Observable<any> {
    return this.http.post(`${this.apiUrl}/favorito`, { id_usuario: idUsuario, id_producto: idProducto }, { headers: this.getHeaders() });
  }

  // metodos de pago

  getMisMetodosPago(): Observable<any> {
    return this.http.get(`${this.apiUrl}/metodo-pago/mis-metodos-pago`, { headers: this.getHeaders() });
  }

  addMetodoPago(datos: any): Observable<any> {
    return this.http.post(`${this.apiUrl}/metodo-pago`, datos, { headers: this.getHeaders() });
  }

  eliminarMetodoPago(id: number): Observable<any> {
    return this.http.delete(`${this.apiUrl}/metodo-pago/${id}`, { headers: this.getHeaders() });
  }

  toggleMetodoPredeterminado(id: number): Observable<any> {
    return this.http.patch(`${this.apiUrl}/metodo-pago/${id}/toggle`, {}, { headers: this.getHeaders() });
  }

  // direcciones

  getMisDirecciones(): Observable<any> {
    return this.http.get(`${this.apiUrl}/direccion/mis-direcciones`, { headers: this.getHeaders() });
  }

  addDireccion(datos: any): Observable<any> {
    return this.http.post(`${this.apiUrl}/direccion`, datos, { headers: this.getHeaders() });
  }

  deleteDireccion(id: number): Observable<any> {
    return this.http.delete(`${this.apiUrl}/direccion/${id}`, { headers: this.getHeaders() });
  }

  // perfil

  getMiPerfil(): Observable<any> {
    return this.http.get(`${this.apiUrl}/mi-perfil`, { headers: this.getHeaders() });
  }

  actualizarMiPerfil(datos: any): Observable<any> {
    return this.http.put(`${this.apiUrl}/mi-perfil`, datos, { headers: this.getHeaders() });
  }

  cambiarContrasena(datos: any): Observable<any> {
    return this.http.put(`${this.apiUrl}/mi-contrasena`, datos, { headers: this.getHeaders() });
  }

  // avatar

  getMiAvatar(): Observable<any> {
    return this.http.get(`${this.apiUrl}/avatar/mi-avatar`, { headers: this.getHeaders() });
  }

  // chatbot

  chatbot(messages: { role: string; content: string }[]): Observable<any> {
    return this.http.post(`${this.apiUrl}/chatbot`, { messages }, { headers: this.getHeaders() });
  }

  // stripe

  createPaymentIntent(amount: number): Observable<{ client_secret: string }> {
    return this.http.post<{ client_secret: string }>(
      `${this.apiUrl}/stripe/create-payment-intent`,
      { amount },
      { headers: this.getHeaders() }
    );
  }

  confirmarPedidoStripe(datos: any): Observable<any> {
    return this.http.post(`${this.apiUrl}/stripe/confirmar-pedido`, datos, { headers: this.getHeaders() });
  }

}
