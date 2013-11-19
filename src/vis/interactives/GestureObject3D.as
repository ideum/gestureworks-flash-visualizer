package vis.interactives {
	import com.gestureworks.cml.elements.Graphic;
	import com.gestureworks.core.TouchSprite;
	import com.gestureworks.events.GWGestureEvent;
	import vis.Settings;
	
	/**
	 * ...
	 * @author 
	 */
	public class GestureObject3D extends TouchSprite {

		public var gestureTextArray:Array = [];
		public var gestureDataArray:Array = [];
		private var frameArray:Array = [];
		
		private var gestureObject:TouchSprite;
		
		public function GestureObject3D(_gestureObject:TouchSprite):void {
			gestureObject = _gestureObject;
		}
		
		// setup
		public function setup():void {
			gestureObject.nativeTransform = false;					
			gestureObject.debugDisplay = true;
			gestureObject.gestureEvents = false;
			gestureObject.visualizer.point.maxTrails = 30;
			gestureObject.visualizer.point.init();
			gestureObject.visualizer.pointDisplay = true;
			gestureObject.visualizer.clusterDisplay = false;			
			gestureObject.visualizer.gestureDisplay = false;
			Settings.setupVisualizer(gestureObject);			
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