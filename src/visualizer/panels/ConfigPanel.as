package visualizer.panels {
	import com.gestureworks.cml.element.Graphic;
	import com.gestureworks.cml.element.RadioButtons;
	import com.gestureworks.cml.element.TabbedContainer;
	import com.gestureworks.cml.element.Text;
	import com.gestureworks.cml.element.Toggle;
	import com.gestureworks.cml.events.StateEvent;
	import com.gestureworks.cml.managers.StateManager;
	import com.gestureworks.cml.utils.document;
	import com.gestureworks.cml.utils.StateUtils;
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
		
		private var toggle:Array;
		private var viewg:Graphic;
		private var panelText:Array;
		private var viewBtns:RadioButtons;
				
		public function ConfigPanel () {		
			super();
		}
		
		override public function init():void {
			super.init();
			
			viewg = document.getElementById("viewg");

			viewBtns = document.getElementById("view-btns");
			panelText = document.getElementsByClassName("panel-text");			
			toggle = document.getElementsByTagName("Toggle");
			
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
			interactive3D = getChildIndex(interactive3D);			
			remove3DScene();
			add2DScene();
			gestureObject2D = interactive3D.gestureObject2D;
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
			var tog:Toggle
			for each (txt in panelText)
				StateUtils.loadStateById(txt, state);
			for each(tog in toggle)
				StateUtils.loadStateById(tog, state);
			
			StateUtils.loadStateById(viewg, state);
		}
					
		private function add3DScene():void {
			interactive3D.addView(currentTab, motion);
			addChildAt(interactive3D, interactive3DIndex);
			showTab(currentTab);
		}		
		
		private function remove3DScene():void {
			interactive3D.removeView();
			removeChild(interactive3D);
		}
		
		private function add2DScene():void {
			addChildAt(touchObject2D, touchObjectIndex);						
			addChildAt(gestureObject2D, gestureObjectIndex);
			showTab(currentTab);
		}
		
		private function remove2DScene():void {
			removeChild(touchObject2D);
			removeChild(gestureObject2D);
		}			
		
	}
}