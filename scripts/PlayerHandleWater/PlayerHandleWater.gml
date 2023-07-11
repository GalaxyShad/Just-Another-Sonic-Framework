
function player_handle_bubbles() {
	var _o_bubble = sensor.collision_object(objBigBubble);
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

	var _colliding_with_water = (y+sensor.get_floor_box().vradius >= _water.y - 1);
	
	if (running_on_water) {
		xsp = gsp;
			
		x += xsp;
	
		if (sensor.is_collision_solid_bottom()) {
			while (sensor.is_collision_solid_bottom()) {
				y--;
				sensor.set_position(x, y);
			}
			y++;
		}
		
		if (global.tick % 6 == 0) {
			var _sfx = instance_create_depth(
				x - 6 * image_xscale, 
				y + sensor.get_floor_box().vradius, 
				depth+1, 
				objSfxWaterRunWave
			);
			_sfx.image_xscale = image_xscale;
		}
		
		sensor.set_position(x, y);
		
		var _collision_wall = (xsp > 0 && sensor.is_collision_solid_right()) ||
							  (xsp < 0 && sensor.is_collision_solid_left());		  
		if (_collision_wall) {
			gsp = 0;
			xsp = 0;
		}

		if (ysp < 0 || abs(gsp) < 6 || !_colliding_with_water || _collision_wall) {
			behavior_loop.enable(player_behavior_collisions);
			running_on_water = false;	
		}
	} else {
		if (_colliding_with_water && !physics.is_underwater() && (abs(gsp) >= 6) && ground && 
			(sensor.get_angle() >= 358  || sensor.get_angle() <= 2) 
		) {
			y = _water.y - sensor.get_floor_box().vradius
			
			sensor.set_position(x, y);
			sensor.set_angle(0);
			
			ysp					= 0;
			ground				= true;
			running_on_water	= true;
		
			behavior_loop.disable(player_behavior_collisions);
		} 		
	}
	
	
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