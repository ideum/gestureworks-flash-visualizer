package visualizer.panels {
	import com.gestureworks.cml.core.CMLParser;
	import com.gestureworks.cml.element.Container;
	import com.gestureworks.cml.element.Text;
	import com.gestureworks.cml.element.TouchContainer;
	import com.gestureworks.core.GestureWorks;
	import com.gestureworks.core.TouchSprite;
	import com.gestureworks.events.GWTouchEvent;
	import com.gestureworks.utils.FrameRate;
	import flash.events.Event;
	import visualizer.GWVisualizer;
	
	/**
	 * ...
	 * @author 
	 */
	public class FramePanel extends Container {
		
		private var frameRate:FrameRate;
		
		// cml objects
		private var rateText:Text;
		private var tpntsText:Text;
		
		public function FramePanel() {
			super();
		}

		public function setup():void {			
			rateText = getElementById("rate-text"); 
			tpntsText = getElementById("tpnts-text");
						
			rateText.text = String(GestureWorks.application.frameRate);
			frameRate = new FrameRate(0, 0, 0xffffff, false, 0x000000, false);	
			
			GWVisualizer(parent).addEventListener(GWTouchEvent.TOUCH_BEGIN, onTouchBegin);
			GWVisualizer(parent).addEventListener(GWTouchEvent.TOUCH_END, onTouchEnd);
		}		

		
		// update
		public function update():void {
			rateText.text = String(frameRate.tick());
		}
		
		private function updatePointCnt():void {
			tpntsText.text = String(GWVisualizer.gestureObject2D.pointArray.length + GWVisualizer.touchObject2D.pointArray.length);			
		}		
		
		
		// event handlers
		private function onTouchBegin(e:GWTouchEvent):void { 
			updatePointCnt();
		}
				
		private function onTouchEnd(e:GWTouchEvent):void {		
			updatePointCnt();
		}			
		
	}
}