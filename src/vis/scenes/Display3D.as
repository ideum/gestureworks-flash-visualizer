package vis.scenes {
	import away3d.containers.*;
	import away3d.controllers.*;
	import away3d.core.math.*;
	import away3d.debug.*;
	import away3d.entities.*;
	import away3d.lights.*;
	import away3d.materials.*;
	import away3d.materials.lightpickers.*;
	import away3d.primitives.*;
	import com.gestureworks.away3d.*;
	import com.gestureworks.cml.element.*;
	import com.gestureworks.core.*;
	import com.gestureworks.events.*;
	import flash.display.*;
	import flash.events.*;
	import vis.scenes.elements.*;
	import com.gestureworks.away3d.TouchManager3D;
	import com.gestureworks.away3d.TouchObject3D;
	import com.gestureworks.away3d.utils.MotionVisualizer3D;
	
	public class Display3D extends TouchContainer {
		
		protected var view3D:View3D;
		protected var scene:Scene3D;
		protected var camera:HoverController;
		protected var cube:Mesh;
		
		private var lightPicker:StaticLightPicker;
		private var light:PointLight;
		private var material:ColorMaterial;
		private var axis:Axis3D;		
		
		private var currentTab:String;
		
		protected var gestureObject:TouchObject3D;
		protected var touchManager3D:TouchManager3D;
		protected var motionVizualizer:MotionVisualizer3D;		
		
		public function Display3D():void {
			mouseChildren = true;
		}
		
		override public function init():void {			
			
			// Away3D Scene
			view3D = new View3D();
			scene = view3D.scene;

			view3D.width = GestureWorks.application.stageWidth;
			view3D.height = GestureWorks.application.stageHeight;
			view3D.backgroundColor = 0x000000;			
			view3D.antiAlias = 4;
			view3D.camera.lens.far = 15000;
			addChild(view3D);
			
			camera = new HoverController(view3D.camera, null, 0, 0, -400)
			camera.yFactor = 1;
			
			lightPicker = new StaticLightPicker( [] );
			light = new PointLight();
			light.specular = .7;
			lightPicker.lights = [ light ];
			scene.addChild(light);
			
			axis = new Axis3D(120, true, lightPicker);
			axis.mouseEnabled = false;
			scene.addChild(axis);				
			
			material = new ColorMaterial(0x555555);
			material.lightPicker = lightPicker;

			cube = new Mesh(new CubeGeometry(), material);
			cube.mouseEnabled = true;
			scene.addChild(cube);
			
			
			// GestureWorks Visualization
			motionVizualizer = new MotionVisualizer3D();
			motionVizualizer.lightPicker = lightPicker;
			scene.addChild(motionVizualizer);				
		}
	
		public function update():void {		
			motionVizualizer.updateDisplay();
			light.position = view3D.camera.position;
			view3D.render();					
		}	
	}
}