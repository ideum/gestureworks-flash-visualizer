package visualizer.panels.config.main {
	import com.gestureworks.cml.core.CMLParser;
	import com.gestureworks.cml.element.Tab;
	import com.gestureworks.cml.element.Toggle;
	import com.gestureworks.cml.events.StateEvent;
	import com.gestureworks.cml.utils.document;
	import com.gestureworks.core.GestureWorks;
	import flash.events.Event;
	import visualizer.GWVisualizer;
	
	/**
	 * ...
	 * @author 
	 */
	public class ModeTab extends Tab {
		
		private var gw:GestureWorks;
		private var toggles:Array;
		
		public function ModeTab() {
			super();		
		}
		
		// setup 
		public function setup():void {
			gw = GWVisualizer.gw;
			setupToggles();
		}
		
		public function setupToggles():void {
			toggles = searchChildren(Toggle, Array);
			for each (var item:Toggle in toggles) {
				item.value = gw[item.id];
				item.addEventListener(StateEvent.CHANGE, onToggle);
			}		
		}
		
		// update
		
		public function show():void {
			
		}
		
		private function updateToggle(tId:String, value:Boolean):void {			
			switch (tId) {
			case "simulator":
				gw.simulator = value;
				break;
			case "tuio": 
				gw.tuio = value;
				break;
			case "leap2D": 
				gw.leap2D = value;
				if (gw.leap2D) 
					gw.leap3D = false;
				break;	
			case "native": 
				gw.nativeTouch = value;
				break;		
			case "leap3D": 
				gw.leap3D = value;
				if (gw.leap3D)
					gw.leap2D = false;
				break;	
			}
		}
		
		
		private function onToggle(e:StateEvent):void {
			var tId:String = Toggle(e.target).id;	
			updateToggle(tId, e.value);
		}	
	}
}