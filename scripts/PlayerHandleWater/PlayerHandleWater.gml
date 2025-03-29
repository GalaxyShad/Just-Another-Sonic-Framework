/// @param {Struct.Player} plr
function player_handle_bubbles(plr) { 
	var _o_bubble = plr.collider.collision_object(objBigBubble, PlayerCollisionDetectorSensor.MainDefault);
	if (_o_bubble) {
		plr.xsp = 0;
		plr.ysp = 0;
		
		plr.state_machine.change_to("breathe");
		
		instance_destroy(_o_bubble);
		
		audio_play_sound(sndPlayerBreathe, 0, 0);
		
		player_underwater_regain_air();
	}
}

/// @param {Struct.Player} plr
function player_handle_water(plr) {
	var _water = instance_nearest(plr.inst.x, plr.inst.y, objWaterLevel);
	if (_water == noone) 
		return;
	
	var _is_entering = (plr.inst.y > _water.y)  && !plr.physics.is_underwater();
	var _is_exiting  = (plr.inst.y <= _water.y) &&  plr.physics.is_underwater();
	
	if (_is_entering || _is_exiting) {
		if (_is_entering) {
			plr.xsp /= 2;
			plr.ysp /= 4;
			
			plr.physics.apply_underwater();
			
			if (is_shield_water_flushable(plr.inst.shield))
				plr.inst.shield = undefined;
				
			plr.inst.timer_underwater.start();
		} else {
			plr.ysp *= 2;
			plr.physics.cancel_underwater();
			
			player_underwater_regain_air();
		}
		
		var _particle = part_system_create(ParticleSystem2);
		part_system_depth	(_particle, -20	);
		part_system_position(_particle, plr.inst.x, plr.inst.y);
		
		audio_play_sound(sndWaterSplash, 0, 0);
	}
	
};