import { Routes } from '@angular/router';
import { Layout } from './layout/layout';
import { adminGuard } from './guards/admin.guard';

export const adminRoutes: Routes = [
  {
    path: '',
    component: Layout,
    // canActivate: Ejecuta el admin.guard.ts antes de entrar, si este falla redirige a "/"
    canActivate: [adminGuard],
    // children: Rutas hijas que se renderizan dentro del "<router-outlet>" del Layout
    children: [
      { path: '', redirectTo: 'dashboard', pathMatch: 'full' },
      { path: 'dashboard', loadComponent: () => import('./dashboard/dashboard').then(x => x.Dashboard) },
      { path: 'productos', loadComponent: () => import('./productos/productos').then(x => x.Productos) },
      { path: 'categorias', loadComponent: () => import('./categorias/categorias').then(x => x.Categorias) },
      { path: 'usuarios', loadComponent: () => import('./usuarios/usuarios').then(x => x.Usuarios) },
      { path: 'pedidos', loadComponent: () => import('./pedidos/pedidos').then(x => x.Pedidos) },
      { path: 'avatar', loadComponent: () => import('./avatar/avatar').then(x => x.Avatar) },
      { path: 'auditoria', loadComponent: () => import('./auditoria/auditoria').then(x => x.Auditoria) },
    ]
  }
];