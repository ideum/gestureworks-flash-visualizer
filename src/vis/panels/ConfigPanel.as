package vis.panels {
	import com.gestureworks.cml.elements.Button;
	import com.gestureworks.cml.elements.Graphic;
	import com.gestureworks.cml.elements.TabbedContainer;
	import com.gestureworks.cml.elements.Text;
	import com.gestureworks.cml.elements.Toggle;
	import com.gestureworks.cml.events.StateEvent;
	import com.gestureworks.cml.managers.StateManager;
	import com.gestureworks.cml.utils.document;
	import com.gestureworks.core.TouchSprite;
	import vis.GWVisualizer;
	import vis.interactives.Interactive3D;
	import vis.panels.config.main.ClusterTab;
	import vis.panels.config.main.GestureTab;
	import vis.panels.config.main.ModeTab;
	import vis.panels.config.main.PointTab;
	import vis.panels.config.sub.DataPanel;
	import vis.panels.config.sub.GraphPanel;
	
	public class ConfigPanel extends TabbedContainer {
				
		private var modeTab:ModeTab;
		private var pointTab:PointTab;		
		private var clusterTab:ClusterTab;
		private var gestureTab:GestureTab;
		
		public var interactive2D:TouchSprite;
		public var gestureObject2D:TouchSprite;		
		public var interactive3D:Interactive3D;		
		public var gestureObject3D:TouchSprite;		
		
		private var currentTab:String;		
		private var currentTabObj:*;		
		private var defaultTabIndex:int = 0;
		
		private var toggle:Array;
		private var viewg:Graphic;
		private var panelText:Array;
		private var viewBtns:Array;
		
		private var dataPanel:DataPanel;
		private var graphPanel:GraphPanel;
		
		private var interactive3DIndex:int = 0;
				
		public function ConfigPanel () {		
			super();
		}
		
		public function setup(_interactive3D:Interactive3D):void {
			interactive2D = GWVisualizer.interactive2D;
			gestureObject2D = GWVisualizer.gestureObject2D;
			gestureObject3D = GWVisualizer.gestureObject3D;
			
			viewg = document.getElementById("viewg");

			viewBtns = document.getElementsByClassName("view-btns");
			panelText = document.getElementsByClassName("panel-text");			
			toggle = document.getElementsByTagName(Toggle);
			
			interactive3D = _interactive3D;
			
			dataPanel = new DataPanel;
			dataPanel.setup();
			
			graphPanel = new GraphPanel;
			graphPanel.setup();
			
			setupTabs();
			
			setupListeners();
			
			loadScene();
		}
	
		// setup
		private function setupTabs():void {
			modeTab = getElementById("mode");
			modeTab.setup();
			
			pointTab = getElementById("point");
			pointTab.setup(dataPanel, graphPanel);
			
			clusterTab = getElementById("cluster");
			clusterTab.setup(dataPanel, graphPanel);
			
			gestureTab = getElementById("gesture");
			gestureTab.setup(dataPanel, graphPanel);
			
			// default tab
			selectTabByIndex(defaultTabIndex);
			currentTabObj = modeTab;
			loadTab("mode");
						
			// listen for tab change
			addEventListener(StateEvent.CHANGE, onTabSelection);			
		}
		
		private function setupListeners():void {
			
			for each (var item:Button in viewBtns) {
				item.addEventListener(StateEvent.CHANGE, onViewBtns);
			}
			
			for each (var t:Toggle in toggle) {
				t.addEventListener(StateEvent.CHANGE, onToggle);
			}
		}		
		
		
		// load
		
		public function loadTab(tabSelection:String):void {
			
			if (tabSelection == currentTab) {
				return;
			}
			
			// save old state
			StateManager.saveState(currentTab);
			
			// load new one
			StateManager.loadState(tabSelection);
			StateManager.loadState(tabSelection + "-" + GWVisualizer.currentDataTab);			
		
			currentTabObj.unload();
			currentTabObj = getElementById(tabSelection);
			
			currentTab = tabSelection; 
			currentTabObj.load();
		}	
		
		
		// update
		public function update():void {
			currentTabObj.update();		
		}
					
		
		private function loadScene():void {
			
			switch (currentTab) {
				case "mode" :					
				break;
			case "point" :
				pointCluster();			
				break;
			case "cluster" :
				pointCluster();	
				break;
			case "gesture" :
				interactive2D.visible = false;
				gestureObject2D.visible = GWVisualizer.active2D;
				interactive3D.visible = GWVisualizer.active3D;
				gestureObject3D.vto.visible = GWVisualizer.active3D;										
				break;				
			}	
			
			function pointCluster():void {				
				interactive2D.visible = GWVisualizer.active2D;
				gestureObject2D.visible = false;
				interactive3D.visible = GWVisualizer.active3D;
				gestureObject3D.vto.visible = false;						
			}
		}

		

		// events
		private function onTabSelection(e:StateEvent):void {	
			if (e.target != this) {
				return;
			}
			switch (e.value) {
				case 0: 
					loadTab("mode"); 
					break;
				case 1: 
					loadTab("point"); 
					break; 
				case 2: 
					loadTab("cluster"); 
					break;	
				case 3: 
					loadTab("gesture"); 
					break;					
			}
			loadScene();			
		}	
		
		private function onViewBtns(e:StateEvent):void {
			if (e.id == "view-btn-2d") {
				GWVisualizer.active2D = e.value;
				loadScene();				
			}
			else if (e.id == "view-btn-3d") {
				GWVisualizer.active3D = e.value;
				loadScene();								
			}			
		}			
		
		private function onToggle(e:StateEvent):void {
			var t:Toggle = Toggle(e.target);
			var label:String = Text(Toggle(e.target).childList.getClass(Text, 0)).text;							
			currentTabObj.updateToggle(label, e.value);				
		}		
	}
}