package vis.interactives {
	import com.gestureworks.away3d.TouchManager3D;
	import com.gestureworks.away3d.utils.MotionVisualizer3D;
	import com.gestureworks.away3d.utils.TransformUtils;
	import com.gestureworks.cml.away3d.elements.TouchContainer3D;
	import com.gestureworks.cml.utils.document;
	import com.gestureworks.core.TouchSprite;
	import com.gestureworks.core.TouchVisualizer;
	import com.gestureworks.events.GWGestureEvent;
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	import vis.GWVisualizer;
	import vis.scenes.Display3D;
	import vis.Settings;
	
	/**
	 * ...
	 * @author 
	 */
	public class Interactive3D extends Display3D { 
		
		private var touchCamera:TouchSprite;
		private var gwVisualizer:GWVisualizer;
		
		public var gestureObject3D:GestureObject3D;
		private var _visible:Boolean = true;
		
		private var goviz:TouchSprite;
		
		public function Interactive3D() {
			super();
		}
		
		override public function setup(_gwVisualizer:GWVisualizer=null):void {
			super.setup();
			
			gwVisualizer = _gwVisualizer;
			TouchManager3D.initialize(); 			
			
			gestureObject3D = new GestureObject3D();
			gestureObject3D.vto = cube;

			TouchManager3D.registerTouchObject(gestureObject3D, false);
			TouchManager3D.onlyTouchEnabled = true;
			
			gestureObject3D.gestureList = { "n-drag":true, "n-rotate":true, "n-scale":true, "3-finger-tilt":true };
			_gwVisualizer.addChild(gestureObject3D);
			
			//gestureObject3D.gestureList = { "3dmotion-n-pinch-3dtransform":true, "3dmotion-1-pinch-hold":true, "n-drag-3d":true, "n-rotate-3d":true, "n-scale-3d":true };
			gestureObject3D.motionEnabled = false;		
			gestureObject3D.affineTransform = false;
			gestureObject3D.nativeTransform = false;
			gestureObject3D.releaseInertia = false;
			gestureObject3D.gestureEvents = true;
			//gestureObject3D.transform3d = false; 
			gestureObject3D.visible = true;
			gestureObject3D.touch3d = false;
			gestureObject3D.touchEnabled = true;
			
			// add gesture event listeners	
			gestureObject3D.addEventListener(GWGestureEvent.DRAG, onDrag); 		
			gestureObject3D.addEventListener(GWGestureEvent.ROTATE, onRotate);
			gestureObject3D.addEventListener(GWGestureEvent.SCALE, onScale); 	
			gestureObject3D.addEventListener(GWGestureEvent.TILT, onTilt);
			gestureObject3D.addEventListener(GWGestureEvent.START, onStart); 
			
			gestureObject3D.setup();

			touchCamera = new TouchSprite(view3D);
			touchCamera.gestureList = { "n-drag":true };
			touchCamera.addEventListener(GWGestureEvent.DRAG, onCameraDrag);	
			
			// GestureWorks Visualization
			//motionVizualizer = new MotionVisualizer3D();
			//motionVizualizer.lightPicker = lightPicker;
			//motionVizualizer.init();
			//motionVizualizer.cO = gestureObject3D.cO;
			//motionVizualizer.trO = gestureObject3D.trO;
			//scene.addChild(motionVizualizer);					
			
			gwVisualizer.addChildAt(view3D, gwVisualizer.numChildren - 3);			
		}		
		private var ax:Vector3D;
		
		private function onStart(e:GWGestureEvent):void 
		{
			//choose one
			ax = TransformUtils.alignRotateToCamera(cube, view3D.camera);
			//axis = TransformUtils.snapRotateToCamera(cube, view.camera);
		}
		
		override public function update():void {			
			super.update();
			
			if (newV && gestureObject3D) {
				ax = TransformUtils.snapRotateToCamera(cube, view3D.camera);
				var v:Vector3D = view3D.unproject(newV.x, newV.y, gestureObject3D['distance']);
				var cubeParentMtxInv:Matrix3D = cube.parent.inverseSceneTransform;
				v = cubeParentMtxInv.transformVector(v);				
				
				var v2:Vector3D = view3D.unproject(newV.x, newV.y, gestureObject3D['distance']);
				
				cube.position = v;
				newV = null;
				gestureObject3D.visualizer.updateDebugDisplay();

			}
			
		}		
		
		private function onCameraDrag(e:GWGestureEvent):void {
			if (GWVisualizer.active3D) {
				camera.panAngle += e.value.drag_dx * .25;
				camera.tiltAngle += e.value.drag_dy * .25;
			}
		}		
		
		
		/**
		 * Visible override
		 */
		public function get visible():Boolean {
			return _visible;
		}
		public function set visible(value:Boolean):void {
			_visible = value;
			view3D.visible = _visible;
		}			
		
		
		
		/**
		 * Rotate event handler
		 */
		private function onRotate(e:GWGestureEvent):void {	
			TransformUtils.updateAxisRotation(e, ax);	
		}
		
		private var newV:Vector3D;
		private var clusterV:Vector3D;
	
		/**
		 * Drag event handler
		 */
		private function onDrag(e:GWGestureEvent):void {			
			trace( gestureObject3D.cO.x, gestureObject3D.cO.y  );

			
			var v:Vector3D = view3D.unproject(gestureObject3D.cO.x, gestureObject3D.cO.y , e.target.distance);
			//var cubeParentMtxInv:Matrix3D = cube.parent.inverseSceneTransform;
			//v = cubeParentMtxInv.transformVector(v);
			//cube.position = v;
			clusterV = new Vector3D(gestureObject3D.cO.x, gestureObject3D.cO.y, e.target.distance);
			newV = new Vector3D(e.value.stageX, e.value.stageY, e.target.distance);
		}		
		
		/**
		 * Scale event handler
		 */
		private function onScale(e:GWGestureEvent):void {	
			// apply gesture scale values to cube			
			if (cube.scaleX +  e.value.scale_dsx >= .5 && cube.scaleX + e.value.scale_dsx <= 2) {
				cube.scaleX += e.value.scale_dsx;
				cube.scaleY += e.value.scale_dsx;
				cube.scaleZ += e.value.scale_dsx;
			}
			//trace("scale values:", e.value.scale_dsx, e.value.scale_dsy, e.value.scale_dsz);			
		}		
				
		/**
		 * Tilt event handler
		 */
		private function onTilt(e:GWGestureEvent):void {	
			trace("tilt values:", e.value.tilt_dx, e.value.tilt_dy);				
			cube.rotationY += e.value.tilt_dx * 250;
			cube.rotationX += e.value.tilt_dy * 250;
		}	
		
		
	}

}