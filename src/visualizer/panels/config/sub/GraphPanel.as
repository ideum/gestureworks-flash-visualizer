package visualizer.panels.config.sub {
	import com.gestureworks.cml.element.Container;
	import com.gestureworks.cml.element.Graphic;
	import com.gestureworks.cml.utils.document;
	import com.gestureworks.cml.utils.StateUtils;
	import com.gestureworks.core.TouchSprite;
	import com.gestureworks.objects.MotionPointObject;
	import com.gestureworks.objects.PointObject;
	import visualizer.GWVisualizer;
	/**
	 * ...
	 * @author 
	 */
	public class GraphPanel {
	
		private static var pointGraphHistory:Vector.<PointObject>;
		private static var iPointGraphHistory:Vector.<MotionPointObject>;
		private static var graphCommands:Vector.<int>;
		private static var graphCoords:Vector.<Number>;
		private static var graphPaths:Container; 
		private static var touchObject:TouchSprite;
		private static var gestureObject:TouchSprite;
		private static var gestureObject3D:TouchSprite;
		private static var gestureFeedbackPanel:Graphic;
		private static var gestureView:Container;
		private static var viewg:Graphic;
		
		public function GraphPanel() {}
		
		private static function setup():void {
			
			touchObject = GWVisualizer.touchObject2D;
			gestureObject = GWVisualizer.gestureObject2D;
			gestureObject3D = GWVisualizer.gestureObject3D;
			gestureFeedbackPanel = document.getElementById("gesture-feedback-panel");
			viewg = document.getElementById("viewg");
			
			graphPaths = document.getElementById("graph-paths");			
			pointGraphHistory = new Vector.<PointObject>(); 
			iPointGraphHistory = new Vector.<MotionPointObject>();
			graphCommands = new Vector.<int>(GWVisualizer.captureLength);
			graphCoords = new Vector.<Number>(GWVisualizer.captureLength*2);
			
			graphCommands.push(1);
			graphCoords.push(0,0);
			
			var i:int;
			for (i = 1; i < GWVisualizer.captureLength; i++) {
				graphCommands.push(2); 
				graphCoords.push(0,0);
			}
			for (i = 0; i < graphPaths.childList.length; i++) {			
				graphPaths.childList[i].pathCommandsVector = graphCommands;
			}	
		}
		
		public static function showPoint():void {
			graphPaths.childList[0].visible = false;			
		}
		
		public static function showGesture():void {
			gestureFeedbackPanel.addChild(DataPanel.dataGraph);
			gestureView.addChild(viewg);			
		}
		
		/////////////
		// point
		//////////////
		
		public static function updatePointTouch():void {
			
			var i:int;
			var j:int;	
			var ptArrayLength:int;
			var historyLength:int;			
			
			pointGraphHistory = touchObject.pointArray[i].history;				
			historyLength = touchObject.pointArray[i].history.length;
			
			graphCoords.length = 0;
			
			for (j = 0; j < historyLength; j++) {
				graphCoords.push( j * graphPaths.childList[i].width / (GWVisualizer.captureLength - 1), pointGraphHistory[j].dx / 2 );		
			}
			for (j = historyLength; j < GWVisualizer.captureLength; j++) {
				graphCoords.push( j * graphPaths.childList[i].width / (GWVisualizer.captureLength - 1), 0 );
			}			
			
			graphPaths.childList[i].pathCoordinatesVector = graphCoords;					
			graphPaths.childList[i].updateGraphic();

			graphPaths.childList[i].visible = true;	
			// clear unused points
			for (ptArrayLength; i < 10; i++) {
				graphPaths.childList[i].visible = false;
			}				
		}
		
		
		public static function updatePointMotion():void {
			
			var i:int;
			var j:int;	
			var ptArrayLength:int;
			var historyLength:int;	
			
			iPointGraphHistory = gestureObject3D.cO.motionArray[i].history;				
			historyLength = gestureObject3D.cO.motionArray[i].history.length;
			
			graphCoords.length = 0;
			
			for (j = 0; j < historyLength; j++) {
				graphCoords.push( j * graphPaths.childList[i].width / (GWVisualizer.captureLength - 1), iPointGraphHistory[j].position.x / 2 );		
			}
			for (j = historyLength; j < GWVisualizer.captureLength; j++) {
				graphCoords.push( j * graphPaths.childList[i].width / (GWVisualizer.captureLength - 1), 0 );
			}			
			
			graphPaths.childList[i].pathCoordinatesVector = graphCoords;					
			graphPaths.childList[i].updateGraphic();
		
			graphPaths.childList[i].visible = true;
			// clear unused points
			for (ptArrayLength; i < 10; i++) {
				graphPaths.childList[i].visible = false;
			}			
		}
		
		/////////////
		// cluster
		//////////////		
		
		public static function updateClusterTouch():void {
			var j:int;			
			var historyLength:int = touchObject.cO.history.length;
			
			graphCoords.length = 0;
			
			for (j = 0; j < historyLength; j++) {
				graphCoords.push( j * graphPaths.childList[0].width / (GWVisualizer.captureLength - 1), touchObject.cO.history[j].dx / 2 );		
			}
			for (j = historyLength; j < GWVisualizer.captureLength; j++) {
				graphCoords.push( j * graphPaths.childList[0].width / (GWVisualizer.captureLength - 1), 0 );
			}			
			graphPaths.childList[0].pathCoordinatesVector = graphCoords;					
			graphPaths.childList[0].updateGraphic();
		}
		
		public static function updateClusterMotion():void {
			var j:int;			
			var historyLength:int = gestureObject.cO.history.length;
			
			graphCoords.length = 0;
			
			for (j = 0; j < historyLength; j++) {
				graphCoords.push( j * graphPaths.childList[0].width / (GWVisualizer.captureLength - 1), gestureObject.cO.history[j].dx / 2 );		
			}
			for (j = historyLength; j < GWVisualizer.captureLength; j++) {
				graphCoords.push( j * graphPaths.childList[0].width / (GWVisualizer.captureLength - 1), 0 );
			}			
			graphPaths.childList[0].pathCoordinatesVector = graphCoords;					
			graphPaths.childList[0].updateGraphic();			
		}

		public static function updateSubClusterMotion():void {
			//iPointGraphHistory = GWVisualizer.gestureObject.cO.motionArray[i].history;				
			//historyLength = GWVisualizer.gestureObject.cO.motionArray[i].history.length;
			
			//graphCoords.length = 0;
			//
			//for (j = 0; j < historyLength; j++) {
				//graphCoords.push( j * graphPaths.childList[i].width / (GWVisualizer.captureLength - 1), iPointGraphHistory[j].position.x / 2 );		
			//}
			//for (j = historyLength; j < GWVisualizer.captureLength; j++) {
				//graphCoords.push( j * graphPaths.childList[i].width / (GWVisualizer.captureLength - 1), 0 );
			//}			
			//
			//graphPaths.childList[i].pathCoordinatesVector = graphCoords;					
			//graphPaths.childList[i].updateGraphic();
		//
			//graphPaths.childList[i].visible = true;
			
			//for (subClusterArrayLength; i < 10; i++) {
				//graphPaths.childList[i].visible = false;
			//}			
		}	
		
		/////////////
		// gesture
		//////////////	
		
		public static function updateGestureTouch():void {
			var i:int;			
			var j:int;			
			var gestureHistory:Array;
			var historyLength:int = (gestureObject.tiO.history.length <= GWVisualizer.captureLength) ? gestureObject.tiO.history.length : GWVisualizer.captureLength;
			var found:Boolean = false;
			graphCoords.length = 0;
						
			
			for (j = 0; j < historyLength; j++) {
				gestureHistory = gestureObject.tiO.history[j].gestureEventArray;
				for (i = 0; i < gestureHistory.length; i++) {
					if (gestureHistory[i].type == "drag") {
						found = true;
						graphCoords.push( j * graphPaths.childList[0].width / (GWVisualizer.captureLength - 1), gestureHistory[i].value.drag_dx);
						break;
					}
				}
				if (!found) {
					graphCoords.push( j * graphPaths.childList[0].width / (GWVisualizer.captureLength - 1), 0 );					
				}
				found = false;
			}
			for (j = historyLength; j < GWVisualizer.captureLength; j++) {
				graphCoords.push( j * graphPaths.childList[0].width / (GWVisualizer.captureLength - 1), 0 );
			}	
			
			
			graphPaths.childList[0].pathCoordinatesVector = graphCoords;					
			graphPaths.childList[0].updateGraphic();			
		}
		
	}
}