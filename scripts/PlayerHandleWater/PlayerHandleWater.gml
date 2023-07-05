
function player_handle_water() {
	var _water = instance_nearest(x, y, objWaterLevel);

	if (_water != noone) {
		var _colliding_with_water = (y+sensor.get_floor_box().vradius >= _water.y -4);
	
		if (_colliding_with_water && 
			!physics.is_underwater() &&
			(abs(gsp) >= 6) && ground && 
			(sensor.get_angle() >= 352  || sensor.get_angle() <= 8) 
		) {
			y = _water.y - sensor.get_floor_box().vradius;
			sensor.set_position(x, y);
			sensor.set_angle(0);
			ground = true;
			running_on_water = true;
		} 		


		if (running_on_water) {
			if (!part_system_exists(p_sfx_water_run)) {
				p_sfx_water_run = part_system_create(partWaterRun);	
			}

			if (ysp >= 0 && abs(gsp) >= 6 && _colliding_with_water) {
				ground = true;
				part_system_position(
					p_sfx_water_run, 
					x - 12 * image_xscale, y + sensor.get_floor_box().vradius
				);
			} else {
				part_system_destroy(p_sfx_water_run);
				running_on_water = false;
			}
		}
	}
	
	if (_water != noone) {
		var _is_entering = (y > _water.y)  && !physics.is_underwater();
		var _is_exiting  = (y <= _water.y)	&&  physics.is_underwater();
	
		if (_is_entering || _is_exiting) {
			if (_is_entering) {
				xsp *= 0.5;
				ysp *= 0.25;
			
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
	}
};