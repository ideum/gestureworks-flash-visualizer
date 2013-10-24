package visualizer.panels.config.main {
	import com.gestureworks.cml.element.Tab;
	import com.gestureworks.cml.element.TouchContainer;
	import com.gestureworks.cml.events.StateEvent;
	import com.gestureworks.cml.utils.document;
	import com.gestureworks.cml.utils.StateUtils;
	import com.gestureworks.core.TouchSprite;
	import com.gestureworks.events.GWGestureEvent;
	import visualizer.scenes.Interactive3D;
	/**
	 * ...
	 * @author 
	 */
	public class GestureTab extends Tab {
		
		public var touchObject:TouchSprite;
		public var gestureObject:TouchSprite;
		public var interactive3D:Interactive3D;		
		
		public function GestureTab() {
			super();
			gestureFeedbackMenu = document.getElementById("gesture-feedback-menu"); 
			gestureBtns = document.getElementsByClassName("gesture-btn");			
		}
	
		// update
		private function show():void {
			if (currentView == "2D") {	
				StateUtils.loadState(gestureObject, 0);	
				gestureObject.visible = true;
				gestureObject.visualizer.gestureDisplay = true;							
			}
			else {
				display3D.updateView(tabName, motion);
			}
			StateUtils.loadState(data, 0);					
			StateUtils.loadState(dataGraph, 1);						
			loadState2(tabName);	
			gestureFeedbackPanel.addChild(dataGraph);
			gestureView.addChild(viewg);			
		}
		
		private function updateGestureData():void {
			var i:int;			
			var j:int;			
			var gestureHistory:Array;
			var historyLength:int = (gestureObject.tiO.history.length <= captureLength) ? gestureObject.tiO.history.length : captureLength;
			var found:Boolean = false;
			graphCoords.length = 0;
						
			
			for (j = 0; j < historyLength; j++) {
				gestureHistory = gestureObject.tiO.history[j].gestureEventArray;
				for (i = 0; i < gestureHistory.length; i++) {
					if (gestureHistory[i].type == "drag") {
						found = true;
						graphCoords.push( j * graphPaths.childList[0].width / (captureLength - 1), gestureHistory[i].value.drag_dx);
						break;
					}
				}
				if (!found) {
					graphCoords.push( j * graphPaths.childList[0].width / (captureLength - 1), 0 );					
				}
				found = false;
			}
			for (j = historyLength; j < captureLength; j++) {
				graphCoords.push( j * graphPaths.childList[0].width / (captureLength - 1), 0 );
			}	
			
			
			graphPaths.childList[0].pathCoordinatesVector = graphCoords;					
			graphPaths.childList[0].updateGraphic();
						
			
			gestureEventText.text = "";
			
			for each (var ge:GWGestureEvent in gestureEventArray)  {
				switch (ge.value.id) {
					case "n-drag": 
						gestureEventText.text += "id: " + ge.value.id + "   n: " + ge.value.n + "   drag_dx: " + ge.value.drag_dx.toFixed(2) + "   drag_dy: " + ge.value.drag_dy.toFixed(2) + "\n"; 
					break;
					case "n-scale": 
						gestureEventText.text += "id: " + ge.value.id + "   n: " + ge.value.n + "   scale_dsx: " + ge.value.scale_dsx.toFixed(2) + "   scale_dsx: " + ge.value.scale_dsy.toFixed(2) + "\n";
					break;
					case "n-rotate": 
						gestureEventText.text += "id: " + ge.value.id + "   n: " + ge.value.n + "   rotate_dtheta: " +  ge.value.rotate_dtheta.toFixed(2) + "\n"; 
					break;
					case "n-hold": 
						gestureEventText.text += "id: " + ge.value.id + "   n: " + ge.value.n + "   hold_x: " + ge.value.hold_x.toFixed(2) + "   hold_y: " + ge.value.hold_y.toFixed(2) + "\n";
					break;	
					case "n-tap": 
						gestureEventText.text += "id: " + ge.value.id + "   n: " + ge.value.n + "   hold_x: " + ge.value.tap_y.toFixed(2) + "   tap_y: " + ge.value.tap_y.toFixed(2) + "\n";
					break;	
					case "n-double_tap": 
						gestureEventText.text += "id: " + ge.value.id + "   n: " + ge.value.n + "   double_tap_x: " + ge.value.double_tap_x.toFixed(2) + "   double_tap_y: " + ge.value.double_tap_y.toFixed(2) + "\n";
					break;
					case "n-triple_tap": 
						gestureEventText.text += "id: " + ge.value.id + "   n: " + ge.value.n + "   triple_tap_x: " + ge.value.triple_tap_x.toFixed(2) + "   triple_tap_y: " + ge.value.triple_tap_y.toFixed(2) + "\n";
					break;
					case "n-flick": 
						gestureEventText.text += "id: " + ge.value.id + "   n: " + ge.value.n + "   flick_dx: " + ge.value.flick_dx.toFixed(2) + "   flick_dy: " + ge.value.flick_dy.toFixed(2) + "\n";
					break;	
					case "n-swipe": 
						gestureEventText.text += "id: " + ge.value.id + "   n: " + ge.value.n + "   swipe_dx: " + ge.value.swipe_dx.toFixed(2) + "   swipe_dy: " + ge.value.swipe_dy.toFixed(2) + "\n";
					break;	
					case "n-scroll": 
						gestureEventText.text += "id: " + ge.value.id + "   n: " + ge.value.n + "   scroll_dx: " + ge.value.scroll_dx.toFixed(2) + "   scroll_dy: " + ge.value.scroll_dy.toFixed(2) + "\n";
					break;
					case "n-manipulate": 
						gestureEventText.text += "id: " + ge.value.id + "   n: " + ge.value.n + "   dx: " + ge.value.dx.toFixed(2) + "   dy: " + ge.value.dy.toFixed(2) + "   dsx: " + ge.value.dsx.toFixed(2) + "   dsy: " + ge.value.dsy.toFixed(2) + "   dsy: " + ge.value.dtheta.toFixed(2) + "\n";
					break;
					case "3-finger-tilt": 
						gestureEventText.text += "id: " + ge.value.id + "   n: " + ge.value.n + "   tilt_dx: " + ge.value.tilt_dx.toFixed(2) + "   tilt_dy: " + ge.value.tilt_dy.toFixed(2) + "\n";
					break;	
					case "1-finger-pivot": 
						gestureEventText.text += "id: " + ge.value.id + "   n: " + ge.value.n + "   pivot_dtheta: " + ge.value.pivot_dtheta.toFixed(2) + "\n";
					break;
					case "5-finger-orient": 
						gestureEventText.text += "id: " + ge.value.id + "   n: " + ge.value.n + "   orient_dx: " + ge.value.orient_dx.toFixed(2) + "   orient_dy: " + ge.value.orient_dy.toFixed(2) + "   orient_hand: " + ge.value.orient_hand.toFixed(2) + "   orient_thumbID: " + ge.value.orient_thumbID.toFixed(2) + "\n";
					break;						
				}
			}
		}	
			
		private function updateGestures():void {			
			var on:Boolean;
			var gId:String;			
			var newGestures:Object = { };
			currentGML = gmlTemplate.copy();
			
			for (gId in gList) {
				on = gList[gId];
				if (on) {
					for each (var node:XML in gmlData.Gesture_set.*) {
						if (node.@id == gId) {
							currentGML.appendChild(node);
							newGestures[gId] = on;
						}
					}	
				}
			}
			
			gestureObject.gestureList = newGestures;
			gestureGmlText.cacheAsBitmap = false;				
			gestureGmlText.text = String(currentGML);
			gestureGmlText.cacheAsBitmap = true;			
			gestureGmlScrollpane.updateLayout();
		}
			
		private function onGestureBtns(e:StateEvent):void {
			gList[e.id] = e.value; 
			updateGestures();
		}
					
	}

}