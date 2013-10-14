package 
{			 
	import com.gestureworks.cml.element.*;
	import com.gestureworks.cml.events.*;
	import com.gestureworks.cml.managers.StateManager;
	import com.gestureworks.cml.utils.*;
	import com.gestureworks.core.*;
	import com.gestureworks.events.*;
	import com.gestureworks.objects.*;
	import com.gestureworks.utils.FrameRate;
	import com.gestureworks.utils.GMLParser;
	import flash.events.*;
	import flash.utils.Dictionary;
	
	public class GestureWorksVisualizer extends TouchContainer
	{
		private var currentTab:String = "mode";		
		private var currentDataTab:String = "touch";		
		private var currentView:String = "2D";	
		private var captureLength:int = 60;
		private var gw:GestureWorks;
		
		// cml objects
		private var touchObject:TouchContainer;		
		private var gestureObject:TouchContainer;
		private var away3DScene:Away3DScene;
		private var gestureObject3D:TouchSprite;
		
		private var toggle:Array;
		private var tpntsText:Text;
		private var dataContainer:Container;
		private var dataText:Array;
		private var dataNumCols:Array;		
		private var dataNumbers:Array;
		private var graphPaths:Container;		
		private var rateText:Text;
		private var frameRate:FrameRate;
		private var tabs:TabbedContainer;
		private var pointContainer:Container;
		private var gestureContainer:Container;
		private var pointTab:Tab;
		private var clusterTab:Tab;
		private var gestureTab:Tab;
		private var viewg:Graphic;
		private var data:Graphic;
		private var dataTabSubCluster:Tab;
		private var dataTabMotion:Tab;
		private var dataTabTouch:Tab;
		private var dataPanel:Graphic;
		private var dataGraph:Graphic;
		private var dataTabContainer:Container;
		private var dataTabs:TabbedContainer;
		private var panelText:Array;
		private var gestureFeedbackPanel:Graphic;
		private var gestureGmlText:Text;
		private var gestureEventText:Text;
		private var gestureView:Container;
		private var gestureGmlScrollpane:ScrollPane;
		private var gmlData:XML;
		private var currentGML:XML;
		private var away3DSceneIndex:int;
		private var touchObjectIndex:int;
		private var gestureObjectIndex:int;
		private var viewBtns:RadioButtons;
		private var pointArrayHistory:int;
		private var pointGraphHistory:Vector.<PointObject>;
		private var iPointGraphHistory:Vector.<MotionPointObject>;
		private var graphCommands:Vector.<int>;
		private var graphCoords:Vector.<Number>;
		private var gestureBtns:Array;
		private var gestureEventArray:Array = [];
		private var gList:Object;
		private var gmlTemplate:XML;
		private var motion:Boolean = true;
		
		public function GestureWorksVisualizer()
		{
			mouseChildren = true;
			GestureGlobals.pointHistoryCaptureLength = captureLength;
			GestureGlobals.clusterHistoryCaptureLength = captureLength;
			GestureGlobals.timelineHistoryCaptureLength = captureLength;
		}
		
		public function setup(_gw:GestureWorks):void
		{
			gw = _gw;
			setupLocalVars();
			setupTouchObject();
			setupGestureObject();			
			setupVisualizer(touchObject);
			setupVisualizer(gestureObject);
			setupFrameRate();			
			setupGesture();
			setupTabs();
			setupToggles();
			setupGraph();
			setupDataNumbers();	
			setup3DScene();
			setupVisualizer(gestureObject3D);
			setupListeners();			
		}
		
		
		

		///////////////////////////////////////////
		/////////////// setup /////////////////////
		///////////////////////////////////////////
		
		private function setupLocalVars():void
		{
			touchObject = document.getElementById("touch-object");	
			gestureObject = document.getElementById("gesture-object");			
			rateText = document.getElementById("rate-text");			
			dataContainer = document.getElementById("data-c");
			dataNumbers = document.getElementsByClassName("data-num");
			dataText = document.getElementsByClassName("data-txt");
			graphPaths = document.getElementById("graph-paths");
			tabs = document.getElementById("tabs");
			pointContainer = document.getElementById("point-container");
			gestureContainer = document.getElementById("gesture-container");
			pointTab = document.getElementById("point");
			clusterTab = document.getElementById("cluster");
			gestureTab = document.getElementById("gesture");
			tpntsText = document.getElementById("tpnts-text");
			viewg = document.getElementById("viewg");
			data = document.getElementById("data");
			dataTabSubCluster = document.getElementById("data-tab-sub-cluster");
			dataTabMotion = document.getElementById("data-tab-motion");
			dataTabTouch = document.getElementById("data-tab-touch");
			dataTabContainer = document.getElementById("data-tab-sub");			
			dataPanel = document.getElementById("data-panel");
			dataGraph = document.getElementById("data-graph");
			dataTabs = document.getElementById("data-tabs");
			panelText = document.getElementsByClassName("panel-text");
			gestureFeedbackPanel = document.getElementById("gesture-feedback-panel");
			gestureGmlText = document.getElementById("gesture-gml-text");
			gestureEventText = document.getElementById("gesture-event-text");
			gestureView = document.getElementById("gesture-view");
			gestureGmlScrollpane = document.getElementById("gesture-gml-scrollpane");	
			toggle = document.getElementsByTagName("Toggle");
			away3DScene = document.getElementById("away3d");
			viewBtns = document.getElementById("view-btns");
			dataNumCols = document.getElementsByClassName("data-num-c");
			gestureBtns = document.getElementsByClassName("gesture-btn");
		}
		
		private function setupTouchObject():void
		{
			touchObject.nativeTransform = false;					
			touchObject.debugDisplay = true;
			touchObject.visualizer.point.maxTrails = 20;//captureLength;
			touchObject.visualizer.point.init();
			touchObject.visualizer.pointDisplay = true;
			touchObject.visualizer.clusterDisplay = false;			
			touchObject.visualizer.gestureDisplay = false;
			touchObject.gestureEvents = true;
			remove3DScene();
			touchObjectIndex = getChildIndex(touchObject);
			add3DScene();
		}
		
		private function setupGestureObject():void
		{
			gestureObject.visible = false;	
			gestureObject.nativeTransform = true;						
			gestureObject.debugDisplay = true;

			gestureObject.state[0]['x'] = stage.stageWidth / 2 - gestureObject.width / 2;
			gestureObject.state[0]['y'] = stage.stageHeight / 2 - gestureObject.height / 2;
			remove3DScene();
			gestureObjectIndex = getChildIndex(gestureObject);				
			add3DScene();
		}
		
		private function setupGestureObject3D():void
		{
			gestureObject3D.visible = false;	
			gestureObject3D.nativeTransform = true;						
			gestureObject3D.debugDisplay = true;
			gestureObject3D.gestureEvents = true;
			gestureObject3D.visualizer.pointDisplay = true;
			gestureObject3D.visualizer.clusterDisplay = true;			
			gestureObject3D.visualizer.gestureDisplay = true;
			gestureObject3D.tiO.timelineOn = true;
		}
		
		private function setupVisualizer(ts0:TouchSprite):void
		{		
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
		
		private function setupListeners():void
		{
			touchObject.addEventListener(GWTouchEvent.TOUCH_BEGIN, onTouchBegin);
			gestureObject.addEventListener(GWTouchEvent.TOUCH_BEGIN, onTouchBegin);
			
			//TODO: add TUIO touch point removal
			//TODO: add LEAP2D touch point removal

			stage.addEventListener(TouchEvent.TOUCH_END, onTouchEnd);
			stage.addEventListener(MouseEvent.MOUSE_UP, onTouchEnd);
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);	
			
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
						
			tabs.addEventListener(StateEvent.CHANGE, onTabContainer);
			dataTabs.addEventListener(StateEvent.CHANGE, onDataTabContainer);	
			viewBtns.addEventListener(StateEvent.CHANGE, onViewBtns);	
			
			for each (var t:Toggle in toggle)
				t.addEventListener(StateEvent.CHANGE, onToggle);
		}
		
		private function setupGesture():void
		{
			XML.ignoreWhitespace = true;
			XML.prettyPrinting = true;					
			
			gmlData = XML(GMLParser.settings);	
			gmlTemplate = XML(<GestureMarkupLanguage/>);
			gList = CloneUtils.deepCopyObject(gestureObject.gestureList);
			
			var gId:String;
			var on:Boolean;
			
			for (gId in gList) {
				on = gList[gId];
				if (!on) 
					Button( document.getElementById(gId) ).runToggle();
			}			
			
			updateGestures();
			for each (var btn:Button in gestureBtns)
				btn.addEventListener(StateEvent.CHANGE, onGestureBtns);
		}
		
		private function setupTabs():void
		{
			tabs.selectTabByIndex(0);
			dataTabs.selectTabByIndex(0);			
		}
		
		private function setupToggles():void
		{
			for each (var item:Toggle in toggle)
				item.value = true;
			
			// mode
			document.getElementById("simulator").value = gw.simulator;		
			document.getElementById("native").value = gw.nativeTouch;		
			document.getElementById("tuio").value = gw.tuio;
			document.getElementById("leap2D").value = gw.leap2D;
			document.getElementById("leap3D").value = gw.leap3D;
		}
		
		private function setupFrameRate():void
		{
			rateText.text = String(GestureWorks.application.frameRate);	
			frameRate = new FrameRate(0, 0, 0xffffff, false, 0x000000, false);					
		}
		
		private function setup3DScene():void
		{
			remove2DScene();
			away3DSceneIndex = getChildIndex(away3DScene);			
			remove3DScene();
			add2DScene();
			gestureObject3D = away3DScene.gestureObject;
		}
		
		private function setupDataNumbers():void
		{
			var i:int;
			for (i = 1; i < dataNumCols.length; i+=2) {
				for (var j:int = 0; j < dataNumCols[i].childList.length; j++)
					dataNumCols[i].childList[j].font = "OpenSansRegular";			
			}	
			for (i = 1; i < dataNumCols.length; i++) {
				dataNumCols[i].state[0]["x"] = dataNumCols[i].x;
				dataNumCols[i].state[1] = new Dictionary;
				dataNumCols[i].state[1]["x"] = dataNumCols[i].x + i * 50;
			}		
		}
		
		private function setupGraph():void
		{
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
		}
		
		
		
		
		
		///////////////////////////////////////////
		/////////// event handlers ////////////////
		///////////////////////////////////////////		
	
		private function onViewBtns(e:StateEvent):void
		{
			if (currentView == e.value) 
				return;
			
			currentView = e.value;
			
			switch (e.value) {
				case "2D": 
					remove3DScene();										
					add2DScene();
					break;
				case "3D": 
					remove2DScene();										
					add3DScene();
					break;					
			}
		}		
				
		private function onToggle(e:StateEvent):void
		{
			var t:Toggle = Toggle(e.target);
						
			var label:String = Text(Toggle(e.target).childList.getClass(Text, 0)).text;			
			label = label.toLowerCase();
						
			switch (label) {
				
				// mode
				case "simulator":
					gw.simulator = e.value;
					break;
				case "tuio": 
					gw.tuio = e.value;
					break;
				case "leap 2d": 
					gw.leap2D = e.value;
					if (gw.leap2D) gw.leap3D = false;
					break;	
				case "native": 
					gw.nativeTouch = e.value;
					break;		
				case "leap 3d": 
					gw.leap3D = e.value;
					if (gw.leap3D)
						gw.leap2D = false;
					break;
				
					
				// point
				case "text":
					touchObject.visualizer.point.drawText = e.value;
					gestureObject.visualizer.point.drawText = e.value;
					break;
				case "shape":
					touchObject.visualizer.point.drawShape = e.value;
					gestureObject.visualizer.point.drawShape = e.value;
					break;
				case "vector":
					touchObject.visualizer.point.drawVector = e.value;										
					gestureObject.visualizer.point.drawVector = e.value;										
					break;
				
					
				// cluster
				case "point":
					touchObject.visualizer.pointDisplay = e.value;
					gestureObject.visualizer.pointDisplay = e.value;
					break;
				case "web":
					touchObject.visualizer.cluster.drawWeb = e.value;
					gestureObject.visualizer.cluster.drawWeb = e.value;
					break;
				case "box":
					touchObject.visualizer.cluster.drawBox = e.value;
					gestureObject.visualizer.cluster.drawBox = e.value;
					break;
				case "rotation":
					if (currentTab == "cluster") {
						touchObject.visualizer.cluster.drawRotation = e.value;
						gestureObject.visualizer.cluster.drawRotation = e.value;
					}
					else if (currentTab == "gesture")
						gestureObject.visualizer.gesture.drawRotation = e.value;
					break;
				case "radius":
					touchObject.visualizer.cluster.drawRadius = e.value;
					gestureObject.visualizer.cluster.drawRadius = e.value;
					break;
				case "center":
					touchObject.visualizer.cluster.drawCenter = e.value;
					gestureObject.visualizer.cluster.drawCenter = e.value;
					break;
				case "bisector":
					touchObject.visualizer.cluster.drawBisector = e.value;
					gestureObject.visualizer.cluster.drawBisector = e.value;
					break;	
					
					
				// gesture
				case "cluster":
					gestureObject.visualizer.clusterDisplay = e.value;
					break;				
				case "orientation":
					gestureObject.visualizer.gesture.drawOrientation = e.value;
					break;				
				case "transformation":
					gestureObject.visualizer.gesture.drawTransformation = e.value;
					break;				
				case "pivot":
					gestureObject.visualizer.gesture.drawPivot = e.value;
					break;	
				case "stroke":
					gestureObject.visualizer.gesture.drawStroke = e.value;
					break;	
				case "gesture":
					gestureObject.visualizer.gesture.drawGesture = e.value;
					break;						
			}					
		}

		private function onEnterFrame(e:Event):void
		{
			if (contains(away3DScene)) 
				away3DScene.update();
			if (currentTab == "point")
				updatePointData();
			else if (currentTab == "cluster")
				updateClusterData();				
			else if (currentTab == "gesture")
				updateGestureData();
			rateText.text = String(frameRate.tick());				
		}
	
		private function onDataTabContainer(e:StateEvent):void
		{
			switch (e.value) {
				case 0: 
					if (currentDataTab != "touch") 
						showDataTab("touch"); break;
				case 1: 
					if (currentDataTab != "motion") 
						showDataTab("motion"); break; 	
				case 2: 
					if (currentDataTab != "sub") 
						showDataTab("sub"); break; 						
			}
		}
		
		private function showDataTab(tabName:String):void
		{
			switch (tabName) {			
				case "touch": 
					dataTabTouch.addChild(dataTabContainer); break;
				case "motion":
					dataTabMotion.addChild(dataTabContainer); break;
				case "sub":
					dataTabSubCluster.addChild(dataTabContainer); break;
			}
			currentDataTab = tabName;	
			StateManager.loadState(currentTab + "-" + currentDataTab);
			loadDataColumns(currentTab);
		}		
		
		private function onTabContainer(e:StateEvent):void
		{	
			if (e.target != tabs) return;
			
			switch (e.value) {
				case 0: 
					if (currentTab != "mode") 
						showTab("mode"); break;
				case 1: 
					if (currentTab != "point") 
						showTab("point"); break; 
				case 2: 
					if (currentTab != "cluster") 
						showTab("cluster"); break;	
				case 3: 
					if (currentTab != "gesture") 
						showTab("gesture"); break;					
			}
		}
		
		private function onTouchBegin(e:GWTouchEvent):void 
		{
			updatePointCnt();
		}
				
		private function onTouchEnd(e:*):void 
		{		
			updatePointCnt();
		}		
		
		private function onGesture(e:GWGestureEvent):void
		{
			gestureEventArray.unshift ( e );			
						
			if (gestureEventArray.length == 15)
				gestureEventArray.pop();
		}		
		
		private function onGestureBtns(e:StateEvent):void
		{
			gList[e.id] = e.value; 
			updateGestures();
		}
		
		
		
		///////////////////////////////////////////
		/////////// update methods ////////////////
		///////////////////////////////////////////					
		
		
		private function add3DScene():void
		{
			away3DScene.addView(currentTab, motion);
			addChildAt(away3DScene, away3DSceneIndex);
			showTab(currentTab);
		}		
		
		private function remove3DScene():void
		{
			away3DScene.removeView();
			removeChild(away3DScene);
		}
		
		private function add2DScene():void
		{
			addChildAt(touchObject, touchObjectIndex);						
			addChildAt(gestureObject, gestureObjectIndex);
			showTab(currentTab);
		}
		
		private function remove2DScene():void
		{
			removeChild(touchObject);
			removeChild(gestureObject);
		}			
		
		private function showTab(tabName:String):void
		{
			var i:int;
			var j:int;
			
			for each (var item:Toggle in toggle) 
				StateUtils.saveStateById(item, item.stateId);
			
			switch (tabName) {			
				case "mode": 
					break;
				
				case "point":
					if (currentView == "2D") {
						gestureObject.visible = false;											
					}					
					else {
						away3DScene.updateView(tabName, motion);
					}
					touchObject.visible = true;	
					touchObject.visualizer.pointDisplay = true;
					touchObject.visualizer.clusterDisplay = false;										
					touchObject.visualizer.gestureDisplay = false;						
					pointTab.addChild(pointContainer);	
					pointContainer.addChild(viewg);
					pointContainer.addChild(data);
					dataTabContainer.addChild(dataGraph);
				
					StateUtils.loadState(data, 0);
					StateUtils.loadState(dataGraph, 0);	
					StateUtils.loadState(dataContainer, 0);	
					dataTabSubCluster.loadStateById(tabName);

					loadState2(tabName);
						
					for (i = 1; i < dataNumCols.length; i++) {
						StateUtils.loadState(dataNumCols[i], 0);	
					}	
					for (i = 0; i < dataNumbers.length; i++) {
						dataNumbers[i].visible = true;	
					}
					for (i = 1; i < dataNumCols.length; i+=2) {
						for (j = 0; j < dataNumCols[i].childList.length; j++)
							dataNumCols[i].childList[j].font = "OpenSansRegular";			
					}		
					graphPaths.childList[0].visible = false;	
					break;
				
	
				case "cluster":
										
					if (currentView == "2D") {					
						touchObject.visualizer.pointDisplay = true;
						touchObject.visualizer.clusterDisplay = true;										
						touchObject.visualizer.gestureDisplay = false;					
						gestureObject.visible = false;
					}
					else {
						away3DScene.updateView(tabName, motion);
					}	
					
					clusterTab.addChild(pointContainer);					
					pointContainer.addChild(viewg);
					pointContainer.addChild(data);
					dataTabContainer.addChild(dataGraph);
					
					loadDataColumns(tabName);
					
					graphPaths.childList[0].visible = true;	
					break;		
				
					
				case "gesture":
					if (currentView == "2D") {	
						StateUtils.loadState(gestureObject, 0);	
						gestureObject.visible = true;
						gestureObject.visualizer.gestureDisplay = true;							
					}
					else {
						away3DScene.updateView(tabName, motion);
					}
					StateUtils.loadState(data, 0);					
					StateUtils.loadState(dataGraph, 1);						
					loadState2(tabName);	
					gestureFeedbackPanel.addChild(dataGraph);
					gestureView.addChild(viewg);
					break;					
			}
			currentTab = tabName;		
			StateManager.loadState(currentTab + "-" + currentDataTab);
		}
		
		private function loadDataColumns(tabName:String):void
		{
			if (tabName != "cluster") {
				return;
			}
			
			var i:int;
			var j:int;
			
			if (currentDataTab == "touch" || currentDataTab == "motion") {
				StateUtils.loadState(data, 1);
				StateUtils.loadState(dataGraph, 0);
				StateUtils.loadState(dataContainer, 1);
				
				dataTabSubCluster.loadStateById(tabName);
				loadState2(tabName);	
				
				for (i = 0; i < dataNumCols.length; i++) {
					dataNumCols[i].visible = true;
					if (i != 0) StateUtils.loadState(dataNumCols[i], 1);
				}	
				for (i = 0; i < dataNumbers.length; i++) {
					dataNumbers[i].visible = false;	
				}						
				for (i = 1; i < dataNumCols.length; i+=2) {
					for (j = 0; j < dataNumCols[i].childList.length; j++)
						dataNumCols[i].childList[j].font = "OpenSansBold";			
				}				
				
				dataNumCols[0].childList[0].visible = true;	
				dataNumCols[0].childList[1].visible = true;	
				dataNumCols[0].childList[2].visible = true;		
				
				dataNumCols[0].childList[3].visible = true;	
				dataNumCols[1].childList[3].visible = true;	
				dataNumCols[2].childList[3].visible = true;	
				dataNumCols[3].childList[3].visible = true;	
				
				dataNumCols[0].childList[4].visible = true;	
				dataNumCols[1].childList[4].visible = true;
				dataNumCols[2].childList[4].visible = true;
				dataNumCols[3].childList[4].visible = true;
				
				dataNumCols[0].childList[5].visible = true;
				dataNumCols[1].childList[5].visible = true;
				dataNumCols[2].childList[5].visible = true;
				dataNumCols[3].childList[5].visible = true;
				
				dataNumCols[0].childList[6].visible = true;
				dataNumCols[1].childList[6].visible = true;
				dataNumCols[2].childList[6].visible = true;
				dataNumCols[3].childList[6].visible = true;
				
				dataNumCols[0].childList[7].visible = true;
				dataNumCols[1].childList[7].visible = true;
				dataNumCols[2].childList[7].visible = true;
				dataNumCols[3].childList[7].visible = true;				
			}
			else { // SUB data tab
				StateUtils.loadState(data, 1);
				StateUtils.loadState(dataGraph, 0);
				StateUtils.loadState(dataContainer, 0);
				
				dataTabSubCluster.loadStateById(tabName);

				loadState2(tabName);
					
				for (i = 1; i < dataNumCols.length; i++) {
					StateUtils.loadState(dataNumCols[i], 0);	
				}	
				for (i = 0; i < dataNumbers.length; i++) {
					dataNumbers[i].visible = true;	
				}
				for (i = 1; i < dataNumCols.length; i+=2) {
					for (j = 0; j < dataNumCols[i].childList.length; j++) {
						dataNumCols[i].childList[j].font = "OpenSansRegular";
					}
				}						
			}			
			
		}
		
		private function loadState2(state:String):void 
		{
			var txt:Text;
			var tog:Toggle;
			for each (txt in panelText)
				StateUtils.loadStateById(txt, state);
			for each(tog in toggle)
				StateUtils.loadStateById(tog, state);
			
			StateUtils.loadStateById(viewg, state);
		}
				
		private function updatePointCnt(e:*=null):void
		{
			tpntsText.text = String(gestureObject.pointArray.length + touchObject.pointArray.length);			
		}
		
		private function updatePointData():void
		{
			var i:int;
			var j:int;	
			var ptArrayLength:int;
			var historyLength:int;
						
			switch (currentDataTab) {			
				case "touch": 		
					ptArrayLength = (touchObject.pointArray.length <= 10) ? touchObject.pointArray.length : 10;
					
					for (i = 0; i < ptArrayLength; i++) {
						dataNumCols[i].childList[0].text = String(touchObject.pointArray[i].id);		
						dataNumCols[i].childList[1].text = String(int(touchObject.pointArray[i].x));
						dataNumCols[i].childList[2].text = String(int(touchObject.pointArray[i].y));
						dataNumCols[i].childList[3].text = String(int(touchObject.pointArray[i].dx));
						dataNumCols[i].childList[4].text = String(int(touchObject.pointArray[i].dy));
						dataNumCols[i].childList[5].text = String(int(touchObject.pointArray[i].DX));
						dataNumCols[i].childList[6].text = String(int(touchObject.pointArray[i].DY));
						dataNumCols[i].childList[7].text = String(int(touchObject.pointArray[i].w));	
						dataNumCols[i].childList[8].text = String(int(touchObject.pointArray[i].h));		
						
						pointGraphHistory = touchObject.pointArray[i].history;				
						historyLength = touchObject.pointArray[i].history.length;
						
						graphCoords.length = 0;
						
						for (j = 0; j < historyLength; j++) {
							graphCoords.push( j * graphPaths.childList[i].width / (captureLength - 1), pointGraphHistory[j].dx / 2 );		
						}
						for (j = historyLength; j < captureLength; j++) {
							graphCoords.push( j * graphPaths.childList[i].width / (captureLength - 1), 0 );
						}			
						
						graphPaths.childList[i].pathCoordinatesVector = graphCoords;					
						graphPaths.childList[i].updateGraphic();
	
						graphPaths.childList[i].visible = true;						
						dataNumCols[i].visible = true;
					}
					// clear unused points
					for (ptArrayLength; i < 10; i++) {
						graphPaths.childList[i].visible = false;
						dataNumCols[i].visible = false;
					}					
				break;	
				
				case "motion":	
					ptArrayLength = (gestureObject3D.cO.motionArray.length <= 10) ? gestureObject3D.cO.motionArray.length : 10;
															
					for (i = 0; i < ptArrayLength; i++) {						
						dataNumCols[i].childList[0].text = String(gestureObject3D.cO.motionArray[i].id);		
						dataNumCols[i].childList[1].text = String(gestureObject3D.cO.motionArray[i].handID);
						dataNumCols[i].childList[2].text = String(gestureObject3D.cO.motionArray[i].type).substr(0, 4);
						dataNumCols[i].childList[3].text = String(int(gestureObject3D.cO.motionArray[i].position.x));
						dataNumCols[i].childList[4].text = String(int(gestureObject3D.cO.motionArray[i].position.y));
						dataNumCols[i].childList[5].text = String(int(gestureObject3D.cO.motionArray[i].position.z));
						dataNumCols[i].childList[6].text = String(int(gestureObject3D.cO.motionArray[i].direction.x));
						dataNumCols[i].childList[7].text = String(int(gestureObject3D.cO.motionArray[i].direction.y));	
						dataNumCols[i].childList[8].text = String(int(gestureObject3D.cO.motionArray[i].direction.z));						
						dataNumCols[i].childList[9].text = String(int(gestureObject3D.cO.motionArray[i].velocity.x));
						dataNumCols[i].childList[10].text = String(int(gestureObject3D.cO.motionArray[i].velocity.y));
						dataNumCols[i].childList[11].text = String(int(gestureObject3D.cO.motionArray[i].velocity.z));
																		
						iPointGraphHistory = gestureObject3D.cO.motionArray[i].history;				
						historyLength = gestureObject3D.cO.motionArray[i].history.length;
						
						graphCoords.length = 0;
						
						for (j = 0; j < historyLength; j++) {
							graphCoords.push( j * graphPaths.childList[i].width / (captureLength - 1), iPointGraphHistory[j].position.x / 2 );		
						}
						for (j = historyLength; j < captureLength; j++) {
							graphCoords.push( j * graphPaths.childList[i].width / (captureLength - 1), 0 );
						}			
						
						graphPaths.childList[i].pathCoordinatesVector = graphCoords;					
						graphPaths.childList[i].updateGraphic();
					
						graphPaths.childList[i].visible = true;
						dataNumCols[i].visible = true;
					}
					// clear unused points
					for (ptArrayLength; i < 10; i++) {
						graphPaths.childList[i].visible = false;
						dataNumCols[i].visible = false;
					}
					
				break;	
					
			}		
		}
		
		private function updateClusterData():void
		{
			switch (currentDataTab) {			
				case "touch": 
					//columns  	//rows
					dataNumCols[0].childList[0].text = String(touchObject.cO.id);	
					dataNumCols[0].childList[1].text = String(touchObject.cO.n);
					dataNumCols[0].childList[2].text = String(touchObject.cO.radius.toFixed(2));			
					
					dataNumCols[0].childList[3].text = "-";		
					dataNumCols[1].childList[3].text = "(x) " + String(touchObject.cO.x.toFixed(2));
					dataNumCols[2].childList[3].text = "(y) " + String(touchObject.cO.y.toFixed(2));
					dataNumCols[3].childList[3].text = "(z) " + String(touchObject.cO.z.toFixed(2));
					
					dataNumCols[0].childList[4].text = "-";			
					dataNumCols[1].childList[4].text = "(x) " + String(touchObject.cO.dx.toFixed(2));
					dataNumCols[2].childList[4].text = "(y) " + String(touchObject.cO.dy.toFixed(2));
					dataNumCols[3].childList[4].text = "(z) " + String(touchObject.cO.dz.toFixed(2));
					
					dataNumCols[0].childList[5].text = String(touchObject.cO.ds.toFixed(2));
					dataNumCols[1].childList[5].text = "(x) " + String(touchObject.cO.dsx.toFixed(2));
					dataNumCols[2].childList[5].text = "(y) " + String(touchObject.cO.dsy.toFixed(2));
					dataNumCols[3].childList[5].text = "(z) " + String(touchObject.cO.dsz.toFixed(2));
					
					dataNumCols[0].childList[6].text = String(touchObject.cO.rotation.toFixed(2));
					dataNumCols[1].childList[6].text = "(x) " + String(touchObject.cO.rotationX.toFixed(2));
					dataNumCols[2].childList[6].text = "(y) " + String(touchObject.cO.rotationY.toFixed(2));
					dataNumCols[3].childList[6].text = "(z) " + String(touchObject.cO.rotationZ.toFixed(2));
					
					dataNumCols[0].childList[7].text = String(touchObject.cO.separation.toFixed(2));
					dataNumCols[1].childList[7].text = "(x) " + String(touchObject.cO.separationX.toFixed(2));
					dataNumCols[2].childList[7].text = "(y) " + String(touchObject.cO.separationY.toFixed(2));
					dataNumCols[3].childList[7].text = "(z) " + String(touchObject.cO.separationZ.toFixed(2));
					
					var j:int;			
					var historyLength:int = touchObject.cO.history.length;
					
					graphCoords.length = 0;
					
					for (j = 0; j < historyLength; j++) {
						graphCoords.push( j * graphPaths.childList[0].width / (captureLength - 1), touchObject.cO.history[j].dx / 2 );		
					}
					for (j = historyLength; j < captureLength; j++) {
						graphCoords.push( j * graphPaths.childList[0].width / (captureLength - 1), 0 );
					}			
					graphPaths.childList[0].pathCoordinatesVector = graphCoords;					
					graphPaths.childList[0].updateGraphic();	
					
				break;
				
				case "motion":
					//columns  	//rows
					dataNumCols[0].childList[0].text = String(gestureObject3D.cO.id);	
					dataNumCols[0].childList[1].text = String(gestureObject3D.cO.n);
					dataNumCols[0].childList[2].text = String(gestureObject3D.cO.radius.toFixed(2));			
					
					dataNumCols[0].childList[3].text = "-";		
					dataNumCols[1].childList[3].text = "(x) " + String(gestureObject3D.cO.x.toFixed(2));
					dataNumCols[2].childList[3].text = "(y) " + String(gestureObject3D.cO.y.toFixed(2));
					dataNumCols[3].childList[3].text = "(z) " + String(gestureObject3D.cO.z.toFixed(2));
					
					dataNumCols[0].childList[4].text = "-";			
					dataNumCols[1].childList[4].text = "(x) " + String(gestureObject3D.cO.dx.toFixed(2));
					dataNumCols[2].childList[4].text = "(y) " + String(gestureObject3D.cO.dy.toFixed(2));
					dataNumCols[3].childList[4].text = "(z) " + String(gestureObject3D.cO.dz.toFixed(2));
					
					dataNumCols[0].childList[5].text = String(gestureObject3D.cO.ds.toFixed(2));
					dataNumCols[1].childList[5].text = "(x) " + String(gestureObject3D.cO.dsx.toFixed(2));
					dataNumCols[2].childList[5].text = "(y) " + String(gestureObject3D.cO.dsy.toFixed(2));
					dataNumCols[3].childList[5].text = "(z) " + String(gestureObject3D.cO.dsz.toFixed(2));
					
					dataNumCols[0].childList[6].text = String(gestureObject3D.cO.rotation.toFixed(2));
					dataNumCols[1].childList[6].text = "(x) " + String(gestureObject3D.cO.rotationX.toFixed(2));
					dataNumCols[2].childList[6].text = "(y) " + String(gestureObject3D.cO.rotationY.toFixed(2));
					dataNumCols[3].childList[6].text = "(z) " + String(gestureObject3D.cO.rotationZ.toFixed(2));
					
					dataNumCols[0].childList[7].text = String(gestureObject3D.cO.separation.toFixed(2));
					dataNumCols[1].childList[7].text = "(x) " + String(gestureObject3D.cO.separationX.toFixed(2));
					dataNumCols[2].childList[7].text = "(y) " + String(gestureObject3D.cO.separationY.toFixed(2));
					dataNumCols[3].childList[7].text = "(z) " + String(gestureObject3D.cO.separationZ.toFixed(2));	
					
					var j:int;			
					
					var historyLength:int = gestureObject3D.cO.history.length;
					
					graphCoords.length = 0;
					
					for (j = 0; j < historyLength; j++) {
						graphCoords.push( j * graphPaths.childList[0].width / (captureLength - 1), gestureObject3D.cO.history[j].dx / 2 );		
					}
					for (j = historyLength; j < captureLength; j++) {
						graphCoords.push( j * graphPaths.childList[0].width / (captureLength - 1), 0 );
					}			
					graphPaths.childList[0].pathCoordinatesVector = graphCoords;					
					graphPaths.childList[0].updateGraphic();
					
				break;
				
				
				case "sub": 		
					trace("update sub cluster data");
					var subClusterArrayLength:int = (gestureObject3D.cO.subClusterArray.length <= 10) ? gestureObject3D.cO.subClusterArray.length : 10;
					var ipCluster:ipClusterObject;
					var i:int;
					
					for (i = 0; i < subClusterArrayLength; i++) {	
						
						ipCluster = gestureObject3D.cO.subClusterArray[i];
						
						dataNumCols[i].childList[0].text = String(ipCluster.id);		
						dataNumCols[i].childList[1].text = String(ipCluster.radius);
						dataNumCols[i].childList[2].text = String(ipCluster.x);
						dataNumCols[i].childList[3].text = String(ipCluster.y);
						dataNumCols[i].childList[4].text = String(ipCluster.z);
						dataNumCols[i].childList[5].text = String(ipCluster.dx);
						dataNumCols[i].childList[6].text = String(ipCluster.dy);
						dataNumCols[i].childList[7].text = String(ipCluster.dz);
						dataNumCols[i].childList[8].text = String(ipCluster.separationX);					
						dataNumCols[i].childList[9].text = String(ipCluster.separationY);	
						dataNumCols[i].childList[10].text = String(ipCluster.separationZ);	
						dataNumCols[i].childList[11].text = "0";
																		
						//iPointGraphHistory = gestureObject3D.cO.motionArray[i].history;				
						//historyLength = gestureObject3D.cO.motionArray[i].history.length;
						
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
						
						dataNumCols[i].visible = true;
					}
					// clear unused points
					for (subClusterArrayLength; i < 10; i++) {
						graphPaths.childList[i].visible = false;
						dataNumCols[i].visible = false;
					}
				break;				
			}			
			
		}
				
		private function updateGestureData():void
		{
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
						graphCoords.push( j * graphPaths.childList[0].width / (captureLength - 1), gestureHistory[i].value.drag_dx / 2 );
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
			
		private function updateGestures():void
		{			
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

	}
}