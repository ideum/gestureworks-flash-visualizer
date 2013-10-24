package visualizer.panels.config.main {
	import com.gestureworks.cml.element.Container;
	import com.gestureworks.cml.element.Graphic;
	import com.gestureworks.cml.element.Tab;
	import com.gestureworks.cml.element.TouchContainer;
	import com.gestureworks.cml.utils.document;
	import com.gestureworks.cml.utils.StateUtils;
	import visualizer.GWVisualizer;
	import visualizer.panels.config.sub.DataPanel;
	import visualizer.panels.config.sub.GraphPanel;
	import visualizer.scenes.Interactive3D;
	/**
	 * ...
	 * @author 
	 */
	public class PointTab extends Tab {
		
		private var touchObject:TouchContainer;
		private var gestureObject:TouchContainer
		private var interactive3D:Interactive3D;
		private var gestureFeedbackPanel:Graphic;
		private var viewg:Graphic;
		private var pointContainer:Container;
		private var pointTab:Tab;
		private var data:Graphic;
	
		public function PointTab() {
			super();
			viewg = document.getElementById("viewg"); 
			data = document.getElementById("data");			
		}
		
		// setup
		public function setup():void {
			
		}
		
		// update
		public function show():void {
			
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
			
			pointTab.addChild(pointContainer);	
			pointContainer.addChild(viewg);
			pointContainer.addChild(data);

		
			//loadState2(tabName);
			
			DataPanel.showPoint();
			GraphPanel.showPoint();			
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