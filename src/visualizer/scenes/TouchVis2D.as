package visualizer.scenes {
	import com.gestureworks.cml.element.Graphic;
	
	/**
	 * ...
	 * @author 
	 */
	public class TouchVis2D extends Graphic {
		
		public function TouchVis2D() {}
		
		// setup
		public function setup():void {
			nativeTransform = false;					
			debugDisplay = true;
			gestureEvents = true;
			visualizer.initDebug();
			visualizer.point.maxTrails = 20;
			visualizer.point.init();
			visualizer.pointDisplay = true;
			visualizer.clusterDisplay = false;			
			visualizer.gestureDisplay = false;
			Settings.setupVisualizer(this);					
		}
				
	}
}