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
	import com.gestureworks.away3d.utils.*;
	import com.gestureworks.core.*;
	import com.gestureworks.events.*;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.ui.*;
	
	[SWF(width = "1920", height = "1080", backgroundColor = "0x000000", frameRate = "60")]
		
	public class u_test3d_motion extends GestureWorks 
	{
		private const WIDTH:Number = 1920;
		private const HEIGHT:Number = 1080;
		private var ts:TouchSprite;
		private var ts2:TouchSprite;
		private var view:View3D;
		private var lightPicker:StaticLightPicker;
		private var cameraController:HoverController;
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
		private var vis3d:MotionVisualizer3D;
		private var vis3d2:MotionVisualizer3D;
		private var plane:Mesh;
		private var c:ObjectContainer3D;
		private var c2:ObjectContainer3D;
		
		private var dual:Boolean = true;
		
		public function u_test3d_motion():void 
		{
			super();
			fullscreen = true;
			//gml = "library/gml/touch_gestures.gml";
			gml ="library/gml/motion_gestures.gml";
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
			view.backgroundColor = 0x888888;
			view.width = WIDTH;
			view.height = HEIGHT;
			view.antiAlias = 4;
			view.camera.lens.far = 15000;
			//view.forceMouseMove = true;
			addChild(view);
			
			//view.camera.position = new Vector3D(0, -0, -400);
			view.camera.position = new Vector3D(50, 150, -500);
			
			cameraController = new HoverController(view.camera, null, 180, 30, 400);
			
			lightPicker = new StaticLightPicker( [] );
			light = new PointLight();
			lightPicker.lights = [ light ];
			view.scene.addChild( light );

			addChild(new AwayStats(view));
			
			//var axis:Trident = new Trident(180);
			//view.scene.addChild(axis);	
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
			
			
			TouchManager3D.initialize();			
			ts = TouchManager3D.registerTouchObject(cube);
			//ts.gestureList = { "n-drag3D":true, "n-scale3D":true, "n-rotate3D":true };
			//ts.gestureList = { "n-drag-inertia":true, "n-rotate-inertia":true, "n-scale-inertia":true, "n-3d-transform-finger":true  };
			//ts.gestureList = { "n-drag-inertia":true, "n-3d-transform-finger":true  };
			//ts.gestureList = { "n-3d-transform-finger":true };

			//ts.gestureList = { "n-3d-transform-finger":true, "n-drag3D":true, "n-scale3D":true, "n-rotate3D":true  };
			//ts.gestureList = { "n-drag3D":true, "n-scale3D":true, "n-rotate3D":true,"n-3d-transform-finger":true, "n-3d-transform-pinch":true,"n-3d-transform-trigger":true,"n-3d-transform-frame":true,"n-3d-transform-thumb":true,"n-3d-transform-hook":true };
			
			//ts.gestureList = { "3dmotion-1-finger-tap":true};
			ts.gestureList = { "3dmotion-1-finger-tap":true, "3dmotion-1-finger-hold":true, "3dmotion-1-pinch-3dtranslate":true, "3dmotion-1-trigger-3dtranslate":true, "3dmotion-1-finger-3dtranslate":false };
			//ts.gestureList = {"3dmotion-1-finger-3dtranslate":true, "3dmotion-1-pinch-3dtranslate":true };
			//ts.gestureList = {"3dmotion-1-pinch-3dtranslate":true,"3dmotion-1-finger-3dtranslate":true};
			
			//"3dmotion-1-pinch-hold":true
			//"3dmotion-1-finger-3dtranslate":true
			/*
			 * //"3dmotion-1-pinch-tap":false,
			 * 
			"3dmotion-n-hook-3dtransform":false,
			"3dmotion-n-frame-3dtransform":false,
			"3dmotion-n-trigger-3dtransform":false,
			
			"3dmotion-n-palm-3dtransform":false,
			"3dmotion-n-finger-3dtransform":false,
			"3dmotion-n-thumb-3dtransform":false,
			"3dmotion-1-finger-tap":false,
			"3dmotion-n-finger-tap":false,
			"3dmotion-1-finger-hold":false,
			"3dmotion-n-finger-hold":false,
			*/
			ts.motionClusterMode = "local_strong";
			//ts.motionClusterMode = "local_weak";
			//ts.motionClusterMode = "global";
			ts.view = view;
			ts.nativeTransform = true;
			ts.releaseInertia = false;
			ts.gestureEvents = true;

			ts.touchEnabled = true;
			ts.motionEnabled = true;
			
			ts.motion3d = true; 
			ts.transform3d = true; //NEED TO ENSURE NO 2D CLUSTER COOR TRANSFORM
			
			ts.visualizer.pointDisplay = true;
			ts.visualizer.clusterDisplay = true;
			ts.visualizer.gestureDisplay = true;
			
			//ts.addEventListener(GWGestureEvent.MOTION_DRAG, gestureMotionDragHandler);
		//	ts.addEventListener(GWGestureEvent.MOTION_ROTATE, gestureMotionRotateHandler);
		//	ts.addEventListener(GWGestureEvent.MOTION_SCALE, gestureMotionScaleHandler);
			ts.addEventListener(GWGestureEvent.MOTION_XTAP, gestureMotionTapHandler);
			ts.addEventListener(GWGestureEvent.MOTION_YTAP, gestureMotionTapHandler);
			ts.addEventListener(GWGestureEvent.MOTION_ZTAP, gestureMotionTapHandler);
			ts.addEventListener(GWGestureEvent.MOTION_TAP, gestureMotionTapHandler);
			ts.addEventListener(GWGestureEvent.MOTION_HOLD, gestureMotionHoldHandler);
			
			
			c = new ObjectContainer3D;
			c.addChild(cube);
			c.rotationX = 0;
			c.rotationY = 0;//90
			c.rotationZ = 0;
			c.x = 0;
			
			view.scene.addChild(c);
			ts.addEventListener(GWGestureEvent.DRAG, onDrag);
			ts.addEventListener(GWGestureEvent.ROTATE, onRotate);			
			ts.addEventListener(GWGestureEvent.SCALE, onScale);	
			
			vis3d = new MotionVisualizer3D();
			vis3d.lightPicker = lightPicker;
			vis3d.init();
			vis3d.cO = ts.cO;
			vis3d.trO = ts.trO;
			vis3d.tiO = ts.tiO;
			//vis3d.x = 200;
			view.scene.addChild(vis3d);	
			
			
			if (dual)
			{	
				ts2 = new TouchSprite();
				//ts2.gestureList = { "3dmotion-1-finger-tap":true, "3dmotion-1-finger-3dtranslate":true };
				//ts2.gestureList = { "n-drag":true,"3dmotion-1-finger-tap":false}
				//ts2.gestureList = { "3dmotion-1-finger-hold":false , "3dmotion-1-finger-3dtranslate":false, "3dmotion-1-trigger-3dtranslate":true, "n-drag":true, "n-rotate":true, "n-scale":true };
				ts2.gestureList = {"3dmotion-1-finger-3dtranslate":true, "3dmotion-1-trigger-3dtranslate":true, "n-drag":true, "n-rotate":true, "n-scale":true };
				//ts2.gestureList = {"3dmotion-1-finger-3dtranslate":true}
				//ts2.gestureList = {"n-drag":true,"n-rotate":true,"n-scale":true,"3dmotion-1-finger-tap":false,"3dmotion-1-finger-3dtranslate":true};//"3dmotion-1-finger-3dtranslate":true
				//ts2.gestureList = { "n-drag":true };
				//ts2.gestureList = { "n-manipulate":true };
				ts2.nativeTransform = true;
				ts2.affineTransform = true;
				ts2.releaseInertia = true;
				ts2.gestureEvents = true;
				
				//ts2.motionClusterMode = "global"
				//ts2.motionClusterMode = "local_weak"
				ts2.motionClusterMode = "local_strong"
				ts2.mouseChildren = false
				ts2.graphics.lineStyle(4, 0x333333, 1);
				ts2.graphics.beginFill(0x000000,0.3);
				ts2.graphics.drawRect(0, 0, 200, 200);
				ts2.x = stage.stageWidth*0.5;
				ts2.y = stage.stageHeight*0.5;

				ts2.touchEnabled = true;
				ts2.motionEnabled = true;
				
				ts2.motion3d = true; 
				ts2.transform3d = false; //NEED TO ENSURE NO 2D CLUSTER COOR TRANSFORM //ONLY WAY TO SHOW 2D MOTION DEBUG
				
				ts2.debugDisplay = true;
				ts2.visualizer.pointDisplay = true;
				ts2.visualizer.clusterDisplay = true;
				ts2.visualizer.gestureDisplay = true;
				
				//ts2.addEventListener(GWGestureEvent.MOTION_DRAG, gestureMotionDragHandler);
				ts2.addEventListener(GWGestureEvent.MOTION_HOLD, gestureMotionHoldHandler);
				
				vis3d2 = new MotionVisualizer3D();
				vis3d2.lightPicker = lightPicker;
				vis3d2.init();
				vis3d2.cO = ts2.cO;
				vis3d2.trO = ts2.trO;
				vis3d2.tiO = ts2.tiO;
				vis3d2.x = 155;
				vis3d2.drawHands = false;
				
				
				view.scene.addChild(vis3d2);	
				
				addChild(ts2);
			}
		}

		////////////////////////////////////////////////////////////////
		// MOTION GESTURES
		////////////////////////////////////////////////////////////////
		private function gestureMotionDragHandler(event:GWGestureEvent):void
		{	
			trace("gesture event motion drag:		",event.value.dx,event.value.dy,event.value.dz)
			//event.target.x += event.value.drag_dx;
			//event.target.y += event.value.drag_dy;
		}
		private function gestureMotionRotateHandler(event:GWGestureEvent):void
		{
			trace("gesture event motion rot:		",event.value.rotate_dtheta)
			//event.target.rotation += event.value.rotate_dtheta;
		}
		private function gestureMotionScaleHandler(event:GWGestureEvent):void
		{
			trace("gesture event motion scale:		", event.value.scale_dsx, event.value.scale_dsy, event.value.n);
			//event.target.scaleX += event.value.scale_dsx;
			//event.target.scaleY += event.value.scale_dsy;
		}
		
		private function gestureMotionTapHandler(event:GWGestureEvent):void
		{
			trace("gesture event motion tap:		", event.type, event.value.x, event.value.y, event.value.z, event.value.n, event.value.gestureID);
			//event.target.scaleX += event.value.scale_dsx;
		}
		
		private function gestureMotionHoldHandler(event:GWGestureEvent):void
		{
			trace("gesture event motion hold:		", event.type, event.value.x, event.value.y,event.value.z, event.value.n, event.value.gestureID);
			//event.target.scaleX += event.value.scale_dsx;
		}
		
		
		
		
		private function onDrag(e:GWGestureEvent):void
		{
			trace("\ndrag:", e.value.drag_dx, e.value.drag_dy, e.value.drag_dz);			
			
			// normalizes from rotated parent containers -> TODO: integrate this into framework
			var m:Matrix3D = cube.parent.inverseSceneTransform; 							
			var v:Vector3D = new Vector3D( e.value.drag_dx, e.value.drag_dy, e.value.drag_dz) ; // because the object is "facing" to the left; 
			v = m.deltaTransformVector(v); 
			trace(v);
				
			cube.x += v.x;
			cube.y += v.y;
			cube.z += v.z;
		}
		
		private function onRotate(e:GWGestureEvent):void
		{
			trace("rotate values:", e.value.rotate_dthetaX, e.value.rotate_dthetaY, e.value.rotate_dthetaZ);	
			
			// normalizes from rotated parent containers -> TODO: integrate this into framework
			var m:Matrix3D = cube.parent.inverseSceneTransform; 
			var v:Vector3D = new Vector3D( e.value.rotate_dthetaX, e.value.rotate_dthetaY, e.value.rotate_dthetaZ) ; // because the object is "facing" to the left; 
			v = m.deltaTransformVector(v); 			
			
			cube.rotationX += v.x;
			cube.rotationY += v.y;
			cube.rotationZ += v.z;			
		}
		
		private function onScale(e:GWGestureEvent):void
		{
			trace("scale values:", e.value.scale_dsx, e.value.scale_dsy, e.value.scale_dsz);
			cube.scaleX += e.value.scale_dsx;
			cube.scaleY += e.value.scale_dsy;
			cube.scaleZ += e.value.scale_dsz;
		}
		
		private function update():void 
		{
			vis3d.updateDisplay();	
			if(dual) vis3d2.updateDisplay();	
			light.position = view.camera.position;
			view.render();			
		}

		private function enterframeHandler( event:Event ):void 
		{
			update();
		}		
		
	}
}