package vis.panels.config.sub {
	import com.gestureworks.cml.elements.Container;
	import com.gestureworks.cml.elements.Graphic;
	import com.gestureworks.cml.elements.Tab;
	import com.gestureworks.cml.elements.TabbedContainer;
	import com.gestureworks.cml.elements.Text;
	import com.gestureworks.cml.events.StateEvent;
	import com.gestureworks.cml.managers.StateManager;
	import com.gestureworks.cml.utils.document;
	import com.gestureworks.cml.utils.StateUtils;
	import com.gestureworks.core.TouchSprite;
	import com.gestureworks.objects.ipClusterObject;
	import flash.utils.Dictionary;
	import vis.GWVisualizer;
	/**
	 * ...
	 * @author 
	 */
	public class DataPanel {
		
		public var data:Graphic;		
		public var dataTabSubCluster:Tab;
		public var dataTabMotion:Tab;
		public var dataTabTouch:Tab;
		public var dataPanel:Graphic;
		public var dataGraph:Graphic;
		public var dataTabContainer:Container;
		public var dataTabs:TabbedContainer; 
		public var dataContainer:Container;
		public var dataText:Array;
		public var dataNumCols:Array;		
		public var dataNumbers:Array;

		private var panelText:Array;
		
		private var touchObject:TouchSprite;		
		private var gestureObject:TouchSprite;
		private var gestureObject3D:TouchSprite;
		
		private var currentTab:String = "point";
		
		public function DataPanel() {}
		
		public function setup():void {
			data = document.getElementById("data");
			dataContainer = document.getElementById("data-c");
			dataNumbers = document.getElementsByClassName("data-num");
			dataText = document.getElementsByClassName("data-txt");
			dataTabSubCluster = document.getElementById("data-tab-sub-cluster");
			dataTabMotion = document.getElementById("data-tab-motion");
			dataTabTouch = document.getElementById("data-tab-touch");
			dataTabContainer = document.getElementById("data-tab-sub");			
			dataPanel = document.getElementById("data-panel");
			dataGraph = document.getElementById("data-graph");
			dataTabs = document.getElementById("data-tabs");
			dataNumCols = document.getElementsByClassName("data-num-c");
			dataTabs.selectTabByIndex(0);	
			
			touchObject = GWVisualizer.interactive2D;
			gestureObject = GWVisualizer.gestureObject2D;
			gestureObject3D = GWVisualizer.gestureObject3D;
			
			panelText = document.getElementsByClassName("panel-text");						
			
			setupDataNumbers();
			dataTabs.addEventListener(StateEvent.CHANGE, onDataTabContainer);			
		}
		
		private function setupDataNumbers():void {
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
		
		
		// update
		
		
		public function loadPoint():void {
			currentTab = "point";
			StateUtils.loadState(data, 0); 
			StateUtils.loadState(dataGraph, 0);	
			StateUtils.loadState(dataContainer, 0);	
			dataTabSubCluster.loadState("point");			
			dataTabContainer.addChild(dataGraph);
			loadDataColumns(currentTab);
			
			var i:int;
			var j:int;
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
			
			if (GWVisualizer.currentDataTab == "touch") {
				dataNumbers[11].visible = false;
			}
			else {
				dataNumbers[11].visible = true;
			}			
		}
		
		public function loadCluster():void {
			currentTab = "cluster";			
			dataTabContainer.addChild(dataGraph);
			loadDataColumns(currentTab);			
		}
	
		
		public function loadGesture():void {
			currentTab = "gesture";	
			StateUtils.loadState(data, 0);					
			StateUtils.loadState(dataGraph, 1);									
		}
		
		
		private function loadDataColumns(tabName:String):void {
			if (tabName != "cluster") {
				return;
			}
			
			var i:int;
			var j:int;
			
			if (GWVisualizer.currentDataTab == "touch" || GWVisualizer.currentDataTab == "motion") {
				StateUtils.loadState(data, 1);
				StateUtils.loadState(dataGraph, 0); 
				StateUtils.loadState(dataContainer, 1);
				
				dataTabSubCluster.loadState(tabName);
				
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
				
				dataTabSubCluster.loadState(tabName);

				var txt:Text;
				for each (txt in panelText)
					StateUtils.loadState(txt, "cluster");
									
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
				
		private function onDataTabContainer(e:StateEvent):void
		{
			if (e.target != dataTabs)
				return;
			switch (e.value) {
				case 0: 
					if (GWVisualizer.currentDataTab != "touch") 
						showDataTab("touch"); break;
				case 1: 
					if (GWVisualizer.currentDataTab != "motion") 
						showDataTab("motion"); break; 	
				case 2: 
					if (GWVisualizer.currentDataTab != "sub") 
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
			loadDataColumns(currentTab);			
			StateManager.loadState(currentTab + "-" + tabName);
			GWVisualizer.currentDataTab = tabName;				
		}
		
		
		/////////////
		// point
		//////////////
		
		public function updatePointTouch():void {
			var ptArrayLength:int = (touchObject.pointArray.length <= 10) ? touchObject.pointArray.length : 10;
			
			var i:int;
			
			// all but the last one
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
				dataNumCols[i].visible = true;				
			}
			// clear unused points
			for (ptArrayLength; i < 10; i++) {
				dataNumCols[i].visible = false;
			}				
		}
		
		public function updatePointMotion():void {
			var ptArrayLength:int = (gestureObject3D.cO.motionArray.length <= 10) ? gestureObject3D.cO.motionArray.length : 10;
			
			var i:int;
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
				dataNumCols[i].visible = true;
			}
			// clear unused points
			for (ptArrayLength; i < 10; i++) {
				dataNumCols[i].visible = false;
			}			
		}
		
		
		/////////////
		// cluster
		//////////////
		
		public function updateClusterTouch():void {
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
		}
		
		public function updateClusterMotion():void {
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
		}
		
		public function updateSubClusterMotion():void {
			var subClusterArrayLength:int = (gestureObject.cO.subClusterArray.length <= 10) ? gestureObject.cO.subClusterArray.length : 10;
			var ipCluster:ipClusterObject;
			var i:int;
								
			for (i = 0; i < subClusterArrayLength; i++) {	
				ipCluster = gestureObject.cO.subClusterArray[i];
				
				dataNumCols[i].childList[0].text = String(ipCluster.id);		
				dataNumCols[i].childList[1].text = (ipCluster.count).toFixed(2);
				dataNumCols[i].childList[2].text = (ipCluster.radius).toFixed(2);
				dataNumCols[i].childList[3].text = (ipCluster.x).toFixed(2);
				dataNumCols[i].childList[4].text = (ipCluster.y).toFixed(2);
				dataNumCols[i].childList[5].text = (ipCluster.z).toFixed(2);
				dataNumCols[i].childList[6].text = (ipCluster.dx).toFixed(2);
				dataNumCols[i].childList[7].text = (ipCluster.dy).toFixed(2);
				dataNumCols[i].childList[8].text = (ipCluster.dz).toFixed(2);
				dataNumCols[i].childList[9].text = (ipCluster.separationX).toFixed(2);					
				dataNumCols[i].childList[10].text = (ipCluster.separationY).toFixed(2);	
				dataNumCols[i].childList[11].text = (ipCluster.separationZ).toFixed(2);	
				
				dataNumCols[i].visible = true;
			}			
			
			for (subClusterArrayLength; i < 10; i++) {
				dataNumCols[i].visible = false;
			}			
		}
		
	}

}