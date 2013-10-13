package u_test
{
	import away3d.containers.*;
	import away3d.controllers.*;
	import away3d.core.math.*;
	import away3d.debug.*;
	import away3d.entities.*;
	import away3d.lights.*;
	import away3d.materials.*;
	import away3d.materials.lightpickers.*;
	import away3d.primitives.*;
	import com.gestureworks.away3d.*;
	import com.gestureworks.core.*;
	import com.gestureworks.events.*;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.ui.*;
	
	[SWF(width = "1920", height = "1080", backgroundColor = "0x000000", frameRate = "60")]
		
	public class u_test3d extends GestureWorks 
	{
		private const WIDTH:Number = 1920;
		private const HEIGHT:Number = 1080;
		private var ts:*;
		protected var view:View3D;
		protected var lightPicker:StaticLightPicker;
		protected var cameraController:HoverController;
		private var light:PointLight;
		private var mouseIsDown:Boolean;
		private var lastPanAngle:Number;
		private var lastTiltAngle:Number;
		private var lastMouseX:Number;
		private var lastMouseY:Number;
		private var tiltIncrement:Number = 0;
		private var panIncrement:Number = 0;
		private var cube:Mesh;
		private var inactiveMaterial:ColorMaterial;
		private var activeMaterial:ColorMaterial;
		private var newX:Number = 0;
		private var newY:Number = 0;				
		private var vis3d:Away3DMotionVisualizer;
		private var plane:Mesh;
		
		public function u_test3d():void 
		{
			super();
			fullscreen = true;
			gml = "library/gml/gestures.gml";
		}
		
		override protected function gestureworksInit():void 
		{
			initialize();
			leap3D = true;
		}
		
		private function initialize():void 
		{
			initAway3d();
			onSetup();
			addEventListener( Event.ENTER_FRAME, enterframeHandler );
		}

		protected function initAway3d():void 
		{
			view = new View3D();
			view.backgroundColor = 0x777777;
			view.width = WIDTH;
			view.height = HEIGHT;
			view.antiAlias = 4;
			view.camera.lens.far = 15000;
			//view.forceMouseMove = true;
			addChild(view);
			
			view.camera.position = new Vector3D(-20, -50, -400);

			lightPicker = new StaticLightPicker( [] );
			light = new PointLight();
			lightPicker.lights = [ light ];
			view.scene.addChild( light );

			addChild(new AwayStats(view));
			
			var axis:Trident = new Trident(180);
			view.scene.addChild(axis);	
		}
		
		private function onSetup():void 
		{	
			activeMaterial = new ColorMaterial( 0xFF0000 );
			activeMaterial.lightPicker = lightPicker;
			inactiveMaterial = new ColorMaterial( 0xCCCCCC );
			inactiveMaterial.lightPicker = lightPicker;

			cube = new Mesh( new CubeGeometry(), inactiveMaterial );
			cube.x = 0;
			cube.y = 0;
			cube.z = 0;
			cube.mouseEnabled = true;
			view.scene.addChild(cube);
			
			Away3DTouchManager.initialize();			
			ts = Away3DTouchManager.registerTouchObject(cube);
			ts.gestureList = { "n-drag3D":true, "n-scale3D":true, "n-rotate3D":true };
			//ts.gestureList = { "n-drag-inertia":true, "n-rotate-inertia":true, "n-scale-inertia":true, "n-3d-transform-finger":true  };
			//ts.gestureList = { "n-drag-inertia":true, "n-3d-transform-finger":true  };
			//ts.gestureList = { "n-3d-transform-finger":true };
			//ts.gestureList = { "n-3d-transform-finger":true, "n-drag3D":true, "n-scale3D":true, "n-rotate3D":true  };
			//ts.gestureList = { "n-drag-inertia":true };
			ts.nativeTransform = true;
			ts.gestureReleaseInertia = true;
			ts.gestureEvents = true;
			ts.visualizer.pointDisplay = true;
			ts.visualizer.clusterDisplay = true;
			ts.visualizer.gestureDisplay = true;
			
			//ts.addEventListener(GWGestureEvent.DRAG, onDrag);
			//ts.addEventListener(GWGestureEvent.ROTATE, onRotate);			
			//ts.addEventListener(GWGestureEvent.SCALE, onScale);	
		}
				
		private function onDrag(e:GWGestureEvent):void
		{
			//trace("drag values:", e.value.drag_dx, e.value.drag_dy, e.value.drag_dz);
			cube.x += e.value.drag_dx;
			cube.y += e.value.drag_dy;
			cube.z += e.value.drag_dz;
		}
		
		private function onRotate(e:GWGestureEvent):void
		{
			//trace("rotate values:", e.value.rotate_dthetaX, e.value.rotate_dthetaY, e.value.rotate_dthetaZ);				
			//cube.rotationX += e.value.rotate_dthetaX;
			//cube.rotationY += e.value.rotate_dthetaY;
			//cube.rotationZ += e.value.rotate_dthetaZ;			
			//var length:Number = view.camera.project(cube.scenePosition).length;
			//cube.rotationZ += e.value.rotate_dtheta / 3;
		}
		
		private function onScale(e:GWGestureEvent):void
		{
			//trace("scale values:", e.value.scale_dsx, e.value.scale_dsy, e.value.scale_dsz);
			cube.scaleX += e.value.scale_dsx;
			cube.scaleY += e.value.scale_dsy;
			cube.scaleZ += e.value.scale_dsz;
		}
		
		private function update():void 
		{
			//vis3d.updateDisplay();	
			light.position = view.camera.position;
			view.render();			
		}

		private function enterframeHandler( event:Event ):void 
		{
			//ts.updateTarget();
			//trace("-----------", cube.x, cube.y, cube.z);
			update();
		}		
		
	}
}