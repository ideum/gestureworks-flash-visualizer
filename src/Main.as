package 
{
	import com.gestureworks.cml.components.*;
	import com.gestureworks.cml.core.*;
	import com.gestureworks.cml.element.*;
	import com.gestureworks.cml.events.*;
	import com.gestureworks.cml.managers.*;
	import com.gestureworks.cml.utils.*;
	import com.gestureworks.core.*;
	import com.gestureworks.events.*;
	import flash.events.*;
	import flash.utils.*;
	import GestureWorksVisualizer; GestureWorksVisualizer;
	
	public class Main extends GestureWorks
	{
		public function Main() 
		{
			super();
			fullscreen = true;
			simulator = true;
			//leap3D = true;
			cml = "library/cml/index.cml";
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