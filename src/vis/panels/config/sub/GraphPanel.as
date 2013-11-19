package vis.panels.config.sub {
	import com.gestureworks.cml.elements.Button;
	import com.gestureworks.cml.elements.Container;
	import com.gestureworks.cml.elements.Graphic;
	import com.gestureworks.cml.elements.PopupMenu;
	import com.gestureworks.cml.events.StateEvent;
	import com.gestureworks.cml.managers.StateManager;
	import com.gestureworks.cml.utils.document;
	import com.gestureworks.core.TouchSprite;
	import com.gestureworks.objects.MotionPointObject;
	import com.gestureworks.objects.PointObject;
	import vis.GWVisualizer;
	import vis.interactives.GestureObject2D;
	import vis.Settings;
	/**
	 * ...
	 * @author 
	 */
	public class GraphPanel {
	
		private var pointGraphHistory:Vector.<PointObject>;
		private var iPointGraphHistory:Vector.<MotionPointObject>;
		private var graphCommands:Vector.<int>;
		private var graphCoords:Vector.<Number>;
		private var graphPaths:Container; 
		private var touchObject:TouchSprite;
		private var gestureObject:GestureObject2D;
		private var gestureObject3D:TouchSprite;
		private var gestureFeedbackPanel:Graphic;
		private var gestureView:Container;
		public var gestureDataArray:Array = [];
		private var viewg:Graphic;
		private var graphBtns:Array;
		
		private var captureLength:int;
		private var currentDim:String;
		private var currentBtn:Button;
		private var gestureMenu:PopupMenu;
		private var currentGesture:String;
		private var graphScalar:Number = .3;
		
		public function GraphPanel() {}
		
		public function setup():void {
			captureLength = Settings.captureLength;
			
			touchObject = GWVisualizer.interactive2D;
			gestureObject = GWVisualizer.gestureObject2D;
			gestureObject3D = GWVisualizer.gestureObject3D;
			
			gestureFeedbackPanel = document.getElementById("gesture-feedback-panel");
			viewg = document.getElementById("viewg");
			gestureView = document.getElementById("gesture-view");
			graphBtns = document.getElementsByClassName("graph-btns");
			
			for each (var item:Button in graphBtns) {
				item.addEventListener(StateEvent.CHANGE, onGraphButton);
				item.reset();
			}
			currentDim = "dx";
			currentBtn = graphBtns[0];			
			graphBtns[0].runToggle();
			
			currentGesture = "drag";
			StateManager.loadState(currentGesture);

			graphPaths = document.getElementById("graph-paths");

			pointGraphHistory = new Vector.<PointObject>(); 
			iPointGraphHistory = new Vector.<MotionPointObject>();
			graphCommands = new Vector.<int>(captureLength);
			graphCoords = new Vector.<Number>(captureLength*2);
			
			graphCommands.push(1);
			graphCoords.push(0,0);
			
			var i:int;
			for (i = 1; i < captureLength; i++) {
				graphCommands.push(2); 
				graphCoords.push(0,0);
			}
			for (i = 0; i < graphPaths.childList.length; i++) {			
				graphPaths.childList[i].pathCommandsVector = graphCommands;
			}	
			
			gestureMenu = document.getElementById("gesture-menu");
			gestureMenu.addEventListener(StateEvent.CHANGE, onGestureChange);
		}
			
		
		
		// load
		public function loadPoint():void {
			graphPaths.childList[0].visible = true;			
		}	
		
		public function loadCluster():void {
			graphPaths.childList[0].visible = true;	
		}			
		
		public function loadGesture():void {
			gestureFeedbackPanel.addChild(document.getElementById("data-graph"));
			gestureView.addChild(viewg);			
		}	
		
		
		
		
		// update
		
		// point
		public function updatePointTouch():void {
			
			var i:int;
			var j:int;	
			var historyLength:int;			
			var ptArrayLength:int = (touchObject.pointArray.length <= 10) ? touchObject.pointArray.length : 10;
			
			for (i = 0; i < ptArrayLength; i++) {			
			
				pointGraphHistory = touchObject.pointArray[i].history;				
				historyLength = touchObject.pointArray[i].history.length;
				
				graphCoords.length = 0;
				
				for (j = 0; j < historyLength; j++) {
					graphCoords.push( j * graphPaths.childList[i].width / (captureLength - 1), pointGraphHistory[j][currentDim] * .25 );		
				}
				for (j = historyLength; j < captureLength; j++) {
					graphCoords.push( j * graphPaths.childList[i].width / (captureLength - 1), 0 );
				}			
				
				graphPaths.childList[i].pathCoordinatesVector = graphCoords;					
				graphPaths.childList[i].updateGraphic();
				graphPaths.childList[i].visible = true;	
			}
			// clear unused points
			for (ptArrayLength; i < 10; i++) {
				graphPaths.childList[i].visible = false;
			}				
		}
		
		
		public function updatePointMotion():void {
			
			var i:int;
			var j:int;	
			var ptArrayLength:int;
			var historyLength:int;	
			
			for (i = 0; i < ptArrayLength; i++) {	
			
				iPointGraphHistory = gestureObject3D.cO.motionArray[i].history;				
				historyLength = gestureObject3D.cO.motionArray[i].history.length;
				
				graphCoords.length = 0;
				
				for (j = 0; j < historyLength; j++) {
					graphCoords.push( j * graphPaths.childList[i].width / (captureLength - 1), iPointGraphHistory[j].position.x * .25 );		
				}
				for (j = historyLength; j < captureLength; j++) {
					graphCoords.push( j * graphPaths.childList[i].width / (captureLength - 1), 0 );
				}			
				
				graphPaths.childList[i].pathCoordinatesVector = graphCoords;					
				graphPaths.childList[i].updateGraphic();
			
				graphPaths.childList[i].visible = true;
				// clear unused points
				for (ptArrayLength; i < 10; i++) {
					graphPaths.childList[i].visible = false;
				}
				
			}
		}
		

		
		// cluster
		
		public function updateClusterTouch():void {
			var j:int;			
			var historyLength:int = touchObject.cO.history.length;
			
			graphCoords.length = 0;
			
			for (j = 0; j < historyLength; j++) {
				graphCoords.push( j * graphPaths.childList[0].width / (captureLength - 1), touchObject.cO.history[j][currentDim] * .25 );		
			}
			for (j = historyLength; j < captureLength; j++) {
				graphCoords.push( j * graphPaths.childList[0].width / (captureLength - 1), 0 );
			}			
			graphPaths.childList[0].pathCoordinatesVector = graphCoords;					
			graphPaths.childList[0].updateGraphic();
		}
		
		public function updateClusterMotion():void {
			var j:int;			
			var historyLength:int = gestureObject3D.cO.history.length;
			
			graphCoords.length = 0;
			
			for (j = 0; j < historyLength; j++) {
				graphCoords.push( j * graphPaths.childList[0].width / (captureLength - 1), gestureObject3D.cO.history[j][currentDim] * .25 );		
			}
			for (j = historyLength; j < captureLength; j++) {
				graphCoords.push( j * graphPaths.childList[0].width / (captureLength - 1), 0 );
			}			
			graphPaths.childList[0].pathCoordinatesVector = graphCoords;					
			graphPaths.childList[0].updateGraphic();			
		}

		public function updateSubClusterMotion():void {
			//iPointGraphHistory = GWVisualizer.gestureObject.cO.motionArray[i].history;				
			//historyLength = GWVisualizer.gestureObject.cO.motionArray[i].history.length;
			
			//graphCoords.length = 0;
			//
			//for (j = 0; j < historyLength; j++) {
				//graphCoords.push( j * graphPaths.childList[i].width / (captureLength - 1), iPointGraphHistory[j].position.x / 2 );		
			//}
			//for (j = historyLength; j < captureLength; j++) {
				//graphCoords.push( j * graphPaths.childList[i].width / (captureLength - 1), 0 );
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
		
		
		public function updateGestureTouch():void {
			var i:int;			
			var j:int;			
			
			var gestureHistory:Array = [];			
			graphCoords.length = 0;
				
			var found:Boolean = false;
			for (j = 0; j < captureLength; j++) {
								
				if (gestureObject.gestureDataArray[j]) {
					gestureHistory = gestureObject.gestureDataArray[j];
										
					for (i = 0; i < gestureHistory.length; i++) {
						if (gestureHistory[i] && gestureHistory[i].type == currentGesture) {
							graphCoords.push( j * graphPaths.childList[0].width / (captureLength - 1), 
								gestureHistory[i].value[currentGesture + "_" + currentDim] * graphScalar);
							found = true;
							break;
						}
					}
				}
				if (!found)
					graphCoords.push( j * graphPaths.childList[0].width / (captureLength - 1), 0 );
				
				found = false;
			}
			
			graphPaths.childList[0].pathCoordinatesVector = graphCoords;					
			graphPaths.childList[0].updateGraphic();			
		}
		
		
		
		
		// events
		private function onGraphButton(e:StateEvent):void {
			
			for each (var item:Button in graphBtns) {				
				if (item.id == e.id) {
					currentDim = item.childList[int(e.value)].childList[0].text;
					if (!e.value)
						item.runToggle();
				}
				else  {
					item.reset();
				}
			}
		}
		
		
		private function onGestureChange(e:StateEvent):void {
			if (e.property == "itemSelected") {
				currentGesture = String(e.value).toLowerCase();
				StateManager.loadState(currentGesture);
				for each (var item:Button in graphBtns) {
					item.reset();
				}
				
				switch (currentGesture) {
					case "drag" :
						graphScalar = .3;
					break;
					case "rotate" :
						graphScalar = 2;
					break;
					case "scale" :
						graphScalar = 100;
					break;					
				}
				
				graphBtns[0].runToggle();
			}
		}
		
		
		
	}
}