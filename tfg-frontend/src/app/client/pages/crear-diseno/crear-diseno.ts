import { Component, AfterViewInit, OnDestroy, ElementRef, viewChild, PLATFORM_ID, signal, inject } from '@angular/core';
import { NgClass, isPlatformBrowser } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Canvas, FabricImage } from 'fabric';
import { Navbar } from '../../shared/components/navbar/navbar';
import { Header } from '../../shared/components/header/header';

@Component({
  selector: 'app-crear-diseno',
  standalone: true,
  imports: [FormsModule, NgClass, Navbar, Header],
  templateUrl: './crear-diseno.html',
})
export class CrearDiseno implements AfterViewInit, OnDestroy {

  private platformId = inject(PLATFORM_ID);

  talla = '';
  tejido = '';
  color = '#AE0000';

  enviado = signal(false);
  error = signal('');
  prendaActiva = signal<'camiseta' | 'pantalon'>('camiseta');
  haySeleccion = signal(false);
  imagenesCount = signal(0);

   tallas  = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];
   tejidos = ['Algodón', 'Lino', 'Lana', 'Poliéster', 'Denim', 'Seda'];
   MAX_IMAGENES = 5;

  private canvasFrenteElRef = viewChild.required<ElementRef<HTMLCanvasElement>>('fabricCanvasFrente');
  private canvasEspaldaElRef = viewChild.required<ElementRef<HTMLCanvasElement>>('fabricCanvasEspalda');
  private containerFrenteRef = viewChild.required<ElementRef<HTMLDivElement>>('canvasContainerFrente');
  private containerEspaldaRef = viewChild.required<ElementRef<HTMLDivElement>>('canvasContainerEspalda');
  private fileInputRef = viewChild.required<ElementRef<HTMLInputElement>>('fileInput');

  private canvasFrente?: Canvas;
  private canvasEspalda?: Canvas;
  private canvasConSeleccion?: Canvas;
  private ladoSeleccionado: 'frente' | 'espalda' = 'frente';
  private onKeyDown?: (e: KeyboardEvent) => void;

  
  ngAfterViewInit() {
    if (!isPlatformBrowser(this.platformId)) return;
    setTimeout(() => this.initCanvas(), 200);
  }

  ngOnDestroy() {
    if (this.onKeyDown) document.removeEventListener('keydown', this.onKeyDown);
    this.canvasFrente?.dispose();
    this.canvasEspalda?.dispose();
  }

  private async initSingleCanvas( canvasElRef: ElementRef<HTMLCanvasElement>, containerRef: ElementRef<HTMLDivElement>, bgUrl: string): Promise<Canvas> {
    const margin = 16;
    const ratio = 16 / 10;
    const availW = (containerRef.nativeElement.clientWidth  || 300) - margin * 2;
    const availH = (containerRef.nativeElement.clientHeight || 200) - margin * 2;
    const w = availW / availH > ratio ? Math.floor(availH * ratio) : Math.floor(availW);
    const h = Math.floor(w / ratio);

    const canvas = new Canvas(canvasElRef.nativeElement, { width: w, height: h });

    try {
      const bg  = await FabricImage.fromURL(bgUrl, { crossOrigin: 'anonymous' });
      const scale = canvas.height! / (bg.height || 1);
      bg.set({
        left: (canvas.width! - (bg.width || 1) * scale) / 2,
        top: 0,
        originX: 'left',
        originY: 'top',
        scaleX: scale,
        scaleY: scale,
        selectable: false,
        evented: false,
        hasControls: false,
        hasBorders: false,
        lockMovementX: true,
        lockMovementY: true,
        lockRotation: true,
        lockScalingX: true,
        lockScalingY: true,
        hoverCursor: 'default',
      });
      canvas.add(bg);
      canvas.sendObjectToBack(bg);
    } catch (e) {
      console.error('Error cargando imagen de fondo:', e);
    }

    canvas.renderAll();
    return canvas;
  }

  private deseleccionar(canvas: Canvas): void {
  const other = canvas === this.canvasFrente ? this.canvasEspalda : this.canvasFrente;
  if (other?.getActiveObject()) {
    other.discardActiveObject();
    other.renderAll();
  }
}

  private crearCanvasEventos(canvas: Canvas): void {
    //evitar que el objeto se salga del canvas
    canvas.on('object:moving', (e) => {
      const obj = e.target;
      if (!obj) return;
      const cw = canvas.width!;
      const ch  = canvas.height!;
      const mitadW = obj.getScaledWidth()  / 2;
      const mitadH = obj.getScaledHeight() / 2;
      if (obj.left! < mitadW) obj.set({ left: mitadW });
      if (obj.top!  < mitadH) obj.set({ top:  mitadH });
      if (obj.left! > cw - mitadW) obj.set({ left: cw - mitadW });
      if (obj.top!  > ch - mitadH) obj.set({ top:  ch - mitadH });
    });

    canvas.on('selection:created', () => {
      this.deseleccionar(canvas);
      this.haySeleccion.set(true);
      this.canvasConSeleccion = canvas;
    });

    canvas.on('selection:updated', () => {
      this.deseleccionar(canvas);
      this.haySeleccion.set(true);
      this.canvasConSeleccion = canvas;
    });
    canvas.on('selection:cleared', () => {
      if (this.canvasConSeleccion === canvas) {
        this.haySeleccion.set(false);
        this.canvasConSeleccion = undefined;
      }
    });
  }

  private async initCanvas(): Promise<void> {
    if (this.canvasFrente) { await this.canvasFrente.dispose();  this.canvasFrente  = undefined; }
    if (this.canvasEspalda) { await this.canvasEspalda.dispose(); this.canvasEspalda = undefined; }

    const prenda = this.prendaActiva();
    const bgFrente  = prenda === 'camiseta' ? '/assets/camiseta.jpg' : '/assets/pantalon-frente.png';
    const bgEspalda = prenda === 'camiseta' ? '/assets/camiseta.jpg' : '/assets/pantalon-trasero.png';

    [this.canvasFrente, this.canvasEspalda] = await Promise.all([
      this.initSingleCanvas(this.canvasFrenteElRef(),  this.containerFrenteRef(),  bgFrente),
      this.initSingleCanvas(this.canvasEspaldaElRef(), this.containerEspaldaRef(), bgEspalda),
    ]);

    this.crearCanvasEventos(this.canvasFrente);
    this.crearCanvasEventos(this.canvasEspalda);

    if (this.onKeyDown) document.removeEventListener('keydown', this.onKeyDown);
    this.onKeyDown = (e: KeyboardEvent) => {
      if ((e.key === 'Delete' || e.key === 'Backspace') &&
          (this.canvasFrente?.getActiveObject() || this.canvasEspalda?.getActiveObject())) {
        this.eliminarSeleccionada();
      }
    };
    document.addEventListener('keydown', this.onKeyDown);
  }

  cambiarPrenda(prenda: 'camiseta' | 'pantalon') {
    if (this.prendaActiva() === prenda) return;
    this.prendaActiva.set(prenda);
    this.imagenesCount.set(0);
    this.haySeleccion.set(false);
    this.canvasConSeleccion = undefined;
    setTimeout(() => this.initCanvas(), 0);
  }

  abrirSelectorImagen(lado: 'frente' | 'espalda') {
    this.ladoSeleccionado = lado;
    this.fileInputRef().nativeElement.click();
  }

  onFileSelected(event: Event) {
    const input  = event.target as HTMLInputElement;
    const file   = input.files?.[0];
    const canvas = this.ladoSeleccionado === 'frente' ? this.canvasFrente : this.canvasEspalda;
    if (!file || !canvas) return;
    input.value = '';

    const reader = new FileReader();
    reader.onload = async (e) => {
      try {
        const url = e.target?.result as string;
        const img = await FabricImage.fromURL(url);

        const maxSize = 150;
        if ((img.width ?? 0) > maxSize || (img.height ?? 0) > maxSize) {
          img.scale(maxSize / Math.max(img.width ?? 1, img.height ?? 1));
        }

        img.set({
          left: (canvas.width!  - img.getScaledWidth())  / 2,
          top:  (canvas.height! - img.getScaledHeight()) / 2,
        });

        canvas.add(img);
        canvas.setActiveObject(img);
        canvas.renderAll();
        this.imagenesCount.update(n => n + 1);
      } catch (err) {
        console.error('Error añadiendo imagen:', err);
      }
    };
    reader.readAsDataURL(file);
  }

  eliminarSeleccionada() {
    const canvas = this.canvasFrente?.getActiveObject()  ? this.canvasFrente
                 : this.canvasEspalda?.getActiveObject() ? this.canvasEspalda
                 : undefined;
    const obj = canvas?.getActiveObject();
    if (!obj || !canvas) return;
    canvas.remove(obj);
    canvas.discardActiveObject();
    canvas.renderAll();
    this.imagenesCount.update(n => n - 1);
    this.haySeleccion.set(false);
    this.canvasConSeleccion = undefined;
  }

  private loadImage(url: string): Promise<HTMLImageElement> {
    return new Promise((resolve, reject) => {
      const img = new Image();
      img.onload  = () => resolve(img);
      img.onerror = reject;
      img.src     = url;
    });
  }

  private async descargarCombinado(filename: string): Promise<void> {
    if (!this.canvasFrente || !this.canvasEspalda) return;

    const urlF = this.canvasFrente.toDataURL({ format: 'png', multiplier: 1 });
    const urlE = this.canvasEspalda.toDataURL({ format: 'png', multiplier: 1 });

    const [imgF, imgE] = await Promise.all([this.loadImage(urlF), this.loadImage(urlE)]);

    const gap = 16;
    const w   = imgF.width + gap + imgE.width;
    const h   = Math.max(imgF.height, imgE.height);

    const tmp = document.createElement('canvas');
    tmp.width  = w;
    tmp.height = h;
    const ctx  = tmp.getContext('2d')!;

    ctx.fillStyle = '#ffffff';
    ctx.fillRect(0, 0, w, h);
    ctx.drawImage(imgF, 0, 0);
    ctx.drawImage(imgE, imgF.width + gap, 0);

    const a    = document.createElement('a');
    a.href     = tmp.toDataURL('image/png');
    a.download = filename;
    a.click();
  }

  enviar() {
    this.error.set('');
    if (!this.talla || !this.tejido) {
      this.error.set('Por favor, completa todos los campos obligatorios');
      return;
    }
    this.descargarCombinado(`diseño-${this.prendaActiva()}.png`);
    this.enviado.set(true);
  }

  nuevo() {
    this.talla = '';
    this.tejido = '';
    this.color = '#AE0000';
    this.enviado.set(false);
    this.error.set('');
    this.imagenesCount.set(0);
    this.haySeleccion.set(false);
    this.canvasConSeleccion = undefined;
    setTimeout(() => this.initCanvas(), 0);
  }
}
