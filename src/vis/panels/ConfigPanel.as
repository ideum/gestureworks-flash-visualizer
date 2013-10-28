package vis.panels {
	import com.gestureworks.cml.element.Button;
	import com.gestureworks.cml.element.Graphic;
	import com.gestureworks.cml.element.TabbedContainer;
	import com.gestureworks.cml.element.Text;
	import com.gestureworks.cml.element.Toggle;
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
		
		public var touchObject:TouchSprite;
		public var gestureObject:TouchSprite;		
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
			touchObject = GWVisualizer.interactive2D;
			gestureObject = GWVisualizer.gestureObject2D;
			gestureObject3D = GWVisualizer.gestureObject3D;
			
			viewg = document.getElementById("viewg");

			viewBtns = document.getElementsByClassName("view-btns");
			panelText = document.getElementsByClassName("panel-text");			
			toggle = document.getElementsByTagName("Toggle");
			
			interactive3D = _interactive3D;
			
			
			dataPanel = new DataPanel;
			dataPanel.setup();
			
			graphPanel = new GraphPanel;
			graphPanel.setup();
			
			setupTabs();
			
			setupListeners();
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
			
			touchObject.visible = true;
			gestureObject.visible = true;			
			interactive3D.view3D.visible = true;
						
			// listen for tab change
			addEventListener(StateEvent.CHANGE, onTabSelection);			
		}
		
		private function setupListeners():void {
			
			for each (var item:Button in viewBtns) {
				item.addEventListener(StateEvent.CHANGE, onViewBtns);
			}
			
			for each (var t:Toggle in toggle)
				t.addEventListener(StateEvent.CHANGE, onToggle);
		}		
		
		private function setupToggles():void {
			for each (var item:Toggle in toggle)
				item.value = true;
		}
		
		
		// load
		
		private function loadTab(tabSelection:String):void {
			
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
			currentTabObj.load();
			
			
			if (tabSelection == "gesture") {
				touchObject.visible = false;
			}
			
			currentTab = tabSelection;
		}	
		
		
		// update
		public function update():void {
			currentTabObj.update();		
		}
					
		
		// 2d
		private function load2DScene():void {
			touchObject.visible = true;
			if (currentTab == "gesture")
				gestureObject.visible = true;	
		}
		
		private function unload2DScene():void {
			touchObject.visible = false;
			gestureObject.visible = false;
		}			
		
		
		// 3d
		private function load3DScene():void {
			if (currentTab == "gesture")			
				interactive3D.view3D.visible = true;
		}		
		
		private function unload3DScene():void {
			interactive3D.view3D.visible = false;
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
		}	
		
		private function onViewBtns(e:StateEvent):void {
			
			if (e.id == "view-btn-2d") {
				if (e.value) {
					if (!GWVisualizer.active2D) {
						load2DScene();
					}
				}
				else  {
					unload2DScene();
				}
				GWVisualizer.active2D = e.value;
			}
			else if ("view-btn-3d") {
				if (e.value) {
					if (!GWVisualizer.active3D) {
						load3DScene();
					}
				}
				else {
					unload3DScene();
				}
				GWVisualizer.active3D = e.value;
			}
			
		}			
		
		private function onToggle(e:StateEvent):void {
			var t:Toggle = Toggle(e.target);
			var label:String = Text(Toggle(e.target).childList.getClass(Text, 0)).text;							
			currentTabObj.updateToggle(label, e.value);				
		}		
	}
}