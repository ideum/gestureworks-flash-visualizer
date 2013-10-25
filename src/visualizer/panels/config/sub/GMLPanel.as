package visualizer.panels.config.sub {
	import com.gestureworks.cml.element.Button;
	import com.gestureworks.cml.element.Container;
	import com.gestureworks.cml.element.Graphic;
	import com.gestureworks.cml.element.ScrollPane;
	import com.gestureworks.cml.element.Text;
	import com.gestureworks.cml.events.StateEvent;
	import com.gestureworks.cml.utils.CloneUtils;
	import com.gestureworks.cml.utils.document;
	import com.gestureworks.utils.GMLParser;
	import visualizer.GWVisualizer;
	/**
	 * ...
	 * @author 
	 */
	public class GMLPanel {
		
		private static var gestureFeedbackPanel:Graphic; 
		private static var gestureGmlText:Text;
		private static var gestureEventText:Text;
		private static var gestureView:Container;
		private static var gestureGmlScrollpane:ScrollPane;		
		private static var gmlData:XML;
		private static var currentGML:XML;
		private static var gList:Object;
		private static var gmlTemplate:XML;
		private static var gestureBtns:Array;
		
		public function GMLPanel() {}
		
		public static function setup():void {
			// gesture console
			gestureFeedbackPanel = document.getElementById("gesture-feedback-panel");
			gestureGmlText = document.getElementById("gesture-gml-text");
			gestureEventText = document.getElementById("gesture-event-text");
			gestureView = document.getElementById("gesture-view");
			gestureGmlScrollpane = document.getElementById("gesture-gml-scrollpane");			
			
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
		
		public static function updateGestures():void {			
			var on:Boolean;
			var gId:String;			
			var newGestures:Object = { };
			currentGML = gmlTemplate.copy();
			
			for (gId in gList) {
				on = gList[gId];
				if (on) {
					for each (var node:XML in gmlData.Gesture_set.*) {
						if (node.@id == gId) {
							currentGML.appendChild(node);
							newGestures[gId] = on;
						}
					}	
				}
			}
			
			GWVisualizer.gestureObject2D.gestureList = newGestures;
			gestureGmlText.cacheAsBitmap = false;				
			gestureGmlText.text = String(currentGML);
			gestureGmlText.cacheAsBitmap = true;			
			gestureGmlScrollpane.updateLayout();
		}
			
		public static function onGestureBtns(e:StateEvent):void {
			gList[e.id] = e.value; 
			updateGestures();
		}		
	}

}