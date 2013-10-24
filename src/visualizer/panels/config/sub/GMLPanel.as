package visualizer.panels.config.sub {
	import com.gestureworks.cml.events.StateEvent;
	import com.gestureworks.cml.utils.CloneUtils;
	import com.gestureworks.cml.utils.document;
	import visualizer.GWVisualizer;
	/**
	 * ...
	 * @author 
	 */
	public class GMLPanel {
		
		public function GMLPanel() {

			// gesture console
			gestureFeedbackPanel = document.getElementById("gesture-feedback-panel");
			gestureGmlText = document.getElementById("gesture-gml-text");
			gestureEventText = document.getElementById("gesture-event-text");
			gestureView = document.getElementById("gesture-view");
			gestureGmlScrollpane = document.getElementById("gesture-gml-scrollpane");
						
		}
		
		private function setupGesture():void {
			XML.ignoreWhitespace = true;
			XML.prettyPrinting = true;					
			
			gmlData = XML(GMLParser.settings);	
			gmlTemplate = XML(<GestureMarkupLanguage/>);
			gList = CloneUtils.deepCopyObject(GWVisualizer.gestureObject2D.gestureList);
			
			var gId:String;
			var on:Boolean;
			
			for (gId in gList) {
				on = gList[gId];
				if (!on) 
					Button( document.getElementById(gId) ).runToggle();
			}			
			
			updateGestures();
			for each (var btn:Button in gestureBtns)
				btn.addEventListener(StateEvent.CHANGE, onGestureBtns);
		}		
		
	}

}