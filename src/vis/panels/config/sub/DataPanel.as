package vis.panels.config.sub {
	import com.gestureworks.cml.element.Container;
	import com.gestureworks.cml.element.Graphic;
	import com.gestureworks.cml.element.Tab;
	import com.gestureworks.cml.element.TabbedContainer;
	import com.gestureworks.cml.element.Text;
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
		
		public static var data:Graphic;		
		public static var dataTabSubCluster:Tab;
		public static var dataTabMotion:Tab;
		public static var dataTabTouch:Tab;
		public static var dataPanel:Graphic;
		public static var dataGraph:Graphic;
		public static var dataTabContainer:Container;
		public static var dataTabs:TabbedContainer; 
		public static var dataContainer:Container;
		public static var dataText:Array;
		public static var dataNumCols:Array;		
		public static var dataNumbers:Array;
		
		private static var gestureObject:TouchSprite;
		private static var gestureObject3D:TouchSprite;
		private static var touchObject:TouchSprite;
		private static var panelText:Array;
		
		public function DataPanel() {}
		
		
		public static function setup():void {
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
			dataTabs.addEventListener(StateEvent.CHANGE, onDataTabContainer);
			dataTabs.selectTabByIndex(0);	
			touchObject = GWVisualizer.interactive2D;
			gestureObject = GWVisualizer.gestureObject2D;
			//gestureObject3D = GWVisualizer.gestureObject3D;	
			panelText = document.getElementsByClassName("panel-text");						
			
			setupDataNumbers();
			
			dataTabs.addEventListener(StateEvent.CHANGE, onDataTabContainer);	
		}
		
		private static function setupDataNumbers():void {
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
		
		
		public static function loadPoint():void {
			StateUtils.loadState(data, 0); 
			StateUtils.loadState(dataGraph, 0);	
			StateUtils.loadState(dataContainer, 0);	
			dataTabSubCluster.loadStateById("point");			
			dataTabContainer.addChild(dataGraph);
			loadDataColumns("point");
			
			var i:int;
			var j:int
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
		}
		
		public static function loadCluster():void {
			dataTabContainer.addChild(dataGraph);
			loadDataColumns("cluster");			
		}
	
		
		public static function loadGesture():void {
			StateUtils.loadState(data, 0);					
			StateUtils.loadState(dataGraph, 1);									
		}
		
		
		private static function loadDataColumns(tabName:String):void {
			if (tabName != "cluster") {
				return;
			}
			
			var i:int;
			var j:int;
			
			if (GWVisualizer.currentDataTab == "touch" || GWVisualizer.currentDataTab == "motion") {
				StateUtils.loadState(data, 1);
				StateUtils.loadState(dataGraph, 0); 
				StateUtils.loadState(dataContainer, 1);
				
				dataTabSubCluster.loadStateById(tabName);
				
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

				var txt:Text;
				for each (txt in panelText)
					StateUtils.loadStateById(txt, "cluster");
				
				//StateUtils.loadStateById(viewg, "cluster");
					
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
				
		private static function onDataTabContainer(e:StateEvent):void
		{
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
		
		private static function showDataTab(tabName:String):void
		{
			switch (tabName) {			
				case "touch": 
					dataTabTouch.addChild(dataTabContainer); break;
				case "motion":
					dataTabMotion.addChild(dataTabContainer); break;
				case "sub":
					dataTabSubCluster.addChild(dataTabContainer); break;
			}
			GWVisualizer.currentDataTab = tabName;	
			StateManager.loadState(GWVisualizer.currentTab + "-" + GWVisualizer.currentDataTab);
			loadDataColumns(GWVisualizer.currentTab);
		}
		
		
		/////////////
		// point
		//////////////
		
		public static function updatePointTouch():void {
			var ptArrayLength:int = (touchObject.pointArray.length <= 10) ? touchObject.pointArray.length : 10;
			
			var i:int;
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
		
		public static function updatePointMotion():void {
			var ptArrayLength:int  = (gestureObject3D.cO.motionArray.length <= 10) ? gestureObject3D.cO.motionArray.length : 10;
			
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
		
		public static function updateClusterTouch():void {
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
		
		public static function updateClusterMotion():void {
			//columns  	//rows
			dataNumCols[0].childList[0].text = String(gestureObject.cO.id);	
			dataNumCols[0].childList[1].text = String(gestureObject.cO.n);
			dataNumCols[0].childList[2].text = String(gestureObject.cO.radius.toFixed(2));			
			
			dataNumCols[0].childList[3].text = "-";		
			dataNumCols[1].childList[3].text = "(x) " + String(gestureObject.cO.x.toFixed(2));
			dataNumCols[2].childList[3].text = "(y) " + String(gestureObject.cO.y.toFixed(2));
			dataNumCols[3].childList[3].text = "(z) " + String(gestureObject.cO.z.toFixed(2));
			
			dataNumCols[0].childList[4].text = "-";			
			dataNumCols[1].childList[4].text = "(x) " + String(gestureObject.cO.dx.toFixed(2));
			dataNumCols[2].childList[4].text = "(y) " + String(gestureObject.cO.dy.toFixed(2));
			dataNumCols[3].childList[4].text = "(z) " + String(gestureObject.cO.dz.toFixed(2));
			
			dataNumCols[0].childList[5].text = String(gestureObject.cO.ds.toFixed(2));
			dataNumCols[1].childList[5].text = "(x) " + String(gestureObject.cO.dsx.toFixed(2));
			dataNumCols[2].childList[5].text = "(y) " + String(gestureObject.cO.dsy.toFixed(2));
			dataNumCols[3].childList[5].text = "(z) " + String(gestureObject.cO.dsz.toFixed(2));
			
			dataNumCols[0].childList[6].text = String(gestureObject.cO.rotation.toFixed(2));
			dataNumCols[1].childList[6].text = "(x) " + String(gestureObject.cO.rotationX.toFixed(2));
			dataNumCols[2].childList[6].text = "(y) " + String(gestureObject.cO.rotationY.toFixed(2));
			dataNumCols[3].childList[6].text = "(z) " + String(gestureObject.cO.rotationZ.toFixed(2));
			
			dataNumCols[0].childList[7].text = String(gestureObject.cO.separation.toFixed(2));
			dataNumCols[1].childList[7].text = "(x) " + String(gestureObject.cO.separationX.toFixed(2));
			dataNumCols[2].childList[7].text = "(y) " + String(gestureObject.cO.separationY.toFixed(2));
			dataNumCols[3].childList[7].text = "(z) " + String(gestureObject.cO.separationZ.toFixed(2));	

								
		}
		
		public static function updateSubClusterMotion():void {
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