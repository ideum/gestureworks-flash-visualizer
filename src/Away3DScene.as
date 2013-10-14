package 
{
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
	import com.gestureworks.cml.element.TouchContainer;
	import com.gestureworks.core.*;
	import com.gestureworks.events.*;
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.ui.*;
			
	public class Away3DScene extends TouchContainer
	{
		public var motionEnabled:Boolean = true; // temporary - motion and touch should work simultaneously
		public var gestureObject:Away3DTouchObject;
		
		private const WIDTH:Number = 1920;
		private const HEIGHT:Number = 1080;
		private var view3D:View3D;
		private var lightPicker:StaticLightPicker;
		private var cameraController:HoverController;
		private var light:PointLight;
		private var cube:Mesh;
		private var material:ColorMaterial;
		private var newX:Number = 0;
		private var newY:Number = 0;		
		private var vis3d:Away3DMotionVisualizer;
		private var away:Away3DTouchManager;
		private var plane:Mesh;
		private var seg:SegmentSet;		
		private var axis:Away3DTrident;
		private var currentTab:String;
		private var scene:Scene3D;
		
		public function Away3DScene():void 
		{
			mouseChildren = true;
		}
		
		override public function init():void 
		{			
			view3D = new View3D();
			scene = view3D.scene;

			view3D.width = GestureWorks.application.stageWidth;
			view3D.height = GestureWorks.application.stageHeight;
			view3D.backgroundColor = 0x000000;			
			view3D.antiAlias = 4;
			view3D.camera.lens.far = 15000;
			view3D.forceMouseMove = true;
			addChild(view3D);
			
			cameraController = new HoverController(view3D.camera, null, 0, 0, -400)
			cameraController.yFactor = 1;
			
			lightPicker = new StaticLightPicker( [] );
			light = new PointLight();
			light.specular = .7;
			lightPicker.lights = [ light ];
			scene.addChild(light);
			
			axis = new Away3DTrident(120, true, lightPicker);
			scene.addChild(axis);				
			
			material = new ColorMaterial(0x555555);
			material.lightPicker = lightPicker;

			cube = new Mesh(new CubeGeometry(), material);
			cube.mouseEnabled = true;
			scene.addChild(cube);

			Away3DTouchManager.initialize();
			gestureObject = Away3DTouchManager.registerTouchObject(cube);
			gestureObject.active = true;
			gestureObject.gestureList = { "n-drag":true, "n-rotate":true, "n-scale":true, "n-drag-inertia":true, "n-3d-transform-finger":true };
			gestureObject.nativeTransform = true;
			gestureObject.gestureReleaseInertia = true;
			gestureObject.gestureEvents = true;
			gestureObject.motion3d = motionEnabled; //input			
			gestureObject.transform3d = true; //output
			gestureObject.debugDisplay = true;
			
			vis3d = new Away3DMotionVisualizer();
			vis3d.lightPicker = lightPicker;
			vis3d.init();
			vis3d.cO = gestureObject.cO;
			vis3d.trO = gestureObject.trO;
			scene.addChild(vis3d);	
		}
	
		
		
		public function addView(tab:String, motion:Boolean=false):void
		{
			scene.addChild(axis);				
			
			switch (tab) {
				case "point":
					if (motion) {
						vis3d.drawPoints = true;
						vis3d.drawClusters = false;
						vis3d.drawGestures = false;
						scene.addChild(vis3d);
					}
					break;
				case "cluster": 
					if (motion) {
						vis3d.drawClusters = true;
						vis3d.drawGestures = false;						
						scene.addChild(vis3d);
					}
					break;
				case "gesture": 
					scene.addChild(cube);	
					if (motion) {
						vis3d.drawGestures = true;
						scene.addChild(vis3d);
					}
					break;
			}
			
			addChild(view3D);	
			cameraController.tiltAngle = -45;				
			currentTab = tab;			
		}		
		
		public function updateView(tab:String, motion:Boolean=false):void
		{			
			switch (tab) {
				case "point":
					if (scene.contains(cube)) scene.removeChild(cube);					
					break;
				case "cluster": 
					if (scene.contains(cube)) scene.removeChild(cube);
					break;
				case "gesture": 
					scene.addChild(cube);	
					if (motion) scene.addChild(vis3d);
					break;
			}
			
			currentTab = tab;
			view3D.render();
		}		
		
		public function removeView():void
		{
			cameraController.tiltAngle = 0;
			if (scene.contains(axis)) scene.removeChild(axis);			
			if (scene.contains(cube)) scene.removeChild(cube);
			if (scene.contains(vis3d)) scene.removeChild(vis3d);
			view3D.render();
			if (contains(view3D)) removeChild(view3D);
		}
				
		public function update():void 
		{		
			vis3d.updateDisplay();
			light.position = view3D.camera.position;
			view3D.render();					
		}

	}
}