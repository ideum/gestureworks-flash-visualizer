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
	import com.gestureworks.core.TouchSprite;
	import visualizer.GWVisualizer;
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
			touchObject = GWVisualizer.touchObject2D;
			gestureObject = GWVisualizer.gestureObject2D;
			
			viewg = document.getElementById("viewg");

			viewBtns = document.getElementById("view-btns");
			panelText = document.getElementsByClassName("panel-text");			
			toggle = document.getElementsByTagName("Toggle");
			
			interactive3D = document.getElementsByClassName("Interactive3D")[0];
			
			setupTabs();
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
		
		private function showTab(tabName:String):void {
			for each (var item:Toggle in toggle) 
				StateUtils.saveStateById(item, item.stateId); 
			
			switch (tabName) {			
				case "mode": 
					break;
				case "point":
					pointTab.show();
					break;				
				case "cluster":
					clusterTab.show();
					break;		
				case "gesture":
					gestureTab.show();
					break;					
			}
			
			currentTab = tabName;		
			StateManager.loadState(GWVisualizer.currentTab + "-" + GWVisualizer.currentDataTab);
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
		
		private function onViewBtns(e:StateEvent):void
		{
			if (GWVisualizer.currentView == e.value) 
				return;
			
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
		
		private function onToggle(e:StateEvent):void
		{
			var t:Toggle = Toggle(e.target);
						
			var label:String = Text(Toggle(e.target).childList.getClass(Text, 0)).text;			
			label = label.toLowerCase();
						
			switch (label) {
				
				// mode
				case "simulator":
					GWVisualizer.gw.simulator = e.value;
					break;
				case "tuio": 
					GWVisualizer.gw.tuio = e.value;
					break;
				case "leap 2d": 
					GWVisualizer.gw.leap2D = e.value;
					if (GWVisualizer.gw.leap2D) GWVisualizer.gw.leap3D = false;
					break;	
				case "native": 
					GWVisualizer.gw.nativeTouch = e.value;
					break;		
				case "leap 3d": 
					GWVisualizer.gw.leap3D = e.value;
					if (GWVisualizer.gw.leap3D)
						GWVisualizer.gw.leap2D = false;
					break;
				
					
				// point
				case "text":
					touchObject.visualizer.point.drawText = e.value;
					gestureObject.visualizer.point.drawText = e.value;
					break;
				case "shape":
					touchObject.visualizer.point.drawShape = e.value;
					gestureObject.visualizer.point.drawShape = e.value;
					break;
				case "vector":
					touchObject.visualizer.point.drawVector = e.value;										
					gestureObject.visualizer.point.drawVector = e.value;										
					break;
				
					
				// cluster
				case "point":
					touchObject.visualizer.pointDisplay = e.value;
					gestureObject.visualizer.pointDisplay = e.value;
					break;
				case "web":
					touchObject.visualizer.cluster.drawWeb = e.value;
					gestureObject.visualizer.cluster.drawWeb = e.value;
					break;
				case "box":
					touchObject.visualizer.cluster.drawBox = e.value;
					gestureObject.visualizer.cluster.drawBox = e.value;
					break;
				case "rotation":
					if (currentTab == "cluster") {
						touchObject.visualizer.cluster.drawRotation = e.value;
						gestureObject.visualizer.cluster.drawRotation = e.value;
					}
					else if (currentTab == "gesture")
						gestureObject.visualizer.gesture.drawRotation = e.value;
					break;
				case "radius":
					touchObject.visualizer.cluster.drawRadius = e.value;
					gestureObject.visualizer.cluster.drawRadius = e.value;
					break;
				case "center":
					touchObject.visualizer.cluster.drawCenter = e.value;
					gestureObject.visualizer.cluster.drawCenter = e.value;
					break;
				case "bisector":
					touchObject.visualizer.cluster.drawBisector = e.value;
					gestureObject.visualizer.cluster.drawBisector = e.value;
					break;	
					
					
				// gesture
				case "cluster":
					gestureObject.visualizer.clusterDisplay = e.value;
					break;				
				case "orientation":
					gestureObject.visualizer.gesture.drawOrientation = e.value;
					break;				
				case "transformation":
					gestureObject.visualizer.gesture.drawTransformation = e.value;
					break;				
				case "pivot":
					gestureObject.visualizer.gesture.drawPivot = e.value;
					break;	
				case "stroke":
					gestureObject.visualizer.gesture.drawStroke = e.value;
					break;	
				case "gesture":
					gestureObject.visualizer.gesture.drawGesture = e.value;
					break;						
			}					
		}		
	}
}