state.step();

if (state.current() == "die") {
	ysp += physics.gravity_force;
	
	y += ysp;
	
	camera.set_lag_timer(1);
	
	exit;
}


player_switch_sensor_radius();


if (ground) {
	var _gsp = gsp;

	var _d = 16;

	gsp = _gsp % _d;
	player_collision();	

	if (ground) {
		for (var i = 0; i < floor(abs(_gsp) / _d) * _d; i+=_d) {
			gsp = sign(_gsp)*_d;
			player_collision();	
			if (!ground) break;
		}
	}

	gsp = _gsp;
} else {
	player_collision();	
}


//////////////////////////////////////////////////////

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

player_ground_movement();
player_air_movement();
player_handle_objects();

if (_water != noone) {
	var _is_entering = (y > _water.y)  && !physics.is_underwater();
	var _is_exiting  = (y <= _water.y)	&&  physics.is_underwater();
	
	if (_is_entering || _is_exiting) {
		if (_is_entering) {
			xsp *= 0.5;
			ysp *= 0.25;
			
			physics.apply_underwater();
			
			if (shield == Shield.Lightning || shield == Shield.Flame)
				shield = Shield.None;
				
			timer_underwater.start();
		} else {
			ysp *= 2;
			physics.cancel_underwater();
			
			player_underwater_regain_air();
		}
		
		var _particle = part_system_create(ParticleSystem2);
		part_system_depth(_particle, -20);
		part_system_position(_particle, x, y);
		
		audio_play_sound(sndWaterSplash, 0, 0);
	}
}

var _o_moving_platform = sensor.collision_object(objMovingPlatform, 6);
if (ground && _o_moving_platform) {
	x += _o_moving_platform.x - _o_moving_platform.xprevious; 
	sensor.set_position(x, y);
}


if (allow_jump && ground && is_key_action_pressed) {
	ground = false;
	
	ysp -= physics.jump_force * dcos(sensor.get_angle()); 
	xsp -= physics.jump_force * dsin(sensor.get_angle()); 
	
	state.change_to("jump");
	
	audio_play_sound(sndPlrJump, 0, false);
} 

var _is_moving_right = (ground && gsp > 0) || (!ground && xsp > 0);
var _is_moving_left = (ground && gsp < 0) || (!ground && xsp < 0);

if ((_is_moving_right && sensor.check_expanded(1, 0, sensor.is_collision_solid_right)) || 
	(_is_moving_left  && sensor.check_expanded(1, 0, sensor.is_collision_solid_left))
) {
	if (ground) {
		gsp = 0;
		
		if ((xsp < 0 && is_key_left) || (xsp > 0 && is_key_right))
			state.change_to("push");
	}
	
	xsp = 0;
}

if (inv_timer > 0)
	inv_timer--;
	



	
