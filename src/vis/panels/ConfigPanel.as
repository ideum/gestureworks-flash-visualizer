package vis.panels {
	import com.gestureworks.cml.element.Graphic;
	import com.gestureworks.cml.element.RadioButtons;
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
		
		private var currentTab:String;		
		private var currentTabObj:*;		
		private var defaultTabIndex:int = 0;
		public var touchObject:TouchSprite;
		public var gestureObject:TouchSprite;		
		private var interactive3D:Interactive3D;
		
		private var toggle:Array;
		private var viewg:Graphic;
		private var panelText:Array;
		private var viewBtns:RadioButtons;
				
		public function ConfigPanel () {		
			super();
		}
		
		public function setup():void {
			touchObject = GWVisualizer.interactive2D;
			gestureObject = GWVisualizer.gestureObject2D;
			
			viewg = document.getElementById("viewg");

			viewBtns = document.getElementById("view-btns");
			panelText = document.getElementsByClassName("panel-text");			
			toggle = document.getElementsByTagName("Toggle");
			
			interactive3D = document.getElementsByClassName("Interactive3D")[0];
			
			setupTabs();
			DataPanel.setup();
			GraphPanel.setup();
			
			setupListeners();
		}
	
		// setup
		private function setupTabs():void {
			modeTab = getElementById("mode");
			modeTab.setup();
			
			pointTab = getElementById("point");
			pointTab.setup();
			
			clusterTab = getElementById("cluster");
			clusterTab.setup();
			
			gestureTab = getElementById("gesture");
			gestureTab.setup();
			
			// default tab
			selectTabByIndex(defaultTabIndex);
			currentTabObj = modeTab;
			showTab("mode");
			
			// listen for tab change
			addEventListener(StateEvent.CHANGE, onTabSelection);			
		}
		
		private function setupListeners():void {
			viewBtns.addEventListener(StateEvent.CHANGE, onViewBtns);	
			
			for each (var t:Toggle in toggle)
				t.addEventListener(StateEvent.CHANGE, onToggle);
		}		
		
		private function setupToggles():void {
			for each (var item:Toggle in toggle)
				item.value = true;
		}
		
		private function setup3DScene():void {
			//remove2DScene();
			//interactive3D = getChildIndex(interactive3D);			
			//remove3DScene();
			//add2DScene();
			//gestureObject2D = interactive3D.gestureObject2D;
		}
		
		private function showTab(tabSelection:String):void {
			
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
			
			currentTab = tabSelection;
		}	
		
		
		// update
		public function update():void {
			currentTabObj.update();		
		}
					
		private function add3DScene():void {
			//interactive3D.addView(currentTab, motion);
			//addChildAt(interactive3D, interactive3DIndex);
			//showTab(currentTab);
		}		
		
		private function remove3DScene():void {
			//interactive3D.removeView();
			//removeChild(interactive3D);
		}
		
		private function add2DScene():void {
			//addChildAt(touchObject2D, touchObjectIndex);						
			//addChildAt(gestureObject2D, gestureObjectIndex);
			//showTab(currentTab);
		}
		
		private function remove2DScene():void {
			//removeChild(touchObject2D);
			//removeChild(gestureObject2D);
		}	
		
		
		
		// events
		private function onTabSelection(e:StateEvent):void {	
			if (e.target != this) {
				return;
			}
			
			switch (e.value) {
				case 0: 
					showTab("mode"); 
					break;
				case 1: 
					showTab("point"); 
					break; 
				case 2: 
					showTab("cluster"); 
					break;	
				case 3: 
					showTab("gesture"); 
					break;					
			}
		}	
		
		private function onViewBtns(e:StateEvent):void {
			if (GWVisualizer.currentView == e.value) {
				return;
			}
			
			GWVisualizer.currentView = e.value;
			
			switch (e.value) {
				case "2D": 
					//remove3DScene();										
					//add2DScene();
					break;
				case "3D": 
					//remove2DScene();										
					//add3DScene();
					break;					
			}
		}			
		
		private function onToggle(e:StateEvent):void {
			var t:Toggle = Toggle(e.target);
			var label:String = Text(Toggle(e.target).childList.getClass(Text, 0)).text;							
			currentTabObj.updateToggle(label, e.value);				
		}		
	}
}