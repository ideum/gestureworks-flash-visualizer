package vis {			 
	import com.gestureworks.cml.element.TouchContainer;
	import com.gestureworks.cml.utils.document;
	import com.gestureworks.core.GestureGlobals;
	import com.gestureworks.core.GestureWorks;
	import com.gestureworks.core.TouchSprite;
	import flash.events.Event;
	import vis.interactives.GestureObject2D;
	import vis.interactives.GestureObject3D;
	import vis.interactives.Interactive2D;
	import vis.interactives.Interactive3D;
	import vis.panels.ConfigPanel;
	import vis.panels.FramePanel;
	import vis.Settings;
	
	public class GWVisualizer extends TouchContainer {		

		public static var gw:GestureWorks;		
		
		public static var interactive2D:Interactive2D;
		public static var gestureObject2D:GestureObject2D;
		
		public static var interactive3D:Interactive3D;
		public static var gestureObject3D:TouchSprite;
		
		public static var currentTab:String = "mode";		
		public static var currentDataTab:String = "touch";				
		
		public static var active2D:Boolean = true;
		public static var active3D:Boolean = true;
		
		private var framePanel:FramePanel;
		private var configPanel:ConfigPanel;
				
		public function GWVisualizer() {
			super();
			mouseChildren = true;
		}	
		
		
		// setup
		public function setup(_gw:GestureWorks):void {
			gw = _gw;
			
			GestureGlobals.pointHistoryCaptureLength = Settings.captureLength;
			GestureGlobals.clusterHistoryCaptureLength = Settings.captureLength;
			GestureGlobals.timelineHistoryCaptureLength = Settings.captureLength;			
			
			interactive2D = document.getElementsByTagName("Interactive2D")[0];
			gestureObject2D = document.getElementsByTagName("GestureObject2D")[0];
			
			
			framePanel = document.getElementsByTagName("FramePanel")[0];
			configPanel = document.getElementsByTagName("ConfigPanel")[0];
			
			interactive2D.setup();			
			gestureObject2D.setup();

			interactive3D = new Interactive3D;
			interactive3D.setup(this);
			gestureObject3D = interactive3D.gestureObject3D;
			
			framePanel.setup();
			configPanel.setup(interactive3D);			
			
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
	
		
		// update
		private function update():void {
			framePanel.update();
			configPanel.update();
			
			if (active2D) {
				gestureObject2D.update();
			}
			if (active3D) {
				interactive3D.update();
			}
		}

		
		// event
		private function onEnterFrame(e:Event):void {
			update();
		}
		
	}
}