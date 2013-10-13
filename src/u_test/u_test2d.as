package u_test
{
	import com.gestureworks.core.*;
	import com.gestureworks.events.*;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.ui.*;
	
	[SWF(width = "1920", height = "1080", backgroundColor = "0x000000", frameRate = "30")]
		
	public class u_test2d extends GestureWorks 
	{	
		private var ts:TouchSprite;
				
		public function u_test2d():void 
		{
			super();
			fullscreen = true;
			gml = "library/gml/gestures.gml";
		}
			
		override protected function gestureworksInit():void 
		{
			initialize();
		}
		
		private function initialize():void 
		{
			ts = new TouchSprite;
			ts.gestureList = { "n-drag":true, "n-rotate":true, "n-scale":true };
			ts.graphics.beginFill(0xFFFFFF, 1);
			ts.graphics.drawRect(0, 0, 200, 200);
			ts.graphics.endFill();
			
			ts.nativeTransform = true;
			ts.affineTransform = false;
			ts.gestureReleaseInertia = true;
			ts.gestureEvents = true;
			
			ts.transform3d = false; //output
			ts.motion3d = false //input
			
			ts.addEventListener(GWGestureEvent.DRAG, onDrag);
			ts.addEventListener(GWGestureEvent.ROTATE, onRotate);			
			ts.addEventListener(GWGestureEvent.SCALE, onScale);	
			
			addChild(ts);
		}
				
		private function onDrag(e:GWGestureEvent):void
		{
			//ts.x += e.value.drag_dx;
			//ts.y += e.value.drag_dy;
		}
		
		private function onRotate(e:GWGestureEvent):void
		{			
		}
		
		private function onScale(e:GWGestureEvent):void
		{			
		}
		
	}
}