package vis.panels.config.main {
	import com.gestureworks.cml.core.CMLParser;
	import com.gestureworks.cml.element.Tab;
	import com.gestureworks.cml.element.Toggle;
	import com.gestureworks.cml.events.StateEvent;
	import com.gestureworks.cml.utils.document;
	import com.gestureworks.core.GestureWorks;
	import flash.events.Event;
	import vis.GWVisualizer;
	
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
			}				
		}
		
		
		// load
		public function load():void {}
		public function unload():void {}		
		
		
		// update		
		public function update():void {}
		
		public function updateToggle(label:String, value:Boolean):void {
			label = label.toLowerCase();
			switch (label) {
			case "leap 2d": 
				gw.leap2D = value;
				
				trace( gw.leap2D );
				//if (gw.leap2D) 
					//gw.leap3D = false;
				break;		
			case "leap 3d": 
				//gw.leap3D = value;
				//if (gw.leap3D)
					//gw.leap2D = false;
				break;	
			default :
				gw[label] = value;
			}
		}
	}
}