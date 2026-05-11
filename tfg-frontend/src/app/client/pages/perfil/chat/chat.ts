import { Component, inject, AfterViewChecked, ElementRef, viewChild, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ClientService } from '../../../services/client.service';

interface Mensaje {
  role: 'user' | 'assistant';
  content: string;
}

@Component({
  selector: 'app-chat-soporte',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './chat.html',
  styleUrl: './chat.css'
})
export class ChatSoporte implements AfterViewChecked {
  private clientSvc = inject(ClientService);
  private cdr = inject(ChangeDetectorRef);
  private listRef = viewChild<ElementRef<HTMLElement>>('mensajesList');

  mensajes: Mensaje[] = [
    { role: 'assistant', content: '¡Hola! Soy el asistente de NaaN. ¿En qué puedo ayudarte hoy?' }
  ];

  inputText = '';
  enviando = false;

  ngAfterViewChecked() {
    const el = this.listRef()?.nativeElement;
    if (el) el.scrollTop = el.scrollHeight;
  }

  enviar() {
    const texto = this.inputText.trim();
    if (!texto || this.enviando) return;

    this.mensajes.push({ role: 'user', content: texto });
    this.inputText = '';
    this.enviando  = true;

    this.clientSvc.chatbot(this.mensajes).subscribe({
      next: (res: any) => {
        this.mensajes.push({ role: 'assistant', content: res.reply });
        this.enviando = false;
        this.cdr.detectChanges();
      },
      error: () => {
        this.mensajes.push({ role: 'assistant', content: 'Lo siento, ha ocurrido un error. Inténtalo de nuevo o escríbenos a soporte@naan.es' });
        this.enviando = false;
        this.cdr.detectChanges();
      }
    });
  }

  onKeydown(e: KeyboardEvent) {
    if (e.key === 'Enter' && !e.shiftKey) {
      e.preventDefault();
      this.enviar();
    }
  }
}
