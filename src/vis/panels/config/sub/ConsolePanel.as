package vis.panels.config.sub {
	import com.gestureworks.cml.elements.Text;
	import com.gestureworks.events.GWGestureEvent;
	/**
	 * ...
	 * @author 
	 */
	public class ConsolePanel {
		
		private var gestureEventText:Text;
		private var gestureEventArray:Array;
		
		public function ConsolePanel() {}
		
		public function setup(_gestureEventText:Text, _gestureEventArray:Array):void {
			gestureEventText = _gestureEventText;
			gestureEventArray = _gestureEventArray;
		}
		
		public function update():void {
			gestureEventText.text = "";
			
			for each (var ge:GWGestureEvent in gestureEventArray)  { 
				switch (ge.type) {
				case "drag": 
					gestureEventText.text += "id: " + ge.value.id + "   n: " + ge.value.n + "   drag_dx: " + ge.value.drag_dx.toFixed(2) + "   drag_dy: " + ge.value.drag_dy.toFixed(2) + "\n"; 					
					break;
				case "scale": 
					gestureEventText.text += "id: " + ge.value.id + "   n: " + ge.value.n + "   scale_dsx: " + ge.value.scale_dsx.toFixed(2) + "   scale_dsx: " + ge.value.scale_dsy.toFixed(2) + "\n";
					break;
				case "rotate": 
					gestureEventText.text += "id: " + ge.value.id + "   n: " + ge.value.n + "   rotate_dtheta: " +  ge.value.rotate_dtheta.toFixed(2) + "\n"; 
					break;
				case "hold": 
					gestureEventText.text += "id: " + ge.value.id + "   n: " + ge.value.n + "   hold_x: " + ge.value.hold_x.toFixed(2) + "   hold_y: " + ge.value.hold_y.toFixed(2) + "\n";
					break;	
				case "tap": 
					gestureEventText.text += "id: " + ge.value.id + "   n: " + ge.value.n + "   tap_x: " + ge.value.tap_y.toFixed(2) + "   tap_y: " + ge.value.tap_y.toFixed(2) + "\n";
					break;	
				case "double_tap": 
					gestureEventText.text += "id: " + ge.value.id + "   n: " + ge.value.n + "   double_tap_x: " + ge.value.double_tap_x.toFixed(2) + "   double_tap_y: " + ge.value.double_tap_y.toFixed(2) + "\n";
					break;
				case "n-": 
					gestureEventText.text += "id: " + ge.value.id + "   n: " + ge.value.n + "   triple_tap_x: " + ge.value.triple_tap_x.toFixed(2) + "   triple_tap_y: " + ge.value.triple_tap_y.toFixed(2) + "\n";
					break;
				case "flick": 
					gestureEventText.text += "id: " + ge.value.id + "   n: " + ge.value.n + "   flick_dx: " + ge.value.flick_dx.toFixed(2) + "   flick_dy: " + ge.value.flick_dy.toFixed(2) + "\n";
					break;	
				case "swipe": 
					gestureEventText.text += "id: " + ge.value.id + "   n: " + ge.value.n + "   swipe_dx: " + ge.value.swipe_dx.toFixed(2) + "   swipe_dy: " + ge.value.swipe_dy.toFixed(2) + "\n";
					break;	
				case "scroll": 
					gestureEventText.text += "id: " + ge.value.id + "   n: " + ge.value.n + "   scroll_dx: " + ge.value.scroll_dx.toFixed(2) + "   scroll_dy: " + ge.value.scroll_dy.toFixed(2) + "\n";
					break;
				case "manipulate": 
					gestureEventText.text += "id: " + ge.value.id + "   n: " + ge.value.n + "   dx: " + ge.value.dx.toFixed(2) + "   dy: " + ge.value.dy.toFixed(2) + "   dsx: " + ge.value.dsx.toFixed(2) + "   dsy: " + ge.value.dsy.toFixed(2) + "   dsy: " + ge.value.dtheta.toFixed(2) + "\n";
					break;
				case "tilt": 
					gestureEventText.text += "id: " + ge.value.id + "   n: " + ge.value.n + "   tilt_dx: " + ge.value.tilt_dx.toFixed(2) + "   tilt_dy: " + ge.value.tilt_dy.toFixed(2) + "\n";
					break;	
				case "pivot": 
					gestureEventText.text += "id: " + ge.value.id + "   n: " + ge.value.n + "   pivot_dtheta: " + ge.value.pivot_dtheta.toFixed(2) + "\n";
					break;
				case "orient": 
					gestureEventText.text += "id: " + ge.value.id + "   n: " + ge.value.n + "   orient_dx: " + ge.value.orient_dx.toFixed(2) + "   orient_dy: " + ge.value.orient_dy.toFixed(2) + "   orient_hand: " + ge.value.orient_hand.toFixed(2) + "   orient_thumbID: " + ge.value.orient_thumbID.toFixed(2) + "\n";
				break;						
				}
			}	
		}
	}

}