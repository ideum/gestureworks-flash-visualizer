package visualizer.panels.config.main {
	import com.gestureworks.cml.core.CMLParser;
	import com.gestureworks.cml.element.Tab;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class ModeTab extends Tab {
		
		public function ModeTab() {
			super();
			CMLParser.addEventListener(CMLParser.COMPLETE, cmlInit);
		}
		
		private function cmlInit(event:Event):void {
			CMLParser.removeEventListener(CMLParser.COMPLETE, cmlInit);		
		}	
		
		public function show():void {}
	}

}