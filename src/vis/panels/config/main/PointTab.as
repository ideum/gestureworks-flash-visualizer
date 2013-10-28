package vis.panels.config.main {
	import com.gestureworks.cml.element.Container;
	import com.gestureworks.cml.element.Graphic;
	import com.gestureworks.cml.element.Tab;
	import com.gestureworks.cml.element.Toggle;
	import com.gestureworks.cml.utils.document;
	import com.gestureworks.core.TouchSprite;
	import vis.GWVisualizer;
	import vis.interactives.Interactive3D;
	import vis.panels.config.sub.DataPanel;
	import vis.panels.config.sub.GraphPanel;
	/**
	 * ...
	 * @author 
	 */
	public class PointTab extends Tab {
		
		private var touchObject:TouchSprite;
		private var gestureObject:TouchSprite
		private var interactive3D:Interactive3D;
		private var gestureFeedbackPanel:Graphic;
		private var viewg:Graphic;
		private var pointContainer:Container;
		private var pointTab:Tab;
		private var data:Graphic;
		private var toggles:Array;
	
		public function PointTab() {
			super();
		}
		
		// setup
		public function setup():void {
			viewg = document.getElementById("viewg"); 
			data = document.getElementById("data");	
			toggles = searchChildren(Toggle);	
			touchObject = GWVisualizer.interactive2D;
			gestureObject = GWVisualizer.gestureObject2D;
			pointContainer = document.getElementById("point-container");
		}
		
		
		// load
		public function load():void {
			
			if (GWVisualizer.currentView == "2D") { 
				gestureObject.visible = false;											
			}					
			else {
				//interactive3D.updateView(tabName, motion);
			}
			
			touchObject.visible = true;	
			touchObject.visualizer.pointDisplay = true;
			touchObject.visualizer.clusterDisplay = false;										
			touchObject.visualizer.gestureDisplay = false;						
			
			addChild(pointContainer);	
			pointContainer.addChild(viewg);
			pointContainer.addChild(data);
			
			DataPanel.loadPoint();
			GraphPanel.loadPoint();			
		}
		
		public function unload():void { }
		
		
		// update
		public function update():void {
			updatePointData();
		}
		
		public function updateToggle(label:String, value:Boolean):void {
			label = label.toLowerCase();				
			switch (label) {
			case "text":
				touchObject.visualizer.point.drawText = value;
				gestureObject.visualizer.point.drawText = value;
				break;
			case "shape":
				touchObject.visualizer.point.drawShape = value;
				gestureObject.visualizer.point.drawShape = value;
				break;
			case "vector":
				touchObject.visualizer.point.drawVector = value;										
				gestureObject.visualizer.point.drawVector = value;										
				break;		
			}
		}
		
		private function updatePointData():void {
			
			switch (GWVisualizer.currentDataTab) {			
				case "touch": 		
					DataPanel.updatePointTouch();
					GraphPanel.updatePointTouch();				
				break;	
				
				case "motion":	
					DataPanel.updatePointMotion();
					GraphPanel.updatePointMotion();
				break;	
			}		
		}
		
		
				
	}

}