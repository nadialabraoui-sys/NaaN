import { Component, inject } from '@angular/core';
import { RouterModule, Router } from '@angular/router';
import { ClientService } from '../../client/services/client.service';

@Component({
  selector: 'app-layout',
  imports: [RouterModule],
  templateUrl: './layout.html',
  styleUrl: './layout.css'
})
export class Layout {
  private clientService = inject(ClientService);
  private router = inject(Router);

  cerrarSesion() {
    this.clientService.cerrarSesion();
    this.router.navigate(['/']);
  }
}