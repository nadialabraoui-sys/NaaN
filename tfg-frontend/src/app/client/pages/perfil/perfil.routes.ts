import { Routes } from '@angular/router';
import { PerfilLayout } from './layout/perfil-layout';
import { authGuard } from '../../guards/auth.guard';

export const perfilRoutes: Routes = [
  {
    path: '',
    component: PerfilLayout,
    canActivate: [authGuard],
    children: [
      { path: '', redirectTo: 'pedidos', pathMatch: 'full' },
      { path: 'pedidos', loadComponent: () => import('./pedidos/pedidos').then(x => x.MisPedidos) },
      { path: 'datos', loadComponent: () => import('./perfil/perfil').then(x => x.MisDatos) },
      { path: 'favoritos', loadComponent: () => import('./favoritos/favoritos').then(x => x.MisFavoritos) },
      { path: 'metodos-pago',loadComponent: () => import('./metodos-pago/metodos-pago').then(x => x.MisMetodosPago) },
      { path: 'direcciones', loadComponent: () => import('./direcciones/direcciones').then(x => x.MisDirecciones) },
      { path: 'ayuda', loadComponent: () => import('./ayuda/ayuda').then(x => x.Ayuda) },
      { path: 'chat', loadComponent: () => import('./chat/chat').then(x => x.ChatSoporte) },
    ]
  }
];
