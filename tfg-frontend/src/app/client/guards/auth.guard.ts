import { inject } from '@angular/core';
import { CanActivateFn, Router } from '@angular/router';
import { ClientService } from '../services/client.service';

export const authGuard: CanActivateFn = () => {
  const router = inject(Router);
  const clientService = inject(ClientService);

  if (!clientService.getToken()) {
    router.navigate(['/login']);
    return false;
  }

  return true;
};

export const checkoutGuard: CanActivateFn = () => {
  const router = inject(Router);
  const service = inject(ClientService);

  if (service.consumir()) {
    return true;
  }

  router.navigate(['/cesta']);
  return false;
};