package visualizer.scenes {
	import com.gestureworks.cml.element.TouchContainer;
	import com.gestureworks.cml.utils.document;
	import com.gestureworks.core.GestureWorks;
	import com.gestureworks.core.TouchSprite;
	import com.gestureworks.events.GWGestureEvent;
	import flash.display.Stage;
	/**
	 * ...
	 * @author 
	 */
	public class Interactive2D {
		private var touchObject:TouchContainer	
		private var gestureObject:TouchContainer;
		private var stage:Stage;
		private var gestureEventArray:Array;
		
		public function Interactive2D() {
			stage = GestureWorks.application.stage;
			touchObject = document.getElementById("touch-object");	
			gestureObject = document.getElementById("gesture-object");
			setupTouchObject();
			setupGestureObject();			
		}
		
		// setup
		private function setupTouchObject():void {
			touchObject.nativeTransform = false;					
			touchObject.debugDisplay = true;
			touchObject.visualizer.point.maxTrails = 20;
			touchObject.visualizer.point.init();
			touchObject.visualizer.pointDisplay = true;
			touchObject.visualizer.clusterDisplay = false;			
			touchObject.visualizer.gestureDisplay = false;
			touchObject.gestureEvents = true;
			
			//remove3DScene();
			//touchObjectIndex = getChildIndex(touchObject);
			//add3DScene();
		}
		
		private function setupGestureObject():void {
			gestureObject.visible = false;	
			gestureObject.nativeTransform = true;						
			gestureObject.debugDisplay = true;

			gestureObject.state[0]['x'] = stage.stageWidth / 2 - gestureObject.width / 2;
			gestureObject.state[0]['y'] = stage.stageHeight / 2 - gestureObject.height / 2;
		
			//remove3DScene();
			//gestureObjectIndex = getChildIndex(gestureObject);				
			//add3DScene();
		}	
		
		private function setupVisualizer(ts0:TouchSprite):void {		
			/////////////////////////////////////////////////////////////////////////////////////////////////
			// control point visualizer
			ts0.visualizer.pointDisplay = true; // turn on/off point visualizer layer
			ts0.visualizer.point.drawText = true;
			ts0.visualizer.point.drawShape = true;
			ts0.visualizer.point.drawVector = true;
			
			// set point element styles
			ts0.visualizer.point.style.stroke_thickness = 10;
			ts0.visualizer.point.style.stroke_color = 0xFFAE1F;
			ts0.visualizer.point.style.stroke_alpha = 0.5;
			ts0.visualizer.point.style.fill_color = 0xFFAE1F;
			ts0.visualizer.point.style.fill_alpha = 0.5;
			ts0.visualizer.point.style.radius = 25;
			ts0.visualizer.point.style.height = 20;
			ts0.visualizer.point.style.width = 20;
			ts0.visualizer.point.style.shape = "circle-fill"; // square/ring/cross/tringle/circle-fill/tringle-fill/square/fill
			ts0.visualizer.point.style.trail_shape = "circle-fill"; //line/cirve/ring
			//ts0.visualizer.point.style.touch_text_color = 0x9BD6EA; //blue
			ts0.visualizer.point.style.touch_text_color = 0xFFAE1F; //orange
			//ts0.visualizer.point.style.touch_text_color = 0xFFFFFF; //white
					
			// motion point draw
			//ts0.visualizer.motion_point.
			
			//////////////////////////////////////////////////////////////////////////////////////////////////
			//control cluster visualization
			ts0.visualizer.cluster.drawRadius = true; // control cluster radius draw element
			ts0.visualizer.cluster.drawCenter = true; // control cluster center draw element
			ts0.visualizer.cluster.drawBisector = true; // control cluster bisector draw element
			ts0.visualizer.cluster.drawBox = true; // control cluster bounding box draw element
			ts0.visualizer.cluster.drawWeb = true; // control cluster web draw element
			//ts0.visualizer.cluster.drawCentroid = false; // control cluster centroid draw element
			ts0.visualizer.cluster.drawRotation = true; // control cluster segment draw element
			//ts0.visualizer.cluster.drawSeparation = false; // control cluster radius draw element
			
			// set element styles
			ts0.visualizer.cluster.style.stroke_color = 0xFFAE1F; //main stroke color for cluster
			ts0.visualizer.cluster.style.stroke_thickness = 4;
			ts0.visualizer.cluster.style.stroke_color = 0xFFAE1F;
			ts0.visualizer.cluster.style.stroke_alpha = 0.9;
			ts0.visualizer.cluster.style.fill_color = 0xFFAE1F;
			ts0.visualizer.cluster.style.fill_alpha = 0.9;
			ts0.visualizer.cluster.style.radius = 20; // for cluster center
			ts0.visualizer.cluster.style.c_stroke_thickness = 16;// circle line thickness
			ts0.visualizer.cluster.style.c_stroke_alpha = 0.6; //circle line alpha
			ts0.visualizer.cluster.style.web_shape = "starweb"; // sets web type starweb or fullweb

			// rotation
			ts0.visualizer.cluster.style.a_stroke_thickness = 2;
			ts0.visualizer.cluster.style.a_stroke_color = 0x4B7BCC;
			ts0.visualizer.cluster.style.a_stroke_alpha = 0.8;
			ts0.visualizer.cluster.style.a_fill_color = 0x9BD6EA;
			ts0.visualizer.cluster.style.a_fill_alpha = 0.3;
			ts0.visualizer.cluster.style.b_stroke_thickness = 2;
			ts0.visualizer.cluster.style.b_stroke_color = 0xFF0000;
			ts0.visualizer.cluster.style.b_stroke_alpha = 0.2;
			ts0.visualizer.cluster.style.b_fill_color = 0xFF0000;
			ts0.visualizer.cluster.style.b_fill_alpha = 0.3;
			ts0.visualizer.cluster.style.rotation_shape = "segment"; // segment or slice
			ts0.visualizer.cluster.style.rotation_radius = 200;
			ts0.visualizer.cluster.style.percent = 0.7 // percent fill of segment
			
			/////////////////////////////////////////////////////////////////////////////////////////////////
			//  control gesture visualizer
			ts0.visualizer.gesture.drawOrientation = true;
			ts0.visualizer.gesture.drawTransformation = true;
			ts0.visualizer.gesture.drawPivot = true;
			ts0.visualizer.gesture.drawRotation = true;
			ts0.visualizer.gesture.drawStroke = true;

			// set gesture element styles
			ts0.visualizer.gesture.style.stroke_thickness = 4;
			ts0.visualizer.gesture.style.stroke_color = 0x9BD6EA;
			ts0.visualizer.gesture.style.stroke_alpha = 0.9;
			ts0.visualizer.gesture.style.fill_color = 0x9BD6EA;
			ts0.visualizer.gesture.style.fill_alpha = 0.1;
			ts0.visualizer.gesture.style.radius = 10;
			ts0.visualizer.gesture.style.line_type = "dashed"	
			
			ts0.updateDebugDisplay();
		}			
		
		// update
		private function addListeners():void {
			gestureObject.addEventListener(GWGestureEvent.DRAG, onGesture);
			gestureObject.addEventListener(GWGestureEvent.SCALE, onGesture);
			gestureObject.addEventListener(GWGestureEvent.ROTATE, onGesture);			
			gestureObject.addEventListener(GWGestureEvent.HOLD, onGesture);			
			gestureObject.addEventListener(GWGestureEvent.TAP, onGesture);			
			gestureObject.addEventListener(GWGestureEvent.FLICK, onGesture);			
			gestureObject.addEventListener(GWGestureEvent.SCROLL, onGesture);			
			gestureObject.addEventListener(GWGestureEvent.DOUBLE_TAP, onGesture);			
			gestureObject.addEventListener(GWGestureEvent.TRIPLE_TAP, onGesture);			
			gestureObject.addEventListener(GWGestureEvent.STROKE, onGesture);			
			gestureObject.addEventListener(GWGestureEvent.MANIPULATE, onGesture);			
			gestureObject.addEventListener(GWGestureEvent.SWIPE, onGesture);			
		}
		
		private function removeListeners():void {
			gestureObject.addEventListener(GWGestureEvent.DRAG, onGesture);
			gestureObject.addEventListener(GWGestureEvent.SCALE, onGesture);
			gestureObject.addEventListener(GWGestureEvent.ROTATE, onGesture);			
			gestureObject.addEventListener(GWGestureEvent.HOLD, onGesture);			
			gestureObject.addEventListener(GWGestureEvent.TAP, onGesture);			
			gestureObject.addEventListener(GWGestureEvent.FLICK, onGesture);			
			gestureObject.addEventListener(GWGestureEvent.SCROLL, onGesture);			
			gestureObject.addEventListener(GWGestureEvent.DOUBLE_TAP, onGesture);			
			gestureObject.addEventListener(GWGestureEvent.TRIPLE_TAP, onGesture);			
			gestureObject.addEventListener(GWGestureEvent.STROKE, onGesture);			
			gestureObject.addEventListener(GWGestureEvent.MANIPULATE, onGesture);			
			gestureObject.addEventListener(GWGestureEvent.SWIPE, onGesture);			
		}	
		
		// event
		private function onGesture(e:GWGestureEvent):void {
			gestureEventArray.unshift (e);			
			if (gestureEventArray.length == 15)
				gestureEventArray.pop();
		}			
		
	}
}