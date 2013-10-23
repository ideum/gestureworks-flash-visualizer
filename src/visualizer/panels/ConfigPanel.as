package visualizer.panels {
	import com.gestureworks.cml.core.CMLParser;
	import com.gestureworks.cml.element.Tab;
	import com.gestureworks.cml.element.TabbedContainer;
	import com.gestureworks.cml.events.StateEvent;
	import com.gestureworks.cml.utils.document;
	import com.gestureworks.events.GWGestureEvent;
	import flash.events.Event;
	import visualizer.panels.config.main.ClusterTab;
	import visualizer.panels.config.main.GestureTab;
	import visualizer.panels.config.main.ModeTab;
	import visualizer.panels.config.main.PointTab;
	import visualizer.scenes.Interactive3D;
	
	public class ConfigPanel extends TabbedContainer {
				
		private var modeTab:ModeTab;
		private var pointTab:PointTab;		
		private var clusterTab:ClusterTab;
		private var gestureTab:GestureTab;
		
		private var currentTab:String;		
		private var defaultTabIndex:int = 0;
		
		private var interactive3D:Interactive3D;
				
		public function ConfigPanel () {		
			super();
		}
		
		override public function init():void {
			super.init();
			
			// toggle
			toggle = document.getElementsByTagName("Toggle");
			viewg = document.getElementById("viewg");

			panelText = document.getElementsByClassName("panel-text");
			viewBtns = document.getElementById("view-btns");
			dataNumCols = document.getElementsByClassName("data-num-c");
			gestureBtns = document.getElementsByClassName("gesture-btn");
			gestureFeedbackMenu = document.getElementById("gesture-feedback-menu");				
			
			interactive3D = document.getElementsByClassName("Interactive3D")[0];
			
			// default tab
			selectTabByIndex(defaultTabIndex);
			addEventListener(StateEvent.CHANGE, onTabSelection);			
		}
	
		private function onTabSelection(e:StateEvent):void {	
			if (e.target != this) return;
			
			switch (e.value) {
				case 0: 
					if (currentTab != "mode") 
						showTab("mode"); break;
				case 1: 
					if (currentTab != "point") 
						showTab("point"); break; 
				case 2: 
					if (currentTab != "cluster") 
						showTab("cluster"); break;	
				case 3: 
					if (currentTab != "gesture") 
						showTab("gesture"); break;					
			}
		}		
		
		// setup
		private function setupListeners():void {
			dataTabs.addEventListener(StateEvent.CHANGE, onDataTabContainer);	
			viewBtns.addEventListener(StateEvent.CHANGE, onViewBtns);	
			
			for each (var t:Toggle in toggle)
				t.addEventListener(StateEvent.CHANGE, onToggle);
		}		
		
		private function setupToggles():void {
			for each (var item:Toggle in toggle)
				item.value = true;
		}
		
		private function setup3DScene():void {
			remove2DScene();
			display3DIndex = getChildIndex(display3D);			
			remove3DScene();
			add2DScene();
			gestureObject3D = display3D.gestureObject;
		}
		
		private function showTab(tabName:String):void {
			var i:int;
			var j:int;
			
			for each (var item:Toggle in toggle) 
				StateUtils.saveStateById(item, item.stateId);
			
			switch (tabName) {			
				case "mode": 
					break;
				case "point":
					break;				
				case "cluster":
					break;		
				case "gesture":
					break;					
			}
			
			currentTab = tabName;		
			StateManager.loadState(currentTab + "-" + currentDataTab);
		}	

		// update
		public function update():void {}
		
		private function loadState2(state:String):void {
			var txt:Text;
			var tog:Toggle;
			for each (txt in panelText)
				StateUtils.loadStateById(txt, state);
			for each(tog in toggle)
				StateUtils.loadStateById(tog, state);
			
			StateUtils.loadStateById(viewg, state);
		}
					
		private function add3DScene():void {
			display3D.addView(currentTab, motion);
			addChildAt(display3D, display3DIndex);
			showTab(currentTab);
		}		
		
		private function remove3DScene():void {
			display3D.removeView();
			removeChild(display3D);
		}
		
		private function add2DScene():void {
			addChildAt(touchObject, touchObjectIndex);						
			addChildAt(gestureObject, gestureObjectIndex);
			showTab(currentTab);
		}
		
		private function remove2DScene():void {
			removeChild(touchObject);
			removeChild(gestureObject);
		}			
		
	}
}