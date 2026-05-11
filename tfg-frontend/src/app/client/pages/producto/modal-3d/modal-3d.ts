import {
  Component, input, output,
  AfterViewInit, OnDestroy, ElementRef, viewChild, PLATFORM_ID, inject, NgZone,
} from '@angular/core';
import { isPlatformBrowser } from '@angular/common';
import * as THREE from 'three';
import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls.js';
import { FBXLoader } from 'three/examples/jsm/loaders/FBXLoader.js';

@Component({
  selector: 'app-modal-3d',
  standalone: true,
  imports: [],
  templateUrl: './modal-3d.html',
  host: { '(document:keydown.escape)': 'onEsc()' },
})
export class Modal3d implements AfterViewInit, OnDestroy {

  producto = input<any>();
  talla = input('');
  cerrar = output<void>();

  private platformId = inject(PLATFORM_ID);
  private ngZone = inject(NgZone);

  private canvasRef = viewChild.required<ElementRef<HTMLCanvasElement>>('canvas3d');

  private renderer?: THREE.WebGLRenderer;
  private animFrameId?: number;
  private resizeHandler?: () => void;

  readonly modelUrl = '/assets/models/modelo3d_M_6.fbx';

  ngAfterViewInit() {
    if (!isPlatformBrowser(this.platformId)) return;
    this.ngZone.runOutsideAngular(() => this.initThree());
  }

  ngOnDestroy() {
    if (this.animFrameId !== undefined) cancelAnimationFrame(this.animFrameId);
    if (this.resizeHandler) window.removeEventListener('resize', this.resizeHandler);
    this.renderer?.dispose();
  }

  private initThree(): void {
    const canvas = this.canvasRef().nativeElement;
    const w = canvas.clientWidth  || 600;
    const h = canvas.clientHeight || 400;

    // renderer
    const renderer = new THREE.WebGLRenderer({ canvas, antialias: true });
    renderer.setSize(w, h);
    renderer.setPixelRatio(window.devicePixelRatio);
    renderer.outputColorSpace = THREE.SRGBColorSpace;
    this.renderer = renderer;

    // escena
    const scene = new THREE.Scene();
    scene.background = new THREE.Color(0xd3d3d3);

    // camara
    const camera = new THREE.PerspectiveCamera(45, w / h, 0.01, 2000);
    camera.position.set(0, 1, 5);

    // controles
    const controls = new OrbitControls(camera, renderer.domElement);
    controls.enableDamping = true;
    controls.dampingFactor = 0.05;

    // iluminacion
    const hemi = new THREE.HemisphereLight(0xffffff, 0x444444, 2);
    hemi.position.set(0, 20, 0);
    scene.add(hemi);
    const dir = new THREE.DirectionalLight(0xffffff, 1.5);
    dir.position.set(5, 10, 5);
    scene.add(dir);

    // cargar modelo fbx
    new FBXLoader().load(
      this.modelUrl,
      (model) => {
        scene.add(model);

        // ajustar modelo
        const box = new THREE.Box3().setFromObject(model);
        const center = new THREE.Vector3();
        const size = new THREE.Vector3();
        box.getCenter(center);
        box.getSize(size);
        const maxDim = Math.max(size.x, size.y, size.z);
        camera.position.set(center.x, center.y + maxDim * 0.5, center.z + maxDim * 1.8);
        controls.target.copy(center);
        controls.update();
      },
      undefined,
      (err) => console.error('Error cargando FBX:', err)
    );

    // loop de render
    const animate = () => {
      this.animFrameId = requestAnimationFrame(animate);
      controls.update();
      renderer.render(scene, camera);
    };
    animate();

    // resize
    this.resizeHandler = () => {
      const w = canvas.clientWidth;
      const h = canvas.clientHeight;
      camera.aspect = w / h;
      camera.updateProjectionMatrix();
      renderer.setSize(w, h);
    };
    window.addEventListener('resize', this.resizeHandler);
  }

  onEsc() {
     this.cerrar.emit();
     }
}
