package visualizer.panels.config.sub {
	/**
	 * ...
	 * @author 
	 */
	public class DataPanel {
		
		public function DataPanel() {
			// data
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
			
			dataTabs.selectTabByIndex(0);	
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
		
		
		private function loadDataColumns(tabName:String):void {
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
				
		
	}

}