

/// @param {Struct.Player} p
function player_push_left(p) {
	p.inst.x -= p.collider.get_angle_data().cos;
	p.inst.y += p.collider.get_angle_data().sin;
}

/// @param {Struct.Player} p
function player_push_right(p) {
	p.inst.x += p.collider.get_angle_data().cos;
	p.inst.y -= p.collider.get_angle_data().sin;
}

/// @param {Struct.Player} p
function player_push_up(p) {
	p.inst.x -= p.collider.get_angle_data().sin;
	p.inst.y -= p.collider.get_angle_data().cos;
}

/// @param {Struct.Player} p
function player_push_down(p) {
	p.inst.x += p.collider.get_angle_data().sin;
	p.inst.y += p.collider.get_angle_data().cos;
}

/// @param {Struct.Player} p  
function player_collision_room_borders(p) {
	var _sensor_right = p.inst.x + p.collider.get_radius().wall;
	var _sensor_left  = p.inst.x - p.collider.get_radius().wall;
	
	if (p.xsp > 0 && _sensor_right > room_width) {
		p.xsp = 0;
		p.gsp = 0;
		
		p.inst.x = room_width - p.collider.get_radius().wall;
	}
	
	if (p.xsp < 0 && _sensor_left < 0) {
		p.xsp = 0;
		p.gsp = 0;
		
		p.inst.x = +p.collider.get_radius().wall;
	}
}

/// @param {Struct.Player} p  
function player_behavior_apply_speed(p) {
	if (p.ground) {
		p.inst.x += p.gsp *  p.collider.get_angle_data().cos;
		p.inst.y += p.gsp * -p.collider.get_angle_data().sin;
	
		p.xsp = p.gsp *   p.collider.get_angle_data().cos;
		p.ysp = p.gsp *  -p.collider.get_angle_data().sin;
	} else {
		p.inst.x += p.xsp;
		p.inst.y += p.ysp;
	}
}

/// @param {Struct.Player} p  
function player_behavior_collisions_solid(p) {
	var f = p.ground 
		? player_collisions_ground 
		: player_collisions_air;
	
	f(p);
	
	player_collision_room_borders(p);
}

/// @param {Struct.Player} p  
function player_collisions_ground(p) {
	var _gsp_slice = 8;
	
	if (!p.ground) {
		return;
	}

	var _use_slip = true;
    
	if (!_use_slip) {
		player_collisions_ground_gsp(p.gsp, p);	
		return;
	}

	p.inst.x = p.inst.xprevious;
	p.inst.y = p.inst.yprevious;

	player_collisions_ground_gsp(p.gsp % _gsp_slice, p);	
	
	if (!p.ground) return;

	for (var i = 0; i < (abs(p.gsp) div _gsp_slice) * _gsp_slice; i += _gsp_slice) {		
		player_collisions_ground_gsp(sign(p.gsp) * _gsp_slice, p);	

		if (!p.ground) break;
	}
}

/// @param {Struct.Player} p  
function player_collision_walls(p) {

	var _is_colliding_left  = false;
	var _is_colliding_right = false;

	// Push from right wall 
	repeat 128 {
		if (p.collider.is_collision_solid(PlayerCollisionDetectorSensor.Right)) {
			player_push_left(p);
			_is_colliding_right = true;
		} else {
			break;
		}
	}

	// Push from left wall 
	repeat 128 {
		if (p.collider.is_collision_solid(PlayerCollisionDetectorSensor.Left)) {
			player_push_right(p);
			_is_colliding_left = true;
		} else {
			break;
		}
	}

	var _spd = p.ground ? p.gsp : p.xsp;

	if (
		(_is_colliding_left  && _spd < 0) || 
		(_is_colliding_right && _spd > 0)
	) {
		if (p.ground) { 
			p.gsp = 0;
		} else {
			p.xsp = 0;
		}
	}
}

/// @param {Real} _gsp
/// @param {Struct.Player} p  
function player_collisions_ground_gsp(_gsp, p) {
	if (!p.ground) return;

	x += _gsp *  p.collider.get_angle_data().cos;
	y += _gsp * -p.collider.get_angle_data().sin;

	player_collision_walls(p);
	
	p.collider.set_angle(p.collider.measure_angle());
	
	p.xsp = p.gsp *  p.collider.get_angle_data().cos;
	p.ysp = p.gsp *  -p.collider.get_angle_data().sin;

	repeat 128 {
		if (p.collider.is_collision_solid(PlayerCollisionDetectorSensor.Bottom) == true) {
			player_push_up(p);
		} else {
			break;
		}
	}

	if (!p.collider.is_collision_solid(PlayerCollisionDetectorSensor.FloorExtend)) {
		p.ground = false;

		p.collider.set_angle(0);

		return;
	}

	repeat 128 {
		if (p.collider.is_collision_solid(PlayerCollisionDetectorSensor.Bottom) == false) {
			player_push_down(p);
		} else {
			break;
		}
	}
}

/// @param {Struct.Player} p  
function player_collision_celling_and_landing(p) {
	repeat 128 {
		if (p.collider.is_collision_solid(PlayerCollisionDetectorSensor.Top)) {
			player_push_down(p);
		}
	}

	p.collider.set_angle(180);
	p.collider.set_angle(p.collider.measure_angle(true));
	
	if (p.collider.is_angle_in_range(91, 135) || p.collider.is_angle_in_range(226, 270)) {
		p.ground = true;
		p.gsp	 = p.ysp * -sign(p.collider.get_angle_data().sin);
		
		player_landing(p);
		
		return;
	} else {
		p.collider.set_angle(0);	
		p.ysp = 0;
	}
}

/// @param {Struct.Player} p  
function player_collision_floor_and_landing(p) {
	p.ground = true;

	repeat 128 {
		if (p.collider.is_collision_solid(PlayerCollisionDetectorSensor.Bottom)) {
			player_push_up(p);
		} else {
			break;
		}
	}
	
	var _ang = p.collider.measure_angle(true);

	p.collider.set_angle(_ang);
	
	var _RANGE_SHALLOW		= p.collider.is_angle_in_range(  0,  23) || 
							  p.collider.is_angle_in_range(339, 360);

	var _RANGE_SLOPE		= p.collider.is_angle_in_range( 24,  45) || 
							  p.collider.is_angle_in_range(316, 338);

	var _RANGE_STEEP_SLOPE	= p.collider.is_angle_in_range( 46,  90) || 
							  p.collider.is_angle_in_range(271, 315);
	
	if (_RANGE_SHALLOW) {
		p.gsp = p.xsp;
	} else {
		if (abs(p.xsp) > abs(p.ysp)) {
			p.gsp = p.xsp;
		} else if (_RANGE_SLOPE) {
			p.gsp = p.ysp / 2 * -sign(p.collider.get_angle_data().sin);
		} else if (_RANGE_STEEP_SLOPE) {
			p.gsp = p.ysp * -sign(p.collider.get_angle_data().sin);
		}
	} 
		
	p.xsp = p.gsp *  p.collider.get_angle_data().cos; 
	p.ysp = p.gsp * -p.collider.get_angle_data().sin;
		
	player_landing(p);
}

/// @param {Struct.Player} p  
function player_collisions_air(p) {
	if (p.ground) return;
	
	p.collider.set_angle(0);
	
	player_collision_walls(p);

	if (p.collider.is_collision_solid(PlayerCollisionDetectorSensor.Top) && p.ysp < 0) {
		player_collision_celling_and_landing(p);
	}

	if (p.collider.is_collision_solid(PlayerCollisionDetectorSensor.Bottom) && p.ysp > 0) {
		player_collision_floor_and_landing(p);
	}
}


