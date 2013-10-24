package visualizer.panels.config.main {
	import com.gestureworks.cml.element.Container;
	import com.gestureworks.cml.element.Graphic;
	import com.gestureworks.cml.element.Tab;
	import com.gestureworks.cml.element.TouchContainer;
	import com.gestureworks.cml.utils.document;
	import com.gestureworks.core.TouchSprite;
	import visualizer.GWVisualizer;
	import visualizer.panels.config.sub.DataPanel;
	import visualizer.panels.config.sub.GraphPanel;
	import visualizer.scenes.Interactive3D;
	/**
	 * ...
	 * @author 
	 */
	public class ClusterTab extends Tab { 
		
		public var touchObject:TouchSprite;
		public var gestureObject:TouchSprite;
		public var interactive3D:Interactive3D;
		public var pointContainer:Container;
		private var viewg:Graphic; 
		
		public function ClusterTab() {
			super();
			touchObject = GWVisualizer.touchObject2D;
			gestureObject = GWVisualizer.gestureObject2D;
			
		}
		
		override public function init():void {
			viewg = document.getElementById("viewg"); 
		}
		
		// update
		public function show():void {							
			if (GWVisualizer.currentView == "2D") {					
				touchObject.visualizer.pointDisplay = true;
				touchObject.visualizer.clusterDisplay = true;										
				touchObject.visualizer.gestureDisplay = false;					
				gestureObject.visible = false;
			}
			else {
				//interactive3D.updateView(tabName, motion);
			}	
			
			addChild(pointContainer);					
			pointContainer.addChild(viewg);
			//pointContainer.addChild(data);
			//dataTabContainer.addChild(dataGraph);
			//loadDataColumns(tabName);
			//graphPaths.childList[0].visible = true;				
		}
		
		private function updateClusterData():void {
			switch (GWVisualizer.currentDataTab) {			
			case "touch": 
				DataPanel.updateClusterTouch();
				GraphPanel.updateClusterTouch();
			break;
			
			case "motion":
				DataPanel.updateClusterMotion();
				GraphPanel.updateClusterMotion();
			break;

			case "sub": 	
				DataPanel.updateSubClusterMotion();
				GraphPanel.updateSubClusterMotion();			
			}
		}		
		
	}

}