package vis.panels.config.main {
	import com.gestureworks.cml.elements.Button;
	import com.gestureworks.cml.elements.Graphic;
	import com.gestureworks.cml.elements.RadioButtons;
	import com.gestureworks.cml.elements.Tab;
	import com.gestureworks.cml.elements.Text;
	import com.gestureworks.cml.events.StateEvent;
	import com.gestureworks.cml.managers.StateManager;
	import com.gestureworks.cml.utils.document;
	import com.gestureworks.cml.utils.StateUtils;
	import vis.GWVisualizer;
	import vis.interactives.GestureObject2D;
	import vis.interactives.Interactive2D;
	import vis.interactives.Interactive3D;
	import vis.panels.config.sub.ConsolePanel;
	import vis.panels.config.sub.DataPanel;
	import vis.panels.config.sub.GMLPanel;
	import vis.panels.config.sub.GraphPanel;
	/**
	 * ...
	 * @author 
	 */
	public class GestureTab extends Tab {
		
		public var touchObject:Interactive2D;
		public var gestureObject:GestureObject2D;
		public var interactive3D:Interactive3D;		
		private var gestureFeedbackPanel:Graphic;
		private var gestureEventText:Text; 
		private var gestureTextArray:Array; 
		private var gestureDataArray:Array = []; 		
		private var gestureGmlText:Text; 
		private var gestureBtns:Array;
		private var consolePanel:ConsolePanel;
		private var gmlPanel:GMLPanel;
		private var dataPanel:DataPanel;
		private var graphPanel:GraphPanel;
		private var gestureTypeButtons:RadioButtons;
		
		public function GestureTab() {
			super();		
		}
	
		
		// setup
		public function setup(_dataPanel:DataPanel, _graphPanel:GraphPanel):void {
			dataPanel = _dataPanel;
			graphPanel = _graphPanel;
			gestureFeedbackPanel = document.getElementById("gesture-feedback-panel");
			gestureGmlText = document.getElementById("gesture-gml-text");
			gestureEventText = document.getElementById("gesture-event-text"); 
			gestureBtns = document.getElementsByClassName("gesture-btn");
			touchObject = GWVisualizer.interactive2D;
			gestureObject = GWVisualizer.gestureObject2D;	
			gestureTextArray = gestureObject.gestureTextArray;
			gestureDataArray = gestureObject.gestureDataArray;
			
			consolePanel = new ConsolePanel;
			consolePanel.setup(gestureEventText, gestureTextArray);
			
			gmlPanel = new GMLPanel;
			gmlPanel.setup();
			
			graphPanel.gestureDataArray = gestureDataArray;
			
			gestureTypeButtons = document.getElementById("gesture-type-buttons");
			gestureTypeButtons.addEventListener(StateEvent.CHANGE, onGestureType);	
			
		}
		
		
		private function onGestureType(e:StateEvent):void {
			trace(StateManager.loadState(e.target.id));
		}
		
		// load
		public function load():void {
			StateUtils.loadState(gestureObject, 0);	
			gestureObject.visualizer.gestureDisplay = true;							
						
			dataPanel.loadGesture();
			graphPanel.loadGesture();
			
			gestureObject.load();
		}		
		
		public function unload():void {
			gestureObject.unload();
		}		
		
		
		// update
		public function update():void {
			graphPanel.updateGestureTouch();	
			consolePanel.update();
		}	
		
		public function updateToggle(label:String, value:Boolean):void {
			label = label.toLowerCase();				
			switch (label) {
			// gesture
			case "cluster":
				gestureObject.visualizer.clusterDisplay = value;
				break;				
			case "orientation":
				gestureObject.visualizer.gesture.drawOrientation = value;
				break;				
			case "transformation":
				gestureObject.visualizer.gesture.drawTransformation = value;
				break;				
			case "pivot":
				gestureObject.visualizer.gesture.drawPivot = value;
				break;	
			case "stroke":
				gestureObject.visualizer.gesture.drawStroke = value;
				break;	
			case "gesture":
				gestureObject.visualizer.gesture.drawGesture = value;
				break;
			}
		}		
						
	}

}