package 
{
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.controllers.HoverController;
	import away3d.entities.Mesh;
	import away3d.lights.PointLight;
	import away3d.materials.ColorMaterial;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.primitives.CubeGeometry;
	import away3d.primitives.PlaneGeometry;
	import com.gestureworks.away3d.Away3DTouchVisualizer;
	import com.gestureworks.cml.components.*;
	import com.gestureworks.cml.core.*;
	import com.gestureworks.cml.element.*;
	import com.gestureworks.cml.events.*;
	import com.gestureworks.cml.managers.*;
	import com.gestureworks.cml.utils.*;
	import com.gestureworks.core.*;
	import com.gestureworks.events.*;
	import flash.display.DisplayObjectContainer;
	import flash.events.*;
	import flash.utils.*;
	//import com.gestureworks.core.GestureWorksAIR; GestureWorksAIR;	
	
	import GestureWorksVisualizer; GestureWorksVisualizer;
	import Away3DScene; Away3DScene;
	
	public class test extends GestureWorks
	{
		public function test() 
		{
			super();
			fullscreen = true;
			auto = true;
			GestureGlobals.pointHistoryCaptureLength = 60;
			GestureGlobals.clusterHistoryCaptureLength = 60;
			GestureGlobals.timelineHistoryCaptureLength = 60;			
		}
		
		override protected function gestureworksInit():void
 		{
			trace("gestureWorksInit()");				
			
			var view:View3D = new View3D;
			var scene:Scene3D = view.scene;
			view.width = GestureWorks.application.stageWidth;
			view.height = GestureWorks.application.stageHeight;
			view.backgroundColor = 0x000000;			
			view.antiAlias = 4;
			view.camera.lens.far = 15000;
			addChild(view);
			
			var cameraController:HoverController = new HoverController(view.camera, null, 0, 0, -400)
			cameraController.yFactor = 1;
			
			var lightPicker:StaticLightPicker = new StaticLightPicker( [] );
			var light:PointLight = new PointLight(); 
			light.specular = .7;
			lightPicker.lights = [ light ];
			scene.addChild(light);
			
			var axis:Away3DTrident = new Away3DTrident(120, true, lightPicker);
			scene.addChild(axis);				
			
			var material:ColorMaterial = new ColorMaterial(0x555555); 
			material.lightPicker = lightPicker;
						
			var viz:Away3DTouchVisualizer = new Away3DTouchVisualizer(view, stage, lightPicker);
			scene.addChild(viz);
			
			addEventListener(Event.ENTER_FRAME, update);
			
			function update(e:Event=null):void 
			{
				viz.update();
				light.position = view.camera.position;
				view.render();					
			}				
		}
			
	}
}