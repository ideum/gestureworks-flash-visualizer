package {
	import com.gestureworks.cml.core.CMLCore;
	import com.gestureworks.cml.core.CMLParser;
	import com.gestureworks.cml.utils.document;
	import com.gestureworks.core.GestureWorks;
	import flash.events.Event;
	
	// register custom cml objects
	import vis.GWVisualizer; GWVisualizer;
	import vis.interactives.Interactive2D; Interactive2D;
	import vis.interactives.GestureObject2D; GestureObject2D;
	import vis.panels.ConfigPanel; ConfigPanel;
	import vis.panels.FramePanel; FramePanel;
	import vis.panels.HeaderPanel; HeaderPanel;
	
	public class Main extends GestureWorks {
		public function Main() {
			super();
			
			// default input settings
			fullscreen = true;
			simulator = true;
			leap3D = false;
			
			// register custom cml packages
			CMLCore.PACKAGES.push("vis");
			CMLCore.PACKAGES.push("vis.interactives");
			CMLCore.PACKAGES.push("vis.scenes");
			CMLCore.PACKAGES.push("vis.panels");
			CMLCore.PACKAGES.push("vis.panels.config.main");
			CMLCore.PACKAGES.push("vis.panels.config.sub");
			
			// add cml parser complete event handler
			CMLParser.addEventListener(CMLParser.COMPLETE, cmlInit);
			
			// load cml file
			cml = "library/cml/main.cml";
		}
		
		// cml parser initialized
		private function cmlInit(event:Event):void {
			trace("cmlInit()");
			
			// setup through custom visualizer objects
			document.getElementsByTagName("GWVisualizer")[0].setup(this);		
		}
	}
}