package vis.panels.config.main {
	import com.gestureworks.cml.element.Container;
	import com.gestureworks.cml.element.Graphic;
	import com.gestureworks.cml.element.Tab;
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
	public class ClusterTab extends Tab { 
		
		public var touchObject:TouchSprite;
		public var gestureObject:TouchSprite;
		public var interactive3D:Interactive3D;
		public var pointContainer:Container;
		private var viewg:Graphic; 
		
		public function ClusterTab() {
			super();
		}
		
		// setup
		public function setup():void {
			viewg = document.getElementById("viewg"); 			
			touchObject = GWVisualizer.interactive2D;
			gestureObject = GWVisualizer.gestureObject2D;
			pointContainer = document.getElementById("point-container");
		}
		
		
		// load
		public function load():void {							
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
			pointContainer.addChild(DataPanel.data);
			
			DataPanel.loadCluster();
			GraphPanel.loadCluster();		
		}
		
		public function unload() {}
		
		
		// update	
		public function update():void {
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
		
		public function updateToggle(label:String, value:Boolean):void {
			label = label.toLowerCase();				
			switch (label) {
			case "point":
				touchObject.visualizer.pointDisplay = value;
				gestureObject.visualizer.pointDisplay = value;
				break;
			case "web":
				touchObject.visualizer.cluster.drawWeb = value;
				gestureObject.visualizer.cluster.drawWeb = value;
				break;
			case "box":
				touchObject.visualizer.cluster.drawBox = value;
				gestureObject.visualizer.cluster.drawBox = value;
				break;
			case "rotation":
				if (GWVisualizer.currentTab == "cluster") {
					touchObject.visualizer.cluster.drawRotation = value;
					gestureObject.visualizer.cluster.drawRotation = value;
				}
				else if (GWVisualizer.currentTab == "gesture")
					gestureObject.visualizer.gesture.drawRotation = value;
				break;
			case "radius":
				touchObject.visualizer.cluster.drawRadius = value;
				gestureObject.visualizer.cluster.drawRadius = value;
				break;
			case "center":
				touchObject.visualizer.cluster.drawCenter = value;
				gestureObject.visualizer.cluster.drawCenter = value;
				break;
			case "bisector":
				touchObject.visualizer.cluster.drawBisector = value;
				gestureObject.visualizer.cluster.drawBisector = value;
				break;		
			}
		}		
		
	}

}