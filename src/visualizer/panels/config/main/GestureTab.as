package visualizer.panels.config.main {
	import com.gestureworks.cml.element.Graphic;
	import com.gestureworks.cml.element.Tab;
	import com.gestureworks.cml.element.Text;
	import com.gestureworks.cml.element.TouchContainer;
	import com.gestureworks.cml.events.StateEvent;
	import com.gestureworks.cml.utils.document;
	import com.gestureworks.cml.utils.StateUtils;
	import com.gestureworks.core.TouchSprite;
	import com.gestureworks.events.GWGestureEvent;
	import visualizer.GWVisualizer;
	import visualizer.panels.config.sub.DataPanel;
	import visualizer.panels.config.sub.GMLPanel;
	import visualizer.panels.config.sub.GraphPanel;
	import visualizer.scenes.Interactive3D;
	/**
	 * ...
	 * @author 
	 */
	public class GestureTab extends Tab {
		
		public var touchObject:TouchSprite;
		public var gestureObject:TouchSprite;
		public var interactive3D:Interactive3D;		
		private var gestureFeedbackPanel:Graphic;
		private var gestureEventText:Text; 
		private var gestureGmlText:Text; 
		private var gestureBtns:Array;
		
		public function GestureTab() {
			super();		
		}
	
		// setup
		public function setup():void {
			gestureFeedbackPanel = document.getElementById("gesture-feedback-panel");
			gestureGmlText = document.getElementById("gesture-gml-text");
			gestureEventText = document.getElementById("gesture-event-text"); 
			gestureBtns = document.getElementsByClassName("gesture-btn");
			touchObject = GWVisualizer.touchObject2D;
			gestureObject = GWVisualizer.gestureObject2D;	
			GMLPanel.setup();
		}
		
		// update
		public function show():void {
			if (GWVisualizer.currentView == "2D") {	
				StateUtils.loadState(gestureObject, 0);	
				gestureObject.visible = true;
				gestureObject.visualizer.gestureDisplay = true;							
			}
			else {
				//interactive3D.updateView(GWVisualizer.currentTab, motion);
			}
						
			DataPanel.showGesture();
			GraphPanel.showGesture();				
		}
		
		private function updateGestureData():void {
			GraphPanel.updateGestureTouch();	
		}	
						
	}

}