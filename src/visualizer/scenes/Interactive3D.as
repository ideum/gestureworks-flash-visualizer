package visualizer.scenes {
	import away3d.controllers.HoverController;
	import com.gestureworks.away3d.TouchManager3D;
	import com.gestureworks.away3d.TouchObject3D;
	import com.gestureworks.away3d.utils.MotionVisualizer3D;
	import com.gestureworks.core.TouchSprite;
	
	/**
	 * ...
	 * @author 
	 */
	public class Interactive3D extends Display3D {

		private var display3D:Display3D;
		private var gestureObject3D:TouchSprite;
		
		public function Interactive3D() {
			super();
		}
		
		override public function init():void {
			super.init();
			TouchManager3D.initialize();
			gestureObject = TouchManager3D.registerTouchObject(cube);
			gestureObject.active = true;
			gestureObject.gestureList = { "n-drag-3d":true, "n-rotate-3d":true, "n-scale-3d":true };
			gestureObject.nativeTransform = true;
			gestureObject.releaseInertia = true;
			gestureObject.gestureEvents = true;
			gestureObject.motion3d = true; //input			
			gestureObject.transform3d = true; //output
			gestureObject.debugDisplay = true;
		}
		
		private function setupGestureObject3D():void {
			gestureObject3D.visible = false;	
			gestureObject3D.nativeTransform = true;						
			gestureObject3D.debugDisplay = true;
			gestureObject3D.gestureEvents = true;
			gestureObject3D.visualizer.pointDisplay = true;
			gestureObject3D.visualizer.clusterDisplay = true;			
			gestureObject3D.visualizer.gestureDisplay = true;
			gestureObject3D.tiO.timelineOn = true;
		}
				
		
		public function addView(tab:String, motion:Boolean=false):void {
			scene.addChild(axis);				
			
			switch (tab) {
				case "point":
					if (motion) {
						motionVizualizer.drawPoints = true;
						motionVizualizer.drawClusters = false;
						motionVizualizer.drawGestures = false;
						scene.addChild(motionVizualizer);
					}
					break;
				case "cluster": 
					if (motion) {
						motionVizualizer.drawClusters = true;
						motionVizualizer.drawGestures = false;						
						scene.addChild(motionVizualizer);
					}
					break;
				case "gesture": 
					scene.addChild(cube);	
					if (motion) {
						motionVizualizer.drawGestures = true;
						scene.addChild(motionVizualizer);
					}
					break;
			}
			
			addChild(view3D);	
			camera.tiltAngle = -45;				
			currentTab = tab;			
		}		
		
		public function updateView(tab:String, motion:Boolean=false):void{			
			switch (tab) {
				case "point":
					if (scene.contains(cube)) scene.removeChild(cube);					
					break;
				case "cluster": 
					if (scene.contains(cube)) scene.removeChild(cube);
					break;
				case "gesture": 
					scene.addChild(cube);	
					if (motion) scene.addChild(motionVizualizer);
					break;
			}
			
			currentTab = tab;
			view3D.render();
		}		
		
		public function removeView():void {
			camera.tiltAngle = 0;
			if (scene.contains(axis)) scene.removeChild(axis);			
			if (scene.contains(cube)) scene.removeChild(cube);
			if (scene.contains(motionVizualizer)) scene.removeChild(motionVizualizer);
			view3D.render();
			if (contains(view3D)) removeChild(view3D);
		}
					
		
	}

}