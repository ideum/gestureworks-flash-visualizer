package vis.interactives {
	import com.gestureworks.away3d.TouchManager3D;
	import com.gestureworks.away3d.utils.MotionVisualizer3D;
	import com.gestureworks.cml.away3d.elements.TouchContainer3D;
	import com.gestureworks.core.TouchSprite;
	import com.gestureworks.events.GWGestureEvent;
	import vis.GWVisualizer;
	import vis.scenes.Display3D;
	
	/**
	 * ...
	 * @author 
	 */
	public class Interactive3D extends Display3D { 
		
		private var touchCamera:TouchSprite;
		private var gwVisualizer:GWVisualizer;
		
		public var gestureObject3D:TouchContainer3D;
		private var _visible:Boolean = true;
		
		//private var goviz:TouchSprite;
		
		public function Interactive3D() {
			super();
		}
		
		override public function setup(_gwVisualizer:GWVisualizer=null):void {
			super.setup();
			
			gwVisualizer = _gwVisualizer;
			TouchManager3D.initialize(); 			
			
			gestureObject3D = new GestureObject3D();
			gestureObject3D.vto = cube;
			
			TouchManager3D.registerTouchObject(gestureObject3D);
			
			gestureObject3D.gestureList = { "n-drag-3d":true, "n-rotate-3d":true, "n-scale-3d":true };
			//gestureObject3D.gestureList = { "3dmotion-n-pinch-3dtransform":true, "3dmotion-1-pinch-hold":true };
			gestureObject3D.motionEnabled = true;						
			gestureObject3D.nativeTransform = true;
			gestureObject3D.releaseInertia = true;
			gestureObject3D.gestureEvents = true;
			gestureObject3D.transform3d = true; 
			gestureObject3D.visible = false;
			
			//goviz.debugDisplay = true;
			//Settings.setupVisualizer(goviz);
			
			touchCamera = new TouchSprite(view3D);
			touchCamera.gestureList = { "n-drag":true };
			touchCamera.addEventListener(GWGestureEvent.DRAG, onCameraDrag);	

			
			// GestureWorks Visualization
			motionVizualizer = new MotionVisualizer3D();
			motionVizualizer.lightPicker = lightPicker;
			motionVizualizer.init();
			motionVizualizer.cO = gestureObject3D.cO;
			motionVizualizer.trO = gestureObject3D.trO;
			scene.addChild(motionVizualizer);					
			
			//gwVisualizer.addChildAt(goviz, gwVisualizer.numChildren-3);			
			gwVisualizer.addChildAt(view3D, gwVisualizer.numChildren - 3);
			
			
		}		
		
		//public function addView():void {			
			//switch (tab) {
				//case "point":
					//if (motion) {
						//motionVizualizer.drawPoints = true;
						//motionVizualizer.drawClusters = false;
						//motionVizualizer.drawGestures = false;
						//scene.addChild(motionVizualizer);
					//}
					//break;
				//case "cluster": 
					//if (motion) {
						//motionVizualizer.drawClusters = true;
						//motionVizualizer.drawGestures = false;						
						//scene.addChild(motionVizualizer);
					//}
					//break;
				//case "gesture": 
					//scene.addChild(cube);	
					//if (motion) {
						//motionVizualizer.drawGestures = true;
						//scene.addChild(motionVizualizer);
					//}
					//break;
			//}
						//
		//}	
		
		override public function update():void {			
			super.update();
		}		
		
		
		private function onCameraDrag(e:GWGestureEvent):void {
			if (GWVisualizer.active3D) {
				camera.panAngle += e.value.drag_dx * .25;
				camera.tiltAngle += e.value.drag_dy * .25;
			}
		}		
		
		
		
		public function get visible():Boolean {
			return _visible;
		}
		
		public function set visible(value:Boolean):void {
			_visible = value;
			view3D.visible = _visible;
		}
					
		
	}

}