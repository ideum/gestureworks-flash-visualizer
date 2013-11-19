package vis.interactives {
	import com.gestureworks.cml.elements.Graphic;
	import com.gestureworks.events.GWGestureEvent;
	import vis.Settings;
	
	/**
	 * ...
	 * @author 
	 */
	public class GestureObject2D extends Graphic {

		public var gestureTextArray:Array = [];
		public var gestureDataArray:Array = [];
		private var frameArray:Array = [];
		
		public function GestureObject2D() {}
		
		// setup
		public function setup():void {
			mouseChildren = false;	
			visible = false;	
			nativeTransform = true;						
			debugDisplay = true;
			gestureEvents = true;
			tiO.timelineOn = true;

			state[0]['x'] = stage.stageWidth / 2 - width / 2;
			state[0]['y'] = stage.stageHeight / 2 - height / 2;
		
			Settings.setupVisualizer(this);	
		}
		
		// load 
		public function load():void {
			addListeners();
		}
		
		public function unload():void {
			removeListeners();
		}		
		
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
		
		// update
		public function update():void {
			gestureDataArray.unshift(frameArray);
			if (gestureDataArray.length > Settings.captureLength)
				gestureDataArray.pop();
			frameArray = [];
		}
		
		// event
		private function onGesture(e:GWGestureEvent):void {
			frameArray.unshift(e);
			gestureTextArray.unshift(e);			
			if (gestureTextArray.length == 15)
				gestureTextArray.pop();
		}			
		
	}
}