package vis.interactives {
	import com.gestureworks.cml.elements.Graphic;
	import vis.Settings;
	
	/**
	 * ...
	 * @author 
	 */
	public class Interactive2D extends Graphic {
		
		public function Interactive2D() {}
		
		// setup
		public function setup():void {
			nativeTransform = false;					
			debugDisplay = true;
			gestureEvents = false;
			visualizer.point.maxTrails = 30;
			visualizer.point.init();
			visualizer.pointDisplay = true;
			visualizer.clusterDisplay = false;			
			visualizer.gestureDisplay = false;
			Settings.setupVisualizer(this);			
		}
				
	}
}