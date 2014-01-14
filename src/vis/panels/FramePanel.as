package vis.panels {
	import com.gestureworks.cml.elements.Container;
	import com.gestureworks.cml.elements.Text;
	import com.gestureworks.core.GestureWorks;
	import com.gestureworks.utils.FrameRate;
	import vis.GWVisualizer;
	
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

		
		// setup
		public function setup():void {			
			rateText = getElementById("rate-text"); 
			tpntsText = getElementById("tpnts-text");
						
			rateText.text = String(GestureWorks.application.frameRate);
			frameRate = new FrameRate(0, 0, 0xffffff, false, 0x000000, false);	
		}		

		
		// update
		public function update():void {
			rateText.text = String(frameRate.tick());
			tpntsText.text = String(GWVisualizer.gestureObject2D.pointArray.length + GWVisualizer.interactive2D.pointArray.length);						
		}
		private function updatePointCnt():void {
			tpntsText.text = String(GWVisualizer.gestureObject2D.pointArray.length + GWVisualizer.interactive2D.pointArray.length);			
		}		
			
	}
}