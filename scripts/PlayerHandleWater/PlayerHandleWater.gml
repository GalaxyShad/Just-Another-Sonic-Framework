
function player_handle_bubbles() { 
	var _o_bubble = collision_detector.collision_object(objBigBubble, PlayerCollisionDetectorSensor.MainDefault);
	if (_o_bubble) {
		xsp = 0;
		ysp = 0;
		
		state.change_to("breathe");
		
		instance_destroy(_o_bubble);
		
		audio_play_sound(sndPlayerBreathe, 0, 0);
		
		player_underwater_regain_air();
	}
}


function player_handle_water() {
	var _water = instance_nearest(x, y, objWaterLevel);
	if (_water == noone) 
		return;
	
	var _is_entering = (y > _water.y)  && !physics.is_underwater();
	var _is_exiting  = (y <= _water.y)	&&  physics.is_underwater();
	
	if (_is_entering || _is_exiting) {
		if (_is_entering) {
			xsp /= 2;
			ysp /= 4;
			
			physics.apply_underwater();
			
			if (is_shield_water_flushable(shield))
				shield = undefined;
				
			timer_underwater.start();
		} else {
			ysp *= 2;
			physics.cancel_underwater();
			
			player_underwater_regain_air();
		}
		
		var _particle = part_system_create(ParticleSystem2);
		part_system_depth	(_particle, -20	);
		part_system_position(_particle, x, y);
		
		audio_play_sound(sndWaterSplash, 0, 0);
	}
	
};