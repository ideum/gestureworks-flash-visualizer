package unit_test
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
	import away3d.tools.utils.Drag3D;
	import com.gestureworks.away3d.*;
	import com.gestureworks.core.*;
	import com.gestureworks.events.*;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.ui.*;
	
	[SWF(width = "1920", height = "1080", backgroundColor = "0x000000", frameRate = "60")]
		
	public class utest_away3d_touch extends GestureWorks 
	{
		private const WIDTH:Number = 1920;
		private const HEIGHT:Number = 1080;
		
		private var ts:*;
		protected var view:View3D;
		protected var lightPicker:StaticLightPicker;
		protected var cameraController:HoverController;
		private var light:PointLight;
		private var _mouseIsDown:Boolean;
		private var _lastPanAngle:Number;
		private var _lastTiltAngle:Number;
		private var _lastMouseX:Number;
		private var _lastMouseY:Number;

		private var cube:Mesh;
		private var inactiveMaterial:ColorMaterial;
		private var activeMaterial:ColorMaterial;
		
		private var newX:Number = 0;
		private var newY:Number = 0;		
		
		private var vis3d:Away3DMotionVisualizer;
		
		public function utest_away3d_touch():void 
		{
			super();
			fullscreen = true;
			gml = "library/gml/my_motion_gestures.gml";
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
		

			cameraController = new HoverController( view.camera, null, 45, 0, -400)
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
		
		private var _drag3D:TouchDrag3D;
		
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
			
			away = new Away3DTouchManager(view);
			
			//var v:Vector3D = away.cartesianToSpherical(new Vector3D(.707, .707, .707) );
			//
			//trace( v );
			//trace( away.sphericalToCartesian( v ) );
			//trace( v.x*MathConsts.RADIANS_TO_DEGREES, v.y*MathConsts.RADIANS_TO_DEGREES, v.z*MathConsts.RADIANS_TO_DEGREES );
						
	
			_drag3D = new TouchDrag3D(view, ObjectContainer3D(cube));
			_drag3D.useRotations = true;
			_drag3D.debug = true;
			//return;
			
			ts = away.registerTouchObject(cube);

				ts.gestureList = { "n-drag-inertia":true, "n-rotate-inertia":true, "n-scale-inertia":true };
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
				//ts.debugDisplay = true;
				
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

		}
				
		private function onDrag(e:GWGestureEvent):void
		{
			//var v:Vector3D = away.alignToCamera(cube, e.value.drag_dx, e.value.drag_dy, 0);
		
			
			//cube.x += v.x;
			//cube.y += v.y;
			//cube.z += v.z;	
			
			
		}
		
		private function onRotate(e:GWGestureEvent):void
		{			
			var vec:Vector3D = new Vector3D(e.value.rotate_dtheta, e.value.rotate_dtheta, e.value.rotate_dtheta);
			
			//if (rot.x < 0)
				//rot.x = 270 + rot.x * -1;
			//else if (rot.y < 0)
				//rot.y = 270 + rot.y * -1;
			//else if (rot.z < 0)
				//rot.z = 270 + rot.z * -1;
				
			cube.rotationZ += vec.x;
		}
		
		private function onScale(e:GWGestureEvent):void
		{			
			//cube.scaleX += e.value.scale_dsx;
			//cube.scaleY += e.value.scale_dsx;
			//cube.scaleZ += e.value.scale_dsx;
		}
		
		private function update():void 
		{
			//vis3d.updateDisplay();
			//_drag3D.updateDrag();
			light.position = view.camera.position;
			view.render();			
		}

		private function enterframeHandler( event:Event ):void 
		{
			update();
		}		
	
		
	}
	
}