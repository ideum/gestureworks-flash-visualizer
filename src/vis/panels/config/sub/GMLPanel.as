package vis.panels.config.sub {
	import com.gestureworks.cml.elements.Button;
	import com.gestureworks.cml.elements.Container;
	import com.gestureworks.cml.elements.Graphic;
	import com.gestureworks.cml.elements.ScrollPane;
	import com.gestureworks.cml.elements.Text;
	import com.gestureworks.cml.events.StateEvent;
	import com.gestureworks.cml.utils.CloneUtils;
	import com.gestureworks.cml.utils.document;
	import com.gestureworks.utils.GMLParser;
	import vis.GWVisualizer;
	import vis.interactives.GestureObject2D;
	/**
	 * ...
	 * @author 
	 */
	public class GMLPanel {
		
		private var gestureFeedbackPanel:Graphic; 
		private var gestureGmlText:Text;
		private var gestureEventText:Text;
		private var gestureView:Container;
		private var gestureGmlScrollpane:ScrollPane;		
		private var gmlData:XML;
		private var currentGML:XML;
		private var gList:Object;
		private var gmlTemplate:XML;
		private var gestureBtns:Array;
		private var gestureObject:GestureObject2D;
		
		public function GMLPanel() {}
		
		public function setup():void {
			// gesture console
			gestureFeedbackPanel = document.getElementById("gesture-feedback-panel");
			gestureGmlText = document.getElementById("gesture-gml-text");
			gestureEventText = document.getElementById("gesture-event-text");
			gestureView = document.getElementById("gesture-view");
			gestureGmlScrollpane = document.getElementById("gesture-gml-scrollpane");			
			gestureBtns = document.getElementsByClassName("gesture-btn");
			gestureObject = GWVisualizer.gestureObject2D;
			
			XML.ignoreWhitespace = true;
			XML.prettyPrinting = true;					
			
			gmlData = XML(GMLParser.settings);	
			gmlTemplate = XML(<GestureMarkupLanguage/>);
			gList = CloneUtils.deepCopyObject(gestureObject.gestureList);
			
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
		
		public function updateGestures():void {			
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
			
			gestureObject.gestureList = newGestures;
			gestureGmlText.cacheAsBitmap = false;				
			gestureGmlText.text = String(currentGML);
			gestureGmlText.cacheAsBitmap = true;			
			gestureGmlScrollpane.updateLayout();
		}
			
		public function onGestureBtns(e:StateEvent):void {
			gList[e.id] = e.value; 
			updateGestures();
		}		
	}

}