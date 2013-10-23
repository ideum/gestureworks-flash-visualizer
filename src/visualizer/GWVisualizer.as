package visualizer {			 
	import com.gestureworks.cml.element.Graphic;
	import com.gestureworks.cml.element.TouchContainer;
	import com.gestureworks.cml.utils.document;
	import com.gestureworks.core.GestureGlobals;
	import com.gestureworks.core.GestureWorks;
	import com.gestureworks.core.TouchSprite;
	import flash.events.Event;
	import visualizer.panels.ConfigPanel;
	import visualizer.panels.FramePanel;
	import visualizer.scenes.Interactive2D;
	import visualizer.scenes.Interactive3D;
	
	public class GWVisualizer extends TouchContainer {
		public static var currentTab:String = "mode";		
		public static var currentDataTab:String = "touch";		
		public static var currentView:String = "2D";	
		public static var captureLength:int = 60;
		
		public static var touchObject2D:TouchSprite;
		public static var gestureObject2D:TouchSprite;
		
		public static var interactive3D:Interactive3D;
		public static var gestureObject3D:TouchSprite;
		
		private var gw:GestureWorks;		
		
		private var framePanel:FramePanel;
				
		public function GWVisualizer() {
			super();
			mouseChildren = true;
			GestureGlobals.pointHistoryCaptureLength = captureLength;
			GestureGlobals.clusterHistoryCaptureLength = captureLength;
			GestureGlobals.timelineHistoryCaptureLength = captureLength;
		}	
		
		
		// setup
		public function setup(_gw:GestureWorks):void {
			gw = _gw;
			framePanel = getElementsByTagName("FramePanel")[0];
			touchObject2D = getElementById("touch-object-2d");
			gestureObject2D = getElementById("gesture-object-2d");
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		
		// update
		private function update():void {
			framePanel.update();
			if (contains(interactive3D)) 
				interactive3D.update();			
		}

		
		// event handlers
		private function onEnterFrame(e:Event):void {
			update();
		}
		
	}
}