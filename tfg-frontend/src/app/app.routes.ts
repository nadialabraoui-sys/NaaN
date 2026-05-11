import { Routes } from '@angular/router';
import { Landing } from './client/pages/landing/landing';
import { authGuard, checkoutGuard } from './client/guards/auth.guard';

export const routes: Routes = [
  {
    path: '',
    component: Landing
  },
  {
    path: 'login',
    loadComponent: () => import('./client/pages/login/login').then(x => x.Login)
  },
  {
    path: 'registro',
    loadComponent: () => import('./client/pages/registro/registro').then(x => x.Registro)
  },
  {
    path: 'terminos-condiciones',
    loadComponent: () => import('./client/pages/terminos-condiciones/terminos-condiciones').then(x => x.TerminosCondiciones)
  },
  {
    path: 'politica-privacidad',
    loadComponent: () => import('./client/pages/politica-privacidad/politica-privacidad').then(x => x.PoliticaPrivacidad)
  },
  {
    path: 'productos',
    loadComponent: () => import('./client/pages/productos/productos').then(x => x.Productos)
  },
  {
    path: 'producto/:id',
    loadComponent: () => import('./client/pages/producto/producto').then(x => x.ProductoDetalle)
  },
  {
    path: 'cesta',
    loadComponent: () => import('./client/pages/cesta/cesta').then(x => x.Cesta),
    canActivate: [authGuard]
  },
  {
    path: 'checkout',
    loadComponent: () => import('./client/pages/checkout/checkout').then(x => x.Checkout),
    canActivate: [authGuard, checkoutGuard]
  },
  {
    path: 'crear-diseno',
    loadComponent: () => import('./client/pages/crear-diseno/crear-diseno').then(x => x.CrearDiseno)
  },
  {
    path: 'perfil',
    loadChildren: () => import('./client/pages/perfil/perfil.routes').then(x => x.perfilRoutes),
    canActivate: [authGuard]
  },
  {
    path: 'admin',
    loadChildren: () => import('./admin/admin.routes').then(x => x.adminRoutes)
  },
  {
    path: 'landing',
    loadComponent: () => import('./client/pages/landing/landing').then(x => x.Landing)
  }
];