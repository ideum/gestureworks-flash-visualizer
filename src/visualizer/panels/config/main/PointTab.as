package visualizer.panels.config.main {
	import com.gestureworks.cml.element.Tab;
	import com.gestureworks.cml.element.TouchContainer;
	import visualizer.scenes.Interactive3D;
	/**
	 * ...
	 * @author 
	 */
	public class PointTab extends Tab {
		
		private var touchObject:TouchContainer;
		private var gestureObject:TouchContainer
		private var interactive3D:Interactive3D;
		
		public function PointTab() {
			super();
		}
		
		// update
		public function show():void {
			if (currentView == "2D") {
				gestureObject.visible = false;											
			}					
			else {
				display3D.updateView(tabName, motion);
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
		}
		
		private function updatePointData():void {
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
				
	}

}