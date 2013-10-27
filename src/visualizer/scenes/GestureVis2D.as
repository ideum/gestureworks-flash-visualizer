package visualizer.scenes {
	import com.gestureworks.cml.element.Graphic;
	import com.gestureworks.cml.element.TouchContainer;
	import com.gestureworks.cml.utils.document;
	import com.gestureworks.core.GestureWorks;
	import com.gestureworks.core.TouchSprite;
	import com.gestureworks.events.GWGestureEvent;
	
	/**
	 * ...
	 * @author 
	 */
	public class GestureVis2D extends Graphic {

		private var gestureEventArray:Array;
		
		public function GestureVis2D() {}
		
		// setup
		public function setup():void {
			mouseChildren = false;	
			visible = false;	
			nativeTransform = true;						
			debugDisplay = true;
			gestureEvents = true;

			state[0]['x'] = stage.stageWidth / 2 - width / 2;
			state[0]['y'] = stage.stageHeight / 2 - height / 2;
		
			Settings.setupVisualizer(this);	
			
			//remove3DScene();
			//gestureObjectIndex = getChildIndex(gestureObject);				
			//add3DScene();			
		}
		
		// update
		public function addListeners():void {
			addEventListener(GWGestureEvent.DRAG, onGesture);
			addEventListener(GWGestureEvent.SCALE, onGesture);
			addEventListener(GWGestureEvent.ROTATE, onGesture);			
			addEventListener(GWGestureEvent.HOLD, onGesture);			
			addEventListener(GWGestureEvent.TAP, onGesture);			
			addEventListener(GWGestureEvent.FLICK, onGesture);			
			addEventListener(GWGestureEvent.SCROLL, onGesture);			
			addEventListener(GWGestureEvent.DOUBLE_TAP, onGesture);			
			addEventListener(GWGestureEvent.TRIPLE_TAP, onGesture);			
			addEventListener(GWGestureEvent.STROKE, onGesture);			
			addEventListener(GWGestureEvent.MANIPULATE, onGesture);			
			addEventListener(GWGestureEvent.SWIPE, onGesture);			
		}
		
		public function removeListeners():void {
			addEventListener(GWGestureEvent.DRAG, onGesture);
			addEventListener(GWGestureEvent.SCALE, onGesture);
			addEventListener(GWGestureEvent.ROTATE, onGesture);			
			addEventListener(GWGestureEvent.HOLD, onGesture);			
			addEventListener(GWGestureEvent.TAP, onGesture);			
			addEventListener(GWGestureEvent.FLICK, onGesture);			
			addEventListener(GWGestureEvent.SCROLL, onGesture);			
			addEventListener(GWGestureEvent.DOUBLE_TAP, onGesture);			
			addEventListener(GWGestureEvent.TRIPLE_TAP, onGesture);			
			addEventListener(GWGestureEvent.STROKE, onGesture);			
			addEventListener(GWGestureEvent.MANIPULATE, onGesture);			
			addEventListener(GWGestureEvent.SWIPE, onGesture);			
		}	
		
		// event
		private function onGesture(e:GWGestureEvent):void {
			gestureEventArray.unshift (e);			
			if (gestureEventArray.length == 15)
				gestureEventArray.pop();
		}			
		
	}
}