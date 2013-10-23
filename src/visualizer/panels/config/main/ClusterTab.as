package visualizer.panels.config.main {
	import com.gestureworks.cml.element.Tab;
	import com.gestureworks.cml.element.TouchContainer;
	import visualizer.scenes.Interactive3D;
	/**
	 * ...
	 * @author 
	 */
	public class ClusterTab extends Tab { 
		
		public var touchObject2D:TouchContainer;
		public var gestureObject2D:TouchContainer;
		public var interactive3D:Interactive3D;
		
		public function ClusterTab() {
			super();
		}
		
		// update
		public function show():void {							
			if (currentView == "2D") {					
				touchObject.visualizer.pointDisplay = true;
				touchObject.visualizer.clusterDisplay = true;										
				touchObject.visualizer.gestureDisplay = false;					
				gestureObject.visible = false;
			}
			else {
				interactive3D.updateView(tabName, motion);
			}	
			
			clusterTab.addChild(pointContainer);					
			pointContainer.addChild(viewg);
			pointContainer.addChild(data);
			dataTabContainer.addChild(dataGraph);
			
			loadDataColumns(tabName);
			
			graphPaths.childList[0].visible = true;				
		}
		
		private function updateClusterData():void {
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
					//trace("update sub cluster data");
					var subClusterArrayLength:int = (gestureObject3D.cO.subClusterArray.length <= 10) ? gestureObject3D.cO.subClusterArray.length : 10;
					var ipCluster:ipClusterObject;
					var i:int;
										
					for (i = 0; i < subClusterArrayLength; i++) {	
						ipCluster = gestureObject3D.cO.subClusterArray[i];
						
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
					for (subClusterArrayLength; i < 10; i++) {
						graphPaths.childList[i].visible = false;
						dataNumCols[i].visible = false;
					}
				break;				
			}
		}		
		
	}

}