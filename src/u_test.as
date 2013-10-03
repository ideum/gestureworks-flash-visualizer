package 
{
	import away3d.containers.*;
	import away3d.controllers.*;
	import away3d.core.math.*;
	import away3d.debug.*;
	import away3d.entities.*;
	import away3d.events.MouseEvent3D;
	import away3d.events.TouchEvent3D;
	import away3d.lights.*;
	import away3d.materials.*;
	import away3d.materials.lightpickers.*;
	import away3d.primitives.*;
	import away3d.tools.utils.Drag3D;
	import com.gestureworks.away3d.*;
	import com.gestureworks.core.*;
	import com.gestureworks.events.*;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.ui.*;
	
	[SWF(width = "1920", height = "1080", backgroundColor = "0x000000", frameRate = "60")]
		
	public class u_test extends GestureWorks 
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
		
		public function u_test():void 
		{
			super();
			fullscreen = true;
			gml = "library/gml/my_gestures.gml";
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
				view.forceMouseMove = true;
			addChild(view);
		

			cameraController = new HoverController( view.camera, null, -30, -60, -400)
			//cameraController.yFactor = 1;

			lightPicker = new StaticLightPicker( [] );
			light = new PointLight();
			lightPicker.lights = [ light ];
			view.scene.addChild( light );

			addChild(new AwayStats(view));
			
			var axis:Trident = new Trident(180);
			view.scene.addChild(axis);	
			
			

		}

		private var away:Away3DTouchManager;
		
		private var plane:Mesh;
		private var seg:SegmentSet;
				
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
				//ts.gestureList = { "n-3d-transform-finger":true  };
				//ts.gestureList = { "n-drag-inertia":true };
				ts.nativeTransform = false;
				//ts.disableAffineTransform = true;
				ts.gestureReleaseInertia = true;
				ts.gestureEvents = true;
				
				ts.transform3d = true; //output
				ts.motion3d = false //input
				
				//ts.visualizer.pointDisplay = true;
				//ts.visualizer.clusterDisplay = true;
				//ts.visualizer.gestureDisplay = true;
				
				ts.addEventListener(GWGestureEvent.DRAG, onDrag);
				ts.addEventListener(GWGestureEvent.ROTATE, onRotate);			
				ts.addEventListener(GWGestureEvent.SCALE, onScale);	
				
			//vis3d = new Away3DMotionVisualizer();
				//vis3d.init();
				//vis3d.cO = ts.cO;
				//vis3d.trO = ts.trO;
			//view.scene.addChild(vis3d);
			//stage.addEventListener( MouseEvent.MOUSE_DOWN, stageMouseDownHandler );
			//stage.addEventListener( MouseEvent.MOUSE_UP, stageMouseUpHandler );
			//stage.addEventListener( MouseEvent.MOUSE_WHEEL, stageMouseWheelHandler );
		}
				
		private function onDrag(e:GWGestureEvent):void
		{
			//trace("drag values:", e.value.drag_dx, e.value.drag_dy, e.value.drag_dz);
			
			var length:Number = view.camera.project(cube.scenePosition).length;

			cube.x += e.value.drag_dx * length;
			cube.y += e.value.drag_dy * length;
			cube.z += e.value.drag_dz * length;
		}
		
		private function onRotate(e:GWGestureEvent):void
		{
			//trace("rotate values:", e.value.rotate_dthetaX, e.value.rotate_dthetaY, e.value.rotate_dthetaZ);				
			//cube.rotationX += e.value.rotate_dthetaX;
			//cube.rotationY += e.value.rotate_dthetaY;
			//cube.rotationZ += e.value.rotate_dthetaZ;

			//cube.rotationX += e.value.rotate_dtheta;
			//cube.rotationY += e.value.rotate_dtheta;
			
			var length:Number = view.camera.project(cube.scenePosition).length;
			cube.rotationZ += e.value.rotate_dtheta / 3;

		}
		
		private function onScale(e:GWGestureEvent):void
		{
			//trace("scale values:", e.value.scale_dsx, e.value.scale_dsy, e.value.scale_dsz);
			
			var length:Number = view.camera.project(cube.scenePosition).length;
			
			cube.scaleX += e.value.scale_dsx * length;
			cube.scaleY += e.value.scale_dsy * length;
			cube.scaleZ += e.value.scale_dsz * length;
		}
		
		private function update():void 
		{
			//vis3d.updateDisplay();
			//_drag3D.updateDrag();
			if( mouseIsDown ) {
				cameraController.panAngle = 0.4 * ( view.mouseX - lastMouseX ) + lastPanAngle;
				cameraController.tiltAngle = 0.4 * ( view.mouseY - lastMouseY ) + lastTiltAngle;
			}
			cameraController.panAngle += panIncrement;
			cameraController.tiltAngle += tiltIncrement;			
			light.position = view.camera.position;
			view.render();			
		}

		private function enterframeHandler( event:Event ):void 
		{
			update();
		}		
	

		private function stageMouseDownHandler( event:MouseEvent ):void {
			mouseIsDown = true;
			lastPanAngle = cameraController.panAngle; 
			lastTiltAngle = cameraController.tiltAngle;
			lastMouseX = event.stageX;
			lastMouseY = event.stageY;
		}

		private function stageMouseWheelHandler(  event:MouseEvent  ):void {
			//cameraController.distance -= event.delta * 5;
			if( cameraController.distance < 150 )
				cameraController.distance = 150;
			else if( cameraController.distance > 2000 )
				cameraController.distance = 2000;
		}

		private function stageMouseUpHandler(  event:MouseEvent  ):void {
			mouseIsDown = false;
		}		
	}
	
}