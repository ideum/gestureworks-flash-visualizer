<?xml version="1.0" encoding="UTF-8"?>
<GestureMarkupLanguage xmlns:gml="http://gestureworks.com/gml/version/1.0">

		<Gesture_set gesture_set_name="3d-motion-gestures">	
					
					<Gesture id="3dmotion-n-all-3dtranslate" type="drag">
							<match>
								<action>
									<initial>
										<cluster type="all" input_type="motion" point_number="0" point_number_min="1" point_number_max="10" />
										<hand type="all" orientation="down" splay="" flatness="1" hand_number="0" finger_number="0" radius=""/>
											<hand type="left" orientation="down" splay="" flatness="" finger_number="2" radius="">
												<finger type="thumb" extension="" width="" length=""/>
												<finger type="index" extension="" width="" length=""/>
												<tool type="pen" width="50" length="150"/>
											</hand>
											<hand type="right" orientation="down" splay="" flatness="" finger_number="5">
												<finger type="thumb" extension="" width="" length=""/>
												<finger type="index" extension="" width="" length=""/>
												<finger type="middle" extension="" width="" length=""/>
												<finger type="ring" extension="" width="" length=""/>
												<finger type="pinky" extension="" width="" length=""/>
											</hand>
									</initial>
								</action>
							</match>	
							<analysis>
								<algorithm class="3d_kinemetric" type="continuous">
									<library module="3d_translate"/>
									<returns>
										<property id="dx" result="dx"/>
										<property id="dy" result="dy"/>
										<property id="dz" result="dz"/>
									</returns>
								</algorithm>
							</analysis>	
							<mapping>
								<update dispatch_type="continuous">
									<gesture_event type="drag">
										<property ref="dx" target="x"/>
										<property ref="dy" target="y"/>
										<property ref="dz" target="z"/>
									</gesture_event>
								</update>
							</mapping>
					</Gesture>
			
		</Gesture_set>			
				
		
		
		<Gesture_set gesture_set_name="3d-pinch-gestures">	
		
					<Gesture id="3dmotion-1-pinch-3dtranslate-test" type="drag">
							<match>
								<action>
									<initial>
										<cluster type="pinch" input_type="motion" point_number="1" point_number_min="1" point_number_max="1"/>
									</initial>
								</action>
							</match>	
							<analysis>
								<algorithm class="3d_kinemetric" type="continuous">
									<library module="3d_translate"/>
									<returns>
										<property id="dx" result="dx"/>
										<property id="dy" result="dy"/>
										<property id="dz" result="dz"/>
									</returns>
								</algorithm>
							</analysis>	
							<mapping>
								<update dispatch_type="continuous">
									<gesture_event type="motion_drag">
										<property ref="dx" target="x"/>
										<property ref="dy" target="y"/>
										<property ref="dz" target="z"/>
									</gesture_event>
								</update>
							</mapping>
					</Gesture>
		
		
					<Gesture id="3dmotion-n-pinch-3dtranslate" type="motion_drag">
							<match>
								<action>
									<initial>
										<cluster type="pinch" input_type="motion" point_number="1" point_number_min="1" point_number_max="1" />
											<hand type="left" orientation="down" splay="" flatness="" finger_number="2">
												<finger type="thumb" extension=""/>
												<finger type="index"/>
											</hand>
											<hand type="" finger_number ="5"/>
									</initial>
								</action>
							</match>	
							<analysis>
								<algorithm class="3d_kinemetric" type="continuous">
									<library module="3d_translate"/>
									<returns>
										<property id="dx" result="dx"/>
										<property id="dy" result="dy"/>
										<property id="dz" result="dz"/>
									</returns>
								</algorithm>
							</analysis>	
							<mapping>
								<update dispatch_type="continuous">
									<gesture_event type="motion_drag">
										<property ref="dx" target="x"/>
										<property ref="dy" target="y"/>
										<property ref="dz" target="z"/>
									</gesture_event>
								</update>
							</mapping>
					</Gesture>
					
					<Gesture id="3dmotion-1-pinch-3dtranslate" type="drag">
							<match>
								<action>
									<initial>
										<cluster type="pinch" input_type="motion" point_number="1" point_number_min="1" point_number_max="1"/>
									</initial>
								</action>
							</match>	
							<analysis>
								<algorithm class="3d_kinemetric" type="continuous">
									<library module="3d_translate"/>
									<returns>
										<property id="dx" result="dx"/>
										<property id="dy" result="dy"/>
										<property id="dz" result="dz"/>
									</returns>
								</algorithm>
							</analysis>	
							<mapping>
								<update dispatch_type="continuous">
									<gesture_event type="motion_drag">
										<property ref="dx" target="x"/>
										<property ref="dy" target="y"/>
										<property ref="dz" target="z"/>
									</gesture_event>
								</update>
							</mapping>
					</Gesture>
					
					
					
					<Gesture id="3dmotion-n-pinch-3dtransform" type="3d_manipulate">
							<match>
								<action>
									<initial>
										<cluster type="pinch" input_type="motion" point_number="0" point_number_min="1" point_number_max="10"/>
									</initial>
								</action>
							</match>	
							<analysis>
								<algorithm class="3d_kinemetric" type="continuous">
									<library module="3d_manipulate"/>
									<returns>
										<property id="dx" result="dx"/>
										<property id="dy" result="dy"/>
										<property id="dz" result="dz"/>
										<property id="dsx" result="dsx"/>
										<property id="dsy" result="dsy"/>
										<property id="dsz" result="dsz"/>
										<property id="dtheta" result="dtheta"/>
										<property id="dthetaX" result="dthetaX"/>
										<property id="dthetaY" result="dthetaY"/>
										<property id="dthetaZ" result="dthetaZ"/>
									</returns>
								</algorithm>
							</analysis>	
							<mapping>
								<update dispatch_type="continuous">
									<gesture_event type="3d_manipulate">
										<property ref="dx" target="x"/>
										<property ref="dy" target="y"/>
										<property ref="dz" target="z"/>
										<property ref="dsx" target="scaleX"/>
										<property ref="dsy" target="scaleY"/>
										<property ref="dsz" target="scaleZ"/>
										<property ref="dtheta" target="rotation"/>
										<property ref="dthetaX" target="rotationX"/>
										<property ref="dthetaY" target="rotationY"/>
										<property ref="dthetaZ" target="rotationZ"/>
									</gesture_event>
								</update>
							</mapping>
					</Gesture>
					
					
					<Gesture id="3dmotion-2-pinch-2dtransform" type="motion_manipulate">
							<match>
								<action>
									<initial>
										<cluster type="pinch" input_type="motion" point_number="1" point_number_min="1" point_number_max="10"/>
									</initial>
								</action>
							</match>	
							<analysis>
								<algorithm class="3d_kinemetric" type="continuous">
									<library module="3d_translate"/>
									<returns>
										<property id="dx" result="dx"/>
										<property id="dy" result="dy"/>
										<property id="dsx" result="dsx"/>
										<property id="dsy" result="dsy"/>
										<property id="dtheta" result="dtheta"/>
									</returns>
								</algorithm>
							</analysis>	
							<mapping>
								<update dispatch_type="continuous">
									<gesture_event type="motion_manipulate">
										<property ref="dx" target="x"/>
										<property ref="dy" target="y"/>
										<property ref="dsx" target="scaleX"/>
										<property ref="dsy" target="scaleY"/>
										<property ref="dtheta" target="rotation"/>
									</gesture_event>
								</update>
							</mapping>
					</Gesture>
					
					
					<Gesture id="3dmotion-n-bimanual-pinch-3dtranslate" type="drag">
							<match>
								<action>
									<initial>
										<cluster type="hand" hand_number="1" finger_number="5" point_number="0" point_number_min="1" point_number_max="10"/>
									</initial>
								</action>
							</match>	
							<analysis>
								<algorithm class="3d_kinemetric" global_metric="pinch" type="continuous">
									<library module="3d_translate"/>
									<returns>
										<property id="dx" result="dx"/>
										<property id="dy" result="dy"/>
										<property id="dz" result="dz"/>
									</returns>
								</algorithm>
							</analysis>	
							<mapping>
								<update dispatch_type="continuous">
									<gesture_event type="drag">
										<property ref="dx" target="x"/>
										<property ref="dy" target="y"/>
										<property ref="dz" target="z"/>
									</gesture_event>
								</update>
							</mapping>
					</Gesture>
					
					<Gesture id="n-3d-bimanual-pinch-translate" type="drag">
							<match>
								<action>
									<initial>
										<cluster type="hand" hand_number="1" finger_number="5" point_number="0" point_number_min="1" point_number_max="10"/>
									</initial>
								</action>
							</match>	
							<analysis>
								<algorithm class="3d_kinemetric" global_metric="pinch" type="continuous">
									<library module="3d_translate"/>
									<returns>
										<property id="dx" result="x"/>
										<property id="dy" result="y"/>
										<property id="dz" result="z"/>
									</returns>
								</algorithm>
							</analysis>	
							<mapping>
								<update dispatch_type="continuous">
									<gesture_event type="motion_drag">
										<property ref="dx" target="x"/>
										<property ref="dy" target="y"/>
										<property ref="dz" target="z"/>
									</gesture_event>
								</update>
							</mapping>
					</Gesture>
					
					<Gesture id="3dmotion-1-pinch-hold" type="hold">
							<match>
								<action>
									<initial>
										<cluster type="pinch" input_type="motion" point_number="1" point_number_min="1" point_number_max="10"/>
									</initial>
								</action>
							</match>	
							<analysis>
								<algorithm class="3d_kinemetric" type="continuous">
									<library module="3d_hold"/>
									<returns>
										<property id="x" result="x"/>
										<property id="y" result="y"/>
										<property id="z" result="z"/>
									</returns>
								</algorithm>
							</analysis>	
							<mapping>
								<update dispatch_type="continuous">
									<gesture_event type="motion_hold">
										<property ref="x" target=""/>
										<property ref="y" target=""/>
										<property ref="z" target=""/>
									</gesture_event>
								</update>
							</mapping>
					</Gesture>
					
					<Gesture id="3dmotion-1-pinch-tap" type="tap">
							<match>
								<action>
									<initial>
										<cluster type="pinch" input_type="motion" point_number="1" point_number_min="1" point_number_max="10"/>
									</initial>
								</action>
							</match>	
							<analysis>
								<algorithm class="3d_kinemetric" type="continuous">
									<library module="3d_tap"/>
									<returns>
										<property id="x" result="x"/>
										<property id="y" result="y"/>
										<property id="z" result="z"/>
									</returns>
								</algorithm>
							</analysis>	
							<mapping>
								<update dispatch_type="continuous">
									<gesture_event type="motion_tap">
										<property ref="x" target="x"/>
										<property ref="y" target="y"/>
										<property ref="z" target="z"/>
									</gesture_event>
								</update>
							</mapping>
					</Gesture>
					
			</Gesture_set>
					
					
					
		
			<Gesture_set gesture_set_name="3d-trigger-gestures">		
					
					<Gesture id="3dmotion-n-trigger-3dtransform" type="motion_manipulate">
							<match>
								<action>
									<initial>
										<cluster type="trigger" input_type="motion" point_number="0" point_number_min="1" point_number_max="10"/>
									</initial>
								</action>
							</match>	
							<analysis>
								<algorithm class="3d_kinemetric" type="continuous">
									<library module="3d_manipulate"/>
									<returns>
										<property id="dx" result="dx"/>
										<property id="dy" result="dy"/>
										<property id="dz" result="dz"/>
										<property id="dsx" result="dsx"/>
										<property id="dsy" result="dsy"/>
										<property id="dsz" result="dsz"/>
										<property id="dtheta" result="dtheta"/>
										<property id="dthetaX" result="dthetaX"/>
										<property id="dthetaY" result="dthetaY"/>
										<property id="dthetaZ" result="dthetaZ"/>
									</returns>
								</algorithm>
							</analysis>	
							<mapping>
								<update dispatch_type="continuous">
									<gesture_event type="motion_manipulate">
										<property ref="dx" target="x"/>
										<property ref="dy" target="y"/>
										<property ref="dz" target="z"/>
										<property ref="dsx" target="scaleX"/>
										<property ref="dsy" target="scaleY"/>
										<property ref="dsz" target="scaleZ"/>
										<property ref="dtheta" target="rotation"/>
										<property ref="dthetaX" target="rotationX"/>
										<property ref="dthetaY" target="rotationY"/>
										<property ref="dthetaZ" target="rotationZ"/>
									</gesture_event>
								</update>
							</mapping>
					</Gesture>
					
					<Gesture id="3dmotion-n-trigger-3dtranslate" type="drag">
							<match>
								<action>
									<initial>
										<cluster type="trigger" input_type="motion" point_number="0" point_number_min="1" point_number_max="10"/>
									</initial>
								</action>
							</match>	
							<analysis>
								<algorithm class="3d_kinemetric" type="continuous">
									<library module="3d_translate"/>
									<returns>
										<property id="dx" result="dx"/>
										<property id="dy" result="dy"/>
										<property id="dz" result="dz"/>
									</returns>
								</algorithm>
							</analysis>	
							<mapping>
								<update dispatch_type="continuous">
									<gesture_event type="motion_drag">
										<property ref="dx" target="x"/>
										<property ref="dy" target="y"/>
										<property ref="dz" target="z"/>
									</gesture_event>
								</update>
							</mapping>
					</Gesture>
					
					<Gesture id="3dmotion-1-trigger-3dtranslate" type="drag">
							<match>
								<action>
									<initial>
										<cluster type="trigger" input_type="motion" point_number="1" point_number_min="1" point_number_max="1"/>
									</initial>
								</action>
							</match>	
							<analysis>
								<algorithm class="3d_kinemetric" type="continuous">
									<library module="3d_translate"/>
									<returns>
										<property id="dx" result="dx"/>
										<property id="dy" result="dy"/>
										<property id="dz" result="dz"/>
									</returns>
								</algorithm>
							</analysis>	
							<mapping>
								<update dispatch_type="continuous">
									<gesture_event type="motion_drag">
										<property ref="dx" target="x"/>
										<property ref="dy" target="y"/>
										<property ref="dz" target="z"/>
									</gesture_event>
								</update>
							</mapping>
					</Gesture>
					
					
						
			</Gesture_set>
			
			<Gesture_set gesture_set_name="3d-finger-gestures">	
					
					<Gesture id="3dmotion-n-finger-3dtilt" type="3d_tilt">
							<match>
								<action>
									<initial>
										<cluster type="finger" input_type="motion" point_number="" point_number_min="1" point_number_max="5"/>
										<hand thumb="true" />
									</initial>
								</action>
							</match>	
							<analysis>
								<algorithm class="3d_kinemetric" type="continuous">
									<library module="3d_tilt"/>
									<returns>
										<property id="dtheta" result="dtheta"/>
										<property id="dthetaX" result="dthetaX"/>
										<property id="dthetaY" result="dthetaY"/>
										<property id="dthetaZ" result="dthetaZ"/>
									</returns>
								</algorithm>
							</analysis>	
							<mapping>
								<update dispatch_type="continuous">
									<gesture_event type="motion_tilt">
										<property ref="dtheta" target="rotation"/>
										<property ref="dthetaX" target="rotationX"/>
										<property ref="dthetaY" target="rotationY"/>
										<property ref="dthetaZ" target="rotationZ"/>
									</gesture_event>
								</update>
							</mapping>
					</Gesture>
					

					<Gesture id="3dmotion-n-finger-3dtransform" type="3d_manipulate">
							<match>
								<action>
									<initial>
										<cluster type="finger" input_type="motion" point_number="0" point_number_min="1" point_number_max="10"/>
									</initial>
								</action>
							</match>	
							<analysis>
								<algorithm class="3d_kinemetric" type="continuous">
									<library module="3d_manipulate"/>
									<returns>
										<property id="dx" result="dx"/>
										<property id="dy" result="dy"/>
										<property id="dz" result="dz"/>
										<property id="dsx" result="dsx"/>
										<property id="dsy" result="dsy"/>
										<property id="dsz" result="dsz"/>
										<property id="dtheta" result="dtheta"/>
										<property id="dthetaX" result="dthetaX"/>
										<property id="dthetaY" result="dthetaY"/>
										<property id="dthetaZ" result="dthetaZ"/>
									</returns>
								</algorithm>
							</analysis>	
							<mapping>
								<update dispatch_type="continuous">
									<gesture_event type="motion_manipulate">
										<property ref="dx" target="x"/>
										<property ref="dy" target="y"/>
										<property ref="dz" target="z"/>
										<property ref="dsx" target="scaleX"/>
										<property ref="dsy" target="scaleY"/>
										<property ref="dsz" target="scaleZ"/>
										<property ref="dtheta" target="rotation"/>
										<property ref="dthetaX" target="rotationX"/>
										<property ref="dthetaY" target="rotationY"/>
										<property ref="dthetaZ" target="rotationZ"/>
									</gesture_event>
								</update>
							</mapping>
					</Gesture>
					
					<Gesture id="3dmotion-n-finger-hold" type="motion_hold">
							<match>
								<action>
									<initial>
										<cluster type="finger" input_type="motion" point_number="0" point_number_min="1" point_number_max="10"/>
									</initial>
								</action>
							</match>	
							<analysis>
								<algorithm class="3d_kinemetric" type="continuous">
									<library module="3d_hold"/>
									<returns>
										<property id="x" result="d"/>
										<property id="y" result="d"/>
										<property id="z" result="d"/>
									</returns>
								</algorithm>
							</analysis>	
							<mapping>
								<update dispatch_type="continuous">
									<gesture_event type="motion_hold">
										<property ref="x" target="x"/>
										<property ref="y" target="y"/>
										<property ref="z" target="z"/>
									</gesture_event>
								</update>
							</mapping>
					</Gesture>
					
					<Gesture id="3dmotion-n-finger-tap" type="motion_tap">
							<match>
								<action>
									<initial>
										<cluster type="finger" input_type="motion" point_number="0" point_number_min="1" point_number_max="10"/>
									</initial>
								</action>
							</match>	
							<analysis>
								<algorithm class="3d_kinemetric" type="continuous">
									<library module="3d_tap"/>
									<returns>
										<property id="x" result="x"/>
										<property id="y" result="y"/>
										<property id="z" result="z"/>
									</returns>
								</algorithm>
							</analysis>	
							<mapping>
								<update dispatch_type="continuous">
									<gesture_event type="motion_tap">
										<property ref="x" target=""/>
										<property ref="y" target=""/>
										<property ref="z" target=""/>
									</gesture_event>
								</update>
							</mapping>
					</Gesture>
					
					
					<Gesture id="3dmotion-1-finger-3dtranslate" type="motion_drag">
							<match>
								<action>
									<initial>
										<cluster type="finger" input_type="motion" point_number="1" point_number_min="1" point_number_max="1"/>
									</initial>
								</action>
							</match>	
							<analysis>
								<algorithm class="3d_kinemetric" type="continuous">
									<library module="3d_translate"/>
									<returns>
										<property id="dx" result="dx"/>
										<property id="dy" result="dy"/>
										<property id="dz" result="dz"/>
									</returns>
								</algorithm>
							</analysis>	
							<mapping>
								<update dispatch_type="continuous">
									<gesture_event type="motion_drag">
										<property ref="dx" target="x"/>
										<property ref="dy" target="y"/>
										<property ref="dz" target="z"/>
									</gesture_event>
								</update>
							</mapping>
					</Gesture>
					
					<Gesture id="3dmotion-1-finger-tap" type="motion_tap">
							<match>
								<action>
									<initial>
										<cluster type="finger" input_type="motion" point_number="1" point_number_min="1" point_number_max="1"/>
									</initial>
								</action>
							</match>	
							<analysis>
								<algorithm class="3d_kinemetric" type="continuous">
									<library module="3d_tap"/>
									<returns>
										<property id="x" result="x"/>
										<property id="y" result="y"/>
										<property id="z" result="z"/>
									</returns>
								</algorithm>
							</analysis>	
							<mapping>
								<update dispatch_type="discrete">
									<gesture_event type="motion_tap">
										<property ref="x" target=""/>
										<property ref="y" target=""/>
										<property ref="z" target=""/>
									</gesture_event>
								</update>
							</mapping>
					</Gesture>
					
					<Gesture id="3dmotion-1-finger-hold" type="motion_hold">
							<match>
								<action>
									<initial>
										<cluster type="finger" input_type="motion" point_number="1" point_number_min="1" point_number_max="1"/>
									</initial>
								</action>
							</match>	
							<analysis>
								<algorithm class="3d_kinemetric" type="continuous">
									<library module="3d_hold"/>
									<returns>
										<property id="x" result="x"/>
										<property id="y" result="y"/>
										<property id="z" result="z"/>
									</returns>
								</algorithm>
							</analysis>	
							<mapping>
								<update dispatch_type="discrete">
									<gesture_event type="motion_hold">
										<property ref="x" target=""/>
										<property ref="y" target=""/>
										<property ref="z" target=""/>
									</gesture_event>
								</update>
							</mapping>
					</Gesture>
	
			</Gesture_set>
					
					
			<Gesture_set gesture_set_name="3d-palm-gestures">	
					
					<Gesture id="3dmotion-n-palm-3dtilt" type="motion_tilt">
							<match>
								<action>
									<initial>
										<cluster type="palm" input_type="motion" point_number="1"/>
										<hand handedness="" orientation="down" splay="" flatness="" finger_number="0"/>
									</initial>
								</action>
							</match>	
							<analysis>
								<algorithm class="3d_kinemetric" type="continuous">
									<library module="3d_tilt"/>
									<returns>
										<property id="dtheta" result="dtheta"/>
										<property id="dthetaX" result="dthetaX"/>
										<property id="dthetaY" result="dthetaY"/>
										<property id="dthetaZ" result="dthetaZ"/>
									</returns>
								</algorithm>
							</analysis>	
							<mapping>
								<update dispatch_type="continuous">
									<gesture_event type="3d_tilt">
										<property ref="dtheta" target="rotation"/>
										<property ref="dthetaX" target="rotationX"/>
										<property ref="dthetaY" target="rotationY"/>
										<property ref="dthetaZ" target="rotationZ"/>
									</gesture_event>
								</update>
							</mapping>
					</Gesture>
					
					<Gesture id="3dmotion-n-palm-3dtransform" type="3d_manipulate">
							<match>
								<action>
									<initial>
										<cluster type="palm" input_type="motion" point_number="0" point_number_min="1" point_number_max="10"/>
									</initial>
								</action>
							</match>	
							<analysis>
								<algorithm class="3d_kinemetric" type="continuous">
									<library module="3d_manipulate"/>
									<returns>
										<property id="dx" result="dx"/>
										<property id="dy" result="dy"/>
										<property id="dz" result="dz"/>
										<property id="dsx" result="dsx"/>
										<property id="dsy" result="dsy"/>
										<property id="dsz" result="dsz"/>
										<property id="dtheta" result="dtheta"/>
										<property id="dthetaX" result="dthetaX"/>
										<property id="dthetaY" result="dthetaY"/>
										<property id="dthetaZ" result="dthetaZ"/>
									</returns>
								</algorithm>
							</analysis>	
							<mapping>
								<update dispatch_type="continuous">
									<gesture_event type="3d_manipulate">
										<property ref="dx" target="x"/>
										<property ref="dy" target="y"/>
										<property ref="dz" target="z"/>
										<property ref="dsx" target="scaleX"/>
										<property ref="dsy" target="scaleY"/>
										<property ref="dsz" target="scaleZ"/>
										<property ref="dtheta" target="rotation"/>
										<property ref="dthetaX" target="rotationX"/>
										<property ref="dthetaY" target="rotationY"/>
										<property ref="dthetaZ" target="rotationZ"/>
									</gesture_event>
								</update>
							</mapping>
					</Gesture>
					
		</Gesture_set>
					
		
		<Gesture_set gesture_set_name="3d-frame-gestures">	
					
					<Gesture id="3dmotion-n-frame-3dtransform" type="3d_manipulate">
							<match>
								<action>
									<initial>
										<cluster type="frame" input_type="motion" point_number="0" point_number_min="1" point_number_max="10"/>
									</initial>
								</action>
							</match>	
							<analysis>
								<algorithm class="3d_kinemetric" type="continuous">
									<library module="3d_manipulate"/>
									<returns>
										<property id="dx" result="dx"/>
										<property id="dy" result="dy"/>
										<property id="dz" result="dz"/>
										<property id="dsx" result="dsx"/>
										<property id="dsy" result="dsy"/>
										<property id="dsz" result="dsz"/>
										<property id="dtheta" result="dtheta"/>
										<property id="dthetaX" result="dthetaX"/>
										<property id="dthetaY" result="dthetaY"/>
										<property id="dthetaZ" result="dthetaZ"/>
									</returns>
								</algorithm>
							</analysis>	
							<mapping>
								<update dispatch_type="continuous">
									<gesture_event type="3d_manipulate">
										<property ref="dx" target="x"/>
										<property ref="dy" target="y"/>
										<property ref="dz" target="z"/>
										<property ref="dsx" target="scaleX"/>
										<property ref="dsy" target="scaleY"/>
										<property ref="dsz" target="scaleZ"/>
										<property ref="dtheta" target="rotation"/>
										<property ref="dthetaX" target="rotationX"/>
										<property ref="dthetaY" target="rotationY"/>
										<property ref="dthetaZ" target="rotationZ"/>
									</gesture_event>
								</update>
							</mapping>
					</Gesture>
					
			</Gesture_set>		
					
			
			
			
			<Gesture_set gesture_set_name="3d-hook-gestures">	
					
					<Gesture id="3d-motion-n-hook-3dtransform" type="3d_manipulate">
							<match>
								<action>
									<initial>
										<cluster type="hook" input_type="motion" point_number="0" point_number_min="1" point_number_max="10"/>
									</initial>
								</action>
							</match>	
							<analysis>
								<algorithm class="3d_kinemetric" type="continuous">
									<library module="3d_manipulate"/>
									<returns>
										<property id="dx" result="dx"/>
										<property id="dy" result="dy"/>
										<property id="dz" result="dz"/>
										<property id="dsx" result="dsx"/>
										<property id="dsy" result="dsy"/>
										<property id="dsz" result="dsz"/>
										<property id="dtheta" result="dtheta"/>
										<property id="dthetaX" result="dthetaX"/>
										<property id="dthetaY" result="dthetaY"/>
										<property id="dthetaZ" result="dthetaZ"/>
									</returns>
								</algorithm>
							</analysis>	
							<mapping>
								<update dispatch_type="continuous">
									<gesture_event type="3d_manipulate">
										<property ref="dx" target="x"/>
										<property ref="dy" target="y"/>
										<property ref="dz" target="z"/>
										<property ref="dsx" target="scaleX"/>
										<property ref="dsy" target="scaleY"/>
										<property ref="dsz" target="scaleZ"/>
										<property ref="dtheta" target="rotation"/>
										<property ref="dthetaX" target="rotationX"/>
										<property ref="dthetaY" target="rotationY"/>
										<property ref="dthetaZ" target="rotationZ"/>
									</gesture_event>
								</update>
							</mapping>
					</Gesture>
					
			</Gesture_set>		
			
					
			<Gesture_set gesture_set_name="3d-thumb-gestures">
			
					<Gesture id="3dmotion-n-thumb-3dtransform" type="3d_manipulate">
							<match>
								<action>
									<initial>
										<cluster type="thumb" input_type="motion" point_number="0" point_number_min="1" point_number_max="10"/>
									</initial>
								</action>
							</match>	
							<analysis>
								<algorithm class="3d_kinemetric" type="continuous">
									<library module="3d_manipulate"/>
									<returns>
										<property id="dx" result="dx"/>
										<property id="dy" result="dy"/>
										<property id="dz" result="dz"/>
										<property id="dsx" result="dsx"/>
										<property id="dsy" result="dsy"/>
										<property id="dsz" result="dsz"/>
										<property id="dtheta" result="dtheta"/>
										<property id="dthetaX" result="dthetaX"/>
										<property id="dthetaY" result="dthetaY"/>
										<property id="dthetaZ" result="dthetaZ"/>
									</returns>
								</algorithm>
							</analysis>	
							<mapping>
								<update dispatch_type="continuous">
									<gesture_event type="motion_manipulate">
										<property ref="dx" target="x"/>
										<property ref="dy" target="y"/>
										<property ref="dz" target="z"/>
										<property ref="dsx" target="scaleX"/>
										<property ref="dsy" target="scaleY"/>
										<property ref="dsz" target="scaleZ"/>
										<property ref="dtheta" target="rotation"/>
										<property ref="dthetaX" target="rotationX"/>
										<property ref="dthetaY" target="rotationY"/>
										<property ref="dthetaZ" target="rotationZ"/>
									</gesture_event>
								</update>
							</mapping>
					</Gesture>
					
			</Gesture_set>
				
					
			<Gesture_set gesture_set_name="3d-digit-gestures">	
					
					<Gesture id="3dmotion-n-digit-tap" type="tap">
							<match>
								<action>
									<initial>
										<cluster type="digit" input_type="motion" point_number="0" point_number_min="1" point_number_max="10"/>
									</initial>
								</action>
							</match>	
							<analysis>
								<algorithm class="3d_kinemetric" type="continuous">
									<library module="3d_tap"/>
									<returns>
										<property id="x" result="x"/>
										<property id="y" result="y"/>
										<property id="z" result="z"/>
									</returns>
								</algorithm>
							</analysis>	
							<mapping>
								<update dispatch_type="continuous">
									<gesture_event type="motion_tap">
										<property ref="x" target=""/>
										<property ref="y" target=""/>
										<property ref="z" target=""/>
									</gesture_event>
								</update>
							</mapping>
					</Gesture>
					
				</Gesture_set>	
					
		

		
		
		<Gesture_set gesture_set_name="basic-core-touch-gestures">
				
					<comment>The 'basic-core-gestures' are the simple form of the classic roate scale and drag gestures commonly used to manipulate touch objects.</comment>
		
					<Gesture id="n-drag-inertia" type="drag">
						<comment>The 'n-drag' gesture can be activated by any number of touch points between 1 and 10. When a touch down is recognized on a touch object the position
						of the touch point is tracked. This change in the position of the touch point is mapped directly to the position of the touch object.</comment>
						<match>
							<action>
								<initial>
									<cluster type="point" input_type="touch" point_number="0" point_number_min="1" point_number_max="10"/>
								</initial>
							</action>
						</match>	
						<analysis>
							<algorithm class="kinemetric" type="continuous">
								<library module="drag"/>
								<returns>
									<property id="drag_dx" result="dx"/>
									<property id="drag_dy" result="dy"/>
								</returns>
							</algorithm>
						</analysis>
						<processing>
							<inertial_filter>
								<property ref="drag_dx" active="true" friction="0.9"/>
								<property ref="drag_dy" active="true" friction="0.9"/>
							</inertial_filter>
							<delta_filter>
								<property ref="drag_dx" active="true" delta_min="0.05" delta_max="500"/>
								<property ref="drag_dy" active="true" delta_min="0.05" delta_max="500"/>
							</delta_filter>
						</processing>
						<mapping>
							<update dispatch_type="continuous">
								<gesture_event type="drag">
									<property ref="drag_dx" target="x"/>
									<property ref="drag_dy" target="y"/>
								</gesture_event>
							</update>
						</mapping>
					</Gesture>
					
					<Gesture id="n-drag" type="drag">
						<match>
							<action>
								<initial>
									<cluster point_number="0" input_type="it_was_me" point_number_min="1" point_number_max="10"/>
								</initial>
							</action>
						</match>	
						<analysis>
							<algorithm class="kinemetric" type="continuous">
								<library module="drag"/>
								<returns>
									<property id="drag_dx" result="dx"/>
									<property id="drag_dy" result="dy"/>
								</returns>
							</algorithm>
						</analysis>	
						<mapping>
							<update dispatch_type="continuous">
								<gesture_event type="drag">
									<property ref="drag_dx" target="x"/>
									<property ref="drag_dy" target="y"/>
								</gesture_event>
							</update>
						</mapping>
					</Gesture>
					
					<Gesture id="n-drag-3d" type="drag">
						<match>
							<action>
								<initial>
									<cluster type="touch" point_number="0"  point_number_min="1" point_number_max="10"/>
								</initial>
							</action>
						</match>	
						<analysis>
							<algorithm class="kinemetric" type="continuous">
								<library module="drag"/>
								<returns>
									<property id="drag_dx" result="dx"/>
									<property id="drag_dy" result="dy"/>
									<property id="drag_dz" result="dz"/>
								</returns>
							</algorithm>
						</analysis>	
						<mapping>
							<update dispatch_type="continuous">
								<gesture_event type="drag">
									<property ref="drag_dx" target="x"/>
									<property ref="drag_dy" target="y"/>
									<property ref="drag_dz" target="z"/>
								</gesture_event>
							</update>
						</mapping>
					</Gesture>
					
					<Gesture id="n-rotate" type="rotate">
					<comment>The 'n-rotate' gesture can be activated by any number of touch points between 2 and 10. When two or more touch points are recognized on a touch object the relative orientation
						of the touch points are tracked and grouped into a cluster. This change in the orientation of the cluster is mapped directly to the rotation of the touch object.</comment>
					
						<match>
							<action>
								<initial>
									<cluster point_number="0" point_number_min="2" point_number_max="10"/>
								</initial>
							</action>
						</match>
						<analysis>
							<algorithm class="kinemetric" type="continuous">
								<library module="rotate"/>
								<returns>
									<property id="rotate_dtheta" result="dtheta"/>
								</returns>
							</algorithm>
						</analysis>	
						<mapping>
							<update dispatch_type="continuous">
								<gesture_event type="rotate">
									<property ref="rotate_dtheta" target="rotate"/>
								</gesture_event>
							</update>
						</mapping>
					</Gesture>
					
					<Gesture id="n-scale" type="scale">
					
						<comment>The 'n-scale' gesture can be activated by any number of touch points between 2 and 10. When two or more touch points are recognized on a touch object the relative separation
						of the touch points are tracked and grouped into a cluster. Changes in the separation of the cluster are mapped directly to the scale of the touch object.</comment>
						
						<match>
							<action>
								<initial>
									<cluster point_number="0" point_number_min="2" point_number_max="10"/>
								</initial>
							</action>
						</match>
						<analysis>
							<algorithm class="kinemetric" type="continuous">
								<library module="scale"/>
								<returns>
									<property id="scale_dsx" result="ds"/>
									<property id="scale_dsy" result="ds"/>
								</returns>
							</algorithm>
						</analysis>	
						<mapping>
							<update dispatch_type="continuous">
								<gesture_event type="scale">
									<property ref="scale_dsx" target="scaleX"/>
									<property ref="scale_dsy" target="scaleY"/>
								</gesture_event>
							</update>
						</mapping>
					</Gesture>
					
					<Gesture id="n-manipulate" type="manipulate">
							<match>
								<action>
									<initial>
										<cluster point_number="0" point_number_min="1" point_number_max="10"/>
									</initial>
								</action>
							</match>	
							<analysis>
								<algorithm class="kinemetric" type="continuous">
									<library module="manipulate"/>
									<returns>
										<property id="dx" result="dx"/>
										<property id="dy" result="dy"/>
										<property id="dsx" result="ds"/>
										<property id="dsy" result="ds"/>
										<property id="dtheta" result="dtheta"/>
									</returns>
								</algorithm>
							</analysis>	
							<mapping>
								<update dispatch_type="continuous">
									<gesture_event  type="manipulate">
										<property ref="dx" target="x"/>
										<property ref="dy" target="y"/>
										<property ref="dsx" target="scaleX"/>
										<property ref="dsy" target="scaleY"/>
										<property ref="dtheta" target="rotation"/>
									</gesture_event>
								</update>
							</mapping>
						</Gesture>
						
						
						<Gesture id="n-manipulate-inertia-boundary" type="manipulate">
							<match>
								<action>
									<initial>
										<cluster point_number="0" point_number_min="1" point_number_max="10"/>
									</initial>
								</action>
							</match>	
							<analysis>
								<algorithm class="kinemetric" type="continuous">
									<library module="manipulate"/>
									<returns>
										<property id="dx" result="dx"/>
										<property id="dy" result="dy"/>
										<property id="dsx" result="ds"/>
										<property id="dsy" result="ds"/>
										<property id="dtheta" result="dtheta"/>
									</returns>
								</algorithm>
							</analysis>	
							<processing>
								<inertial_filter>
									<property ref="dx" active="true" friction="0.9"/>
									<property ref="dy" active="true" friction="0.9"/>
									<property ref="dsx" active="true" friction="0.9"/>
									<property ref="dsy" active="true" friction="0.9"/>
									<property ref="dtheta" active="true" friction="0.9"/>
								</inertial_filter>
								<delta_filter>
									<property ref="dx" active="true" delta_min="0.0" delta_max="100"/>
									<property ref="dy" active="true" delta_min="0.0" delta_max="100"/>
									<property ref="dsx" active="true" delta_min="0.0" delta_max="0.2"/>
									<property ref="dsy" active="true" delta_min="0.0" delta_max="0.2"/>
									<property ref="dtheta" active="false"/>
								</delta_filter>
								<boundary_filter>
									<property ref="dx" active="true" boundary_min="200" boundary_max="1720"/>
									<property ref="dy" active="true" boundary_min="200" boundary_max="880"/>
									<property ref="dsx" active="true" boundary_min="0.8" boundary_max="2.5"/>
									<property ref="dsy" active="true" boundary_min="0.8" boundary_max="2.5"/>
									<property ref="dtheta" active="false"/>
								</boundary_filter>
							</processing>
							<mapping>
								<update dispatch_type="continuous">
									<gesture_event  type="manipulate">
										<property ref="dx" target="x"/>
										<property ref="dy" target="y"/>
										<property ref="dsx" target="scaleX"/>
										<property ref="dsy" target="scaleY"/>
										<property ref="dtheta" target="rotation"/>
									</gesture_event>
								</update>
							</mapping>
						</Gesture>
					
	</Gesture_set>
	
</GestureMarkupLanguage>
