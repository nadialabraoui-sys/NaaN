import { Component, OnInit, signal, output, PLATFORM_ID, inject } from '@angular/core';
import { CommonModule, isPlatformBrowser } from '@angular/common';
import { Router, RouterModule } from '@angular/router';
import { firstValueFrom } from 'rxjs';
import { ClientService } from '../../../services/client.service';

interface MenuChild {
  label: string;
  route: string;
  queryParams?: Record<string, string>;
}

interface MenuItem {
  label: string;
  route?: string;
  queryParams?: Record<string, string>;
  children?: MenuChild[];
}

@Component({
  selector: 'app-navbar',
  standalone: true,
  imports: [CommonModule, RouterModule],
  templateUrl: './navbar.html',

})
export class Navbar implements OnInit {

  private clientService = inject(ClientService);
  private router = inject(Router);
  private platformId = inject(PLATFORM_ID);

  isOpen = signal(false);
  expandedItems = signal<Record<string, boolean>>({});
  closed = output<void>();

  menuItems = signal<MenuItem[]>([
    { label: 'Mujer', route: '/productos', queryParams: { genero: 'mujer' }, children: [] },
    { label: 'Hombre', route: '/productos', queryParams: { genero: 'hombre' }, children: [] },
    { label: 'Crea tu diseño', route: '/crear-diseno' }
  ]);

  ngOnInit() {
    if (isPlatformBrowser(this.platformId)) {
      this.cargarCategorias();
    }
  }

  async cargarCategorias() {
    try {
      const [catMujer, catHombre] = await Promise.all([
        firstValueFrom(this.clientService.getCategorias('mujer')),
        firstValueFrom(this.clientService.getCategorias('hombre'))
      ]);
      this.menuItems.update(items => items.map(item => {
        if (item.label === 'Mujer') return {
          ...item,
          children: (catMujer as any[]).map((c: any) => ({
            label: c.nombre, route: '/productos',
            queryParams: { genero: 'mujer', categoria: String(c.id_categoria), nombre: c.nombre }
          }))
        };
        if (item.label === 'Hombre') return {
          ...item,
          children: (catHombre as any[]).map((c: any) => ({
            label: c.nombre, route: '/productos',
            queryParams: { genero: 'hombre', categoria: String(c.id_categoria), nombre: c.nombre }
          }))
        };
        return item;
      }));
    } catch {}
  }

  expandSubmenu(label: string): void {
    this.expandedItems.update(items => ({ ...items, [label]: true }));
  }

  collapseSubmenu(label: string): void {
    this.expandedItems.update(items => ({ ...items, [label]: false }));
  }

  navegarYCerrar(route: string, queryParams?: Record<string, string>): void {
    this.router.navigate([route], queryParams ? { queryParams } : {});
    this.close();
  }

  toggle(): void {
    if (this.isOpen()) {
      this.close();
    } else {
      this.open();
    }
  }

  open(): void {
    this.isOpen.set(true);
    if (isPlatformBrowser(this.platformId)) document.body.style.overflow = 'hidden';
  }

  close(): void {
    this.isOpen.set(false);
    if (isPlatformBrowser(this.platformId)) document.body.style.overflow = '';
    this.expandedItems.set({});
    this.closed.emit();
  }


toggleSubmenu(label: string): void {
  this.expandedItems.update(items => ({
    ...items,
    [label]: !items[label]
  }));
}

}
