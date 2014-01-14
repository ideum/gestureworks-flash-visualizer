package vis.interactives {
	import com.gestureworks.cml.away3d.elements.TouchContainer3D;
	import com.gestureworks.cml.elements.Graphic;
	import com.gestureworks.core.TouchSprite;
	import com.gestureworks.events.GWGestureEvent;
	import vis.Settings;
	
	/**
	 * ...
	 * @author 
	 */
	public class GestureObject3D extends TouchContainer3D {

		public var gestureTextArray:Array = [];
		public var gestureDataArray:Array = [];
		private var frameArray:Array = [];
				
		public function GestureObject3D():void {}
		
		// setup
		public function setup():void {
			nativeTransform = false;
			gestureEvents = true;
			visualizer.ts = this;
			visualizer.pointDisplay = true;
			visualizer.clusterDisplay = true;			
			visualizer.gestureDisplay = true;
			debugDisplay = true;
			gestureEvents = true;
			tiO.timelineOn = true;
			width = 500;
			height = 500;
						
			//visualizer.initDebug();
			//visualizer.initDebugDisplay()
			visualizer.point.init();
			visualizer.point.maxTrails = 30;			

			Settings.setupVisualizer(this);
		}
		
		// loader
		public function load():void {
			addListeners();
		}
		public function unload():void {
			removeListeners();
		}		
		
		// listener
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
			removeEventListener(GWGestureEvent.DRAG, onGesture);
			removeEventListener(GWGestureEvent.SCALE, onGesture);
			removeEventListener(GWGestureEvent.ROTATE, onGesture);			
			removeEventListener(GWGestureEvent.HOLD, onGesture);			
			removeEventListener(GWGestureEvent.TAP, onGesture);			
			removeEventListener(GWGestureEvent.FLICK, onGesture);			
			removeEventListener(GWGestureEvent.SCROLL, onGesture);			
			removeEventListener(GWGestureEvent.DOUBLE_TAP, onGesture);			
			removeEventListener(GWGestureEvent.TRIPLE_TAP, onGesture);			
			removeEventListener(GWGestureEvent.STROKE, onGesture);			
			removeEventListener(GWGestureEvent.MANIPULATE, onGesture);			
			removeEventListener(GWGestureEvent.SWIPE, onGesture);			
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
			if (gestureTextArray.length == 15) {
				gestureTextArray.pop();
			}
		}	
		
		override public function set visible(value:Boolean):void {
			super.visible = value;
			vto.visible = value;
		}
		
	}
}