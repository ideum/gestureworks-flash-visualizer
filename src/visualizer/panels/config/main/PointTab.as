package visualizer.panels.config.main {
	import com.gestureworks.cml.element.Container;
	import com.gestureworks.cml.element.Graphic;
	import com.gestureworks.cml.element.Tab;
	import com.gestureworks.cml.element.Text;
	import com.gestureworks.cml.element.Toggle;
	import com.gestureworks.cml.element.TouchContainer;
	import com.gestureworks.cml.utils.document;
	import com.gestureworks.cml.utils.StateUtils;
	import com.gestureworks.core.TouchSprite;
	import visualizer.GWVisualizer;
	import visualizer.panels.config.sub.DataPanel;
	import visualizer.panels.config.sub.GraphPanel;
	import visualizer.scenes.Interactive3D;
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
			touchObject = GWVisualizer.touchObject2D;
			gestureObject = GWVisualizer.gestureObject2D;
			pointContainer = document.getElementById("point-container");
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
			
			addChild(pointContainer);	
			pointContainer.addChild(viewg);
			pointContainer.addChild(data);

			loadTabState(this.id);
			
			DataPanel.showPoint();
			GraphPanel.showPoint();			
		}
		
		private function loadTabState(state:String):void 
		{
			var txt:Text;
			var tog:Toggle;
			//for each (txt in panelText)
			//	StateUtils.loadStateById(txt, state);
			for each(tog in toggles)
				StateUtils.loadStateById(tog, state);
			
			StateUtils.loadStateById(viewg, state);
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