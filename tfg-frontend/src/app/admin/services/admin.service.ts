import { Injectable, PLATFORM_ID, Inject } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import {environment} from '../../../environments/environment';

// Sigue en ejecucion mientras hace la peticion, no espera a que llegue
// EJ: Pizza, llamas y esperas o llamas y haces vida normal hasta que llamen al timbre
import { Observable } from 'rxjs';

import { isPlatformBrowser } from '@angular/common';

@Injectable({
  providedIn: 'root'
})
export class AdminService {

  private apiUrl = environment.apiUrl;

  constructor(
    private http: HttpClient,
    @Inject(PLATFORM_ID) private platformId: Object
  ) { }

  private getHeaders() {
    let token = null;
    if (isPlatformBrowser(this.platformId)) {
      token = localStorage.getItem('token');
    }
    return new HttpHeaders({
      'Authorization': `Bearer ${token}`,
      'Content-Type': 'application/json'
    });
  }

  // Productos
  getProductos(): Observable<any> {
    return this.http.get(`${this.apiUrl}/productos/all`, { headers: this.getHeaders() });
  }

  crearProducto(producto: any): Observable<any> {
    return this.http.post(`${this.apiUrl}/productos`, producto, { headers: this.getHeaders() });
  }

  editarProducto(id: number, producto: any): Observable<any> {
    return this.http.put(`${this.apiUrl}/productos/${id}`, producto, { headers: this.getHeaders() });
  }

  eliminarProducto(id: number): Observable<any> {
    return this.http.delete(`${this.apiUrl}/productos/${id}`, { headers: this.getHeaders() });
  }

  toggleProducto(id: number): Observable<any> {
    return this.http.patch(`${this.apiUrl}/productos/${id}/toggle`, {}, { headers: this.getHeaders() });
  }

  getFavoritosPorProducto(id: number): Observable<any> {
    return this.http.get(`${this.apiUrl}/favorito/productos-favoritos/${id}`, { headers: this.getHeaders() });
  }

  // Usuarios
  getUsuarios(): Observable<any> {
    return this.http.get(`${this.apiUrl}/usuarios`, { headers: this.getHeaders() });
  }

  eliminarUsuario(id: number): Observable<any> {
    return this.http.delete(`${this.apiUrl}/usuarios/${id}`, { headers: this.getHeaders() });
  }

  toggleAdmin(id: number): Observable<any> {
    return this.http.patch(`${this.apiUrl}/usuarios/${id}/toggle`, {}, { headers: this.getHeaders() });
  }

  // Pedidos
  getPedidos(): Observable<any> {
    return this.http.get(`${this.apiUrl}/pedidos`, { headers: this.getHeaders() });
  }

  avanzarEstado(id: number): Observable<any> {
    return this.http.patch(`${this.apiUrl}/pedidos/${id}/avanzar-estado`, {}, { headers: this.getHeaders() });
  }

  cancelarPedido(id: number): Observable<any> {
    return this.http.patch(`${this.apiUrl}/pedidos/${id}/cancelar`, {}, { headers: this.getHeaders() });
  }

  // Categorias
  getCategorias(): Observable<any> {
    return this.http.get(`${this.apiUrl}/categorias`, { headers: this.getHeaders() });
  }

  crearCategoria(categoria: any): Observable<any> {
    return this.http.post(`${this.apiUrl}/categorias`, categoria, { headers: this.getHeaders() });
  }

  editarCategoria(id: number, categoria: any): Observable<any> {
    return this.http.put(`${this.apiUrl}/categorias/${id}`, categoria, { headers: this.getHeaders() });
  }

  eliminarCategoria(id: number): Observable<any> {
    return this.http.delete(`${this.apiUrl}/categorias/${id}`, { headers: this.getHeaders() });
  }

  // Avatares
  getAvatares(): Observable<any> {
    return this.http.get(`${this.apiUrl}/avatar`, { headers: this.getHeaders() });
  }

  eliminarAvatar(id: number): Observable<any> {
    return this.http.delete(`${this.apiUrl}/avatar/${id}`, { headers: this.getHeaders() });
  }

  // Auditoria
  getAuditorias(): Observable<any> {
    return this.http.get(`${this.apiUrl}/auditoria`, { headers: this.getHeaders() });
  }
}