package visualizer {			 
	import com.gestureworks.cml.element.TouchContainer;
	import com.gestureworks.cml.utils.document;
	import com.gestureworks.core.GestureGlobals;
	import com.gestureworks.core.GestureWorks;
	import com.gestureworks.core.TouchSprite;
	import flash.events.Event;
	import visualizer.panels.ConfigPanel;
	import visualizer.panels.FramePanel;
	import visualizer.scenes.Interactive3D;
	
	public class GWVisualizer extends TouchContainer {

		public static var gw:GestureWorks;		
		public static var touchObject2D:TouchSprite;
		public static var gestureObject2D:TouchSprite;
		public static var interactive3D:Interactive3D;
		public static var gestureObject3D:TouchSprite;
		public static var currentTab:String = "mode";		
		public static var currentDataTab:String = "touch";		
		public static var currentView:String = "2D";	
		public static var captureLength:int = 60;		
		
		private var framePanel:FramePanel;
		private var configPanel:ConfigPanel;
				
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
			scale *= stage.stageWidth / 1920;	

			touchObject2D = getElementById("touch-object-2d");
			gestureObject2D = getElementById("gesture-object-2d");
			framePanel = document.getElementsByTagName("FramePanel")[0];
			configPanel = document.getElementsByTagName("ConfigPanel")[0];
			
			framePanel.setup();
			configPanel.setup();
				
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		
		// update
		private function update():void {
			framePanel.update();
			//if (contains(interactive3D)) 
				//interactive3D.update();			
		}

		
		// event handlers
		private function onEnterFrame(e:Event):void {
			update();
		}
		
	}
}