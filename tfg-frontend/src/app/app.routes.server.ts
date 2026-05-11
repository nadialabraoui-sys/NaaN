import { RenderMode, ServerRoute } from '@angular/ssr';

export const serverRoutes: ServerRoute[] = [
  {
    path: 'admin/**',
    renderMode: RenderMode.Client,
  },
  {
    path: 'perfil/**',
    renderMode: RenderMode.Client,
  },
  {
    path: 'productos',
    renderMode: RenderMode.Client,
  },
  {
    path: 'producto/**',
    renderMode: RenderMode.Client,
  },
  {
    path: 'cesta',
    renderMode: RenderMode.Client,
  },
  {
    path: 'checkout',
    renderMode: RenderMode.Client,
  },
  {
    path: 'vista3d/**',
    renderMode: RenderMode.Client,
  },
  {
    path: 'login',
    renderMode: RenderMode.Client,
  },
  {
    path: 'registro',
    renderMode: RenderMode.Client,
  },
  {
    path: '',
    renderMode: RenderMode.Client,
  },
  {
    path: '**',
    renderMode: RenderMode.Prerender,
  },
];
