import { inject } from '@angular/core';
import { CanActivateFn, Router } from '@angular/router';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { map, catchError } from 'rxjs/operators';
import { of } from 'rxjs';

export const adminGuard: CanActivateFn = () => {
      // Inyectamos el Router y HttpClient sin necesidad constructor, usando inject()
  const router = inject(Router);
  const http = inject(HttpClient);

  if (typeof localStorage === 'undefined') return false;

  const token = localStorage.getItem('token');

  if (!token) {
    router.navigate(['/']);
    return false;
  }

  // Creamos el header con el token para la peticion
  const headers = new HttpHeaders({ 'Authorization': `Bearer ${token}` });

  // Hacemos una petición al backend para verificar que el token es valido y el usuario es admin
  // Si la peticion tiene exito (200), devolvemos true y permitimos la entrada
  // Si falla (401 o 403), redirigimos a "/" y devolvemos false
  return http.get('http://127.0.0.1:8000/api/usuarios', { headers }).pipe(
    map(() => true),
    catchError(() => {
      router.navigate(['/']);
      return of(false);
    })
  );
};