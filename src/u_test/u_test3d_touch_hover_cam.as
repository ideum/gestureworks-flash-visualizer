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
	import com.gestureworks.away3d.utils.MotionVisualizer3D;
	import com.gestureworks.core.*;
	import com.gestureworks.events.*;
	import com.gestureworks.interfaces.ITouchObject;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.ui.*;
	
	[SWF(width = "1920", height = "1080", backgroundColor = "0x000000", frameRate = "60")]
		
	public class u_test3d_touch_hover_cam extends GestureWorks 
	{
		private const WIDTH:Number = 1920;
		private const HEIGHT:Number = 1080;
		private var ts:ITouchObject;
		private var view:View3D;
		private var lightPicker:StaticLightPicker;
		private var cameraController:HoverController;
		private var light:PointLight;
		private var mouseIsDown:Boolean;
		private var lastPanAngle:Number;
		private var lastTiltAngle:Number;
		private var lastMouseX:Number;
		private var lastMouseY:Number;
		private var tiltInc:Number = 0;
		private var panInc:Number = 0;
		private var cube:Mesh;
		private var inactiveMaterial:ColorMaterial;
		private var activeMaterial:ColorMaterial;
		private var newX:Number = 0;
		private var newY:Number = 0;				
		private var vis3d:MotionVisualizer3D;
		private var plane:Mesh;
		
		public function u_test3d_touch_hover_cam():void 
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
		
			cameraController = new HoverController( view.camera, null, 0, 0, -400);
			cameraController.yFactor = 2;
			cameraController.wrapPanAngle = true;

			lightPicker = new StaticLightPicker( [] );
			light = new PointLight();
			lightPicker.lights = [ light ];
			view.scene.addChild( light );

			addChild(new AwayStats(view));
			
			//var axis:Trident = new Trident(180);
			//5view.scene.addChild(axis);	
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
			
			TouchManager3D.initialize();			
			ts = TouchManager3D.registerTouchObject(cube);
				ts.gestureList = { "n-drag-3d":true, "n-scale-3d":true, "n-rotate-3d":true };
				//ts.gestureList = { "n-drag-inertia":true, "n-rotate-inertia":true, "n-scale-inertia":true, "n-3d-transform-finger":true  };
				//ts.gestureList = { "n-drag-inertia":true, "n-3d-transform-finger":true  };
				//ts.gestureList = { "n-3d-transform-finger":true };
				//ts.gestureList = { "n-3d-transform-finger":true, "n-drag3D":true, "n-scale3D":true, "n-rotate3D":true  };
				//ts.gestureList = { "n-drag-inertia":true };
				ts.nativeTransform = false;
				ts.affineTransform = false;
				//ts.disableAffineTransform = true;
				ts.gestureReleaseInertia = true;
				ts.gestureEvents = true;
				//ts.transform3d = true; //output
				//ts.motion3d = true //input
				
				ts.visualizer.pointDisplay = true;
				ts.visualizer.clusterDisplay = true;
				ts.visualizer.gestureDisplay = true;
				ts.addEventListener(GWGestureEvent.DRAG, onDrag);
				
				ts.addEventListener(GWGestureEvent.ROTATE, onRotate);			
				//ts.addEventListener(GWGestureEvent.SCALE, onScale);	
			
			var touchCamera:TouchSprite = new TouchSprite(view);
			touchCamera.gestureList = { "n-drag":true };
			touchCamera.addEventListener(GWGestureEvent.DRAG, onCameraDrag);
		}
		
		private function onCameraDrag(e:GWGestureEvent):void
		{
			
			trace(view.x, view.y);			
			//trace("camera drag values:", e.value.drag_dx, e.value.drag_dy);
			cameraController.panAngle += e.value.drag_dx * .25;
			//cameraController.tiltAngle += e.value.drag_dy * .25;
		}
		
				
		private function onDrag(e:GWGestureEvent):void
		{
		//	trace("drag values:", e.value.drag_dx, e.value.drag_dy, e.value.drag_dz);
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
			//trace("rotate values:", e.value.rotate_dthetaX, e.value.rotate_dthetaY, e.value.rotate_dthetaZ);	
			
			// normalizes from rotated parent containers -> TODO: integrate this into framework
			var v:Vector3D = new Vector3D( e.value.rotate_dthetaX, e.value.rotate_dthetaY, e.value.rotate_dthetaZ) ; 
			var n:Number = v.x + v.y + v.z;			
			
			var vm:Vector3D = view.camera.forwardVector;
			var m:Matrix3D = cube.inverseSceneTransform; 						
			var vm2:Vector3D = m.deltaTransformVector(vm); 	
			
			var xo:Number = vm2.x;
			var yo:Number = vm2.y;
			var zo:Number = vm2.z;
			//
				//if (view.camera.rotationY > 180 && view.camera.rotationY < 270  ) {
					//zo *= -1;
				//}else if (view.camera.rotationY > -90 && view.camera.rotationY < 0  ) {
					//xo *= -1;
				//}
			
			if (xo < -20) {
				xo = 0;
			}
			if (xo < -20) {
				yo = 0;
			}
			if (xo < -20) {
				zo = 0;
			}				
			
			var rr:Vector3D = new Vector3D(Number(Math.abs(xo)), Number(Math.abs(yo)), Number(Math.abs(zo)));
			///var rr:Vector3D = view.camera.upVector.crossProduct(view.camera.rightVector);
			
			trace("\n",view.camera.forwardVector)
			trace(rr);
			trace(n);

			//var axis:Vector3D = new Vector3D();
			//cube.transform.copyColumnTo(1, axis);
			//cube.transform.appendRotation(n, axis); 			
			//cube.transform = cube.transform;			
						
			
			
			cube.rotate(rr,n);
			
			
			//if (v.x > -20) {
				//cube.rotationX += n;
			//}
			//if (v.y > -20) {
				//cube.rotationY += n;
			//}
			//if (v.z > -20) {
				//cube.rotationZ += n;
			//}			

			//cube.rotationY += v.y;
			//cube.rotationZ += v.z;

		}
		
		private function onScale(e:GWGestureEvent):void
		{
			//trace("scale values:", e.value.scale_dsx, e.value.scale_dsy, e.value.scale_dsz);
			cube.scaleX += e.value.scale_dsx;
			cube.scaleY += e.value.scale_dsy;
			cube.scaleZ += e.value.scale_dsz;
		}
	
		private function enterframeHandler( event:Event ):void 
		{
			update();
		}		
	
		private function update():void 
		{
			//vis3d.updateDisplay();

			light.position = view.camera.position;
			view.render();			
		}	
	}
}