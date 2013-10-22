package 
{
	import flash.events.Event;
	import com.gestureworks.core.GestureWorks;
	import com.gestureworks.cml.core.CMLParser;
	import com.gestureworks.cml.utils.document;
	import GestureWorksVisualizer; GestureWorksVisualizer;
	
	public class Main extends GestureWorks
	{
		public function Main() 
		{
			super();
			fullscreen = true;
			simulator = true;
			leap3D = true;
			cml = "library/cml/main.cml";
			CMLParser.addEventListener(CMLParser.COMPLETE, cmlInit);
		}
		
		override protected function gestureworksInit():void
 		{
			trace("gestureWorksInit()");			
		}
		
		private function cmlInit(event:Event):void
		{
			trace("cmlInit()");
			trace(stage.stageWidth, stage.stageHeight);
			document.getElementById("gw-visualizer").setup(this);
			document.getElementById("gw-visualizer").scale *= stage.stageWidth / 1920; 
		}
	}
}