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
		public var motionEnabled:Boolean = true;
		
		private const WIDTH:Number = 1920;
		private const HEIGHT:Number = 1080;
		private var ts:Away3DTouchObject;
		private var view:View3D;
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
		private var axis:Trident;
		private var currentTab:String;
		private var scene:Scene3D;
		
		public function Away3DScene():void 
		{
			mouseChildren = true;
		}
		
		override public function init():void 
		{			
			view = new View3D();
			scene = view.scene;

			view.backgroundColor = 0x000000;
			//view.width = WIDTH * GestureWorks.application.stageWidth / 1920;
			//view.height = HEIGHT * GestureWorks.application.stageWidth / 1920;
			//view.height = HEIGHT * GestureWorks.application.stageHeight / 1080;
			//view.x = 12 * view.width/WIDTH;
			//view.y = 60 * view.width/HEIGHT;			
			
			view.width = GestureWorks.application.stageWidth;
			view.height = GestureWorks.application.stageHeight;
			view.antiAlias = 4;
			view.camera.lens.far = 15000;
			view.forceMouseMove = true;
			addChild(view);
			
			cameraController = new HoverController(view.camera, null, 0, 0, -400)
			cameraController.yFactor = 1;
			
			lightPicker = new StaticLightPicker( [] );
			light = new PointLight();
			light.specular = .7;
			lightPicker.lights = [ light ];
			scene.addChild(light);
			
			axis = new Trident(120);
			scene.addChild(axis);				
			
			material = new ColorMaterial(0x555555);
			material.lightPicker = lightPicker;

			cube = new Mesh(new CubeGeometry(), material);
			cube.mouseEnabled = true;
			scene.addChild(cube);

			away = new Away3DTouchManager(view);
			ts = away.registerTouchObject(cube);
			ts.activated = true;

			ts.gestureList = { "n-drag":true, "n-rotate":true, "n-scale":true, "n-drag-inertia":true, "n-3d-transform-finger":true };
			ts.nativeTransform = true;
			ts.gestureReleaseInertia = true;
			ts.gestureEvents = true;
			ts.motion3d = false; //input			
			ts.transform3d = true; //output
			ts.debugDisplay = true;
				
			vis3d = new Away3DMotionVisualizer();
			vis3d.init();
			vis3d.cO = ts.cO;
			vis3d.trO = ts.trO;
			scene.addChild(vis3d);	
		}
	
		
		public function addView(tab:String, motion:Boolean=false):void
		{
			scene.addChild(axis);				
			
			switch (tab) {
				case "point":
					break;
				case "cluster": 
					break;
				case "gesture": 
					scene.addChild(cube);	
					if (motion) 
						scene.addChild(vis3d);
					break;
			}
			
			addChild(view);	
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
			view.render();
		}		
		
		public function removeView():void
		{
			cameraController.tiltAngle = 0;
			if (scene.contains(axis)) scene.removeChild(axis);			
			if (scene.contains(cube)) scene.removeChild(cube);
			if (scene.contains(vis3d)) scene.removeChild(vis3d);
			view.render();
			if (contains(view)) removeChild(view);
		}
				
		public function update():void 
		{		
			vis3d.updateDisplay();
			light.position = view.camera.position;
			light.lookAt(cube.transform.position);
			view.render();			
		}

	}
}