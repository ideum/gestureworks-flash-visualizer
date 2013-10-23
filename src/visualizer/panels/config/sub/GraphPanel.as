package visualizer.panels.config.sub {
	/**
	 * ...
	 * @author 
	 */
	public class GraphPanel {
		
		public function GraphPanel() {
			
		}
		
		private function setupGraph():void {
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
		
	}

}