package visualizer.scenes {
	import com.gestureworks.core.TouchSprite;
	
	/**
	 * ...
	 * @author 
	 */
	public class Settings {
			
		public static function setupVisualizer(ts0:TouchSprite):void {		
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
		
	}

}