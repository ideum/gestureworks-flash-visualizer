package 
{
	import com.gestureworks.cml.core.CMLCore;
	import flash.events.Event;
	import com.gestureworks.core.GestureWorks;
	import com.gestureworks.cml.core.CMLParser;
	import com.gestureworks.cml.utils.document;
	import visualizer.GWVisualizer; GWVisualizer;
	import visualizer.panels.ConfigPanel; ConfigPanel;
	import visualizer.panels.FramePanel; FramePanel;
	import visualizer.panels.HeaderPanel; HeaderPanel;
	
	public class Main extends GestureWorks {
		public function Main() {
			super();
			
			fullscreen = true;
			simulator = true;
			leap3D = true;
			
			// register custom packages
			CMLCore.PACKAGES.push("visualizer.");
			CMLCore.PACKAGES.push("visualizer.scenes.");
			CMLCore.PACKAGES.push("visualizer.panels");
			CMLCore.PACKAGES.push("visualizer.panels.config.main");
			CMLCore.PACKAGES.push("visualizer.panels.config.sub");
			
			CMLParser.addEventListener(CMLParser.COMPLETE, cmlInit);

			cml = "library/cml/main.cml";
		}
		
		override protected function gestureworksInit():void {
			trace("gestureWorksInit()");			
		}
		
		private function cmlInit(event:Event):void {
			trace("cmlInit()");
			trace(stage.stageWidth, stage.stageHeight);
			document.getElementById("gw-visualizer").setup(this);
			document.getElementById("gw-visualizer").scale *= stage.stageWidth / 1920; 
		}
	}
}