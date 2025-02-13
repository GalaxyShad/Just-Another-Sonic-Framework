function player_collision_room_borders(_p) {
	var _sensor_right = x + collision_detector.get_radius().wall;
	var _sensor_left  = x - collision_detector.get_radius().wall;
	
	if (xsp > 0 && _sensor_right > room_width) {
		xsp = 0;
		gsp = 0;
		
		x = room_width - collision_detector.get_radius().wall;
	}
	
	if (xsp < 0 && _sensor_left < 0) {
		xsp = 0;
		gsp = 0;
		
		x = +collision_detector.get_radius().wall;
	}
}

enum PushDir {
	Left,
	Right,
	Top,
	Bottom
};

/// @param {Struct.Player} p  
function player_behavior_collisions(p) {


	var f = p.inst.ground 
		? player_collisions_ground 
		: player_collisions_air;
	
	f(p);
	
	player_collision_room_borders();
}

/// @param {Struct.Player} p  
function player_collisions_ground(p) {
	var _gsp_slice = 8;
	
	if (!ground) {
		return;
	}

	player_collisions_ground_gsp(gsp % _gsp_slice, p);	

	xsp = gsp *  p.collider.get_angle_data().cos;
	ysp = gsp * -p.collider.get_angle_data().sin;

	for (var i = 0; i < (abs(gsp) div _gsp_slice) * _gsp_slice; i += _gsp_slice) {		
		if (!ground) {

			xsp = gsp * p.collider.get_angle_data().cos;
			ysp = gsp * -p.collider.get_angle_data().sin;

			return;
		}
		
		player_collisions_ground_gsp(sign(gsp) * _gsp_slice, p);	

		
	}
}

/// @param {Struct.Player} p  
function player_collision_walls(p) {

	var _is_colliding_left  = false;
	var _is_colliding_right = false;

	// Push from right wall 
	repeat 128 {
		if (p.collider.is_collision_solid(PlayerCollisionDetectorSensor.Right)) {
			p.inst.x -= p.collider.get_angle_data().cos;
			p.inst.y += p.collider.get_angle_data().sin;
	
			_is_colliding_right = true;
		} else {
			break;
		}
	}

	// Push from left wall 
	repeat 128 {
		if (p.collider.is_collision_solid(PlayerCollisionDetectorSensor.Left)) {
			p.inst.x += p.collider.get_angle_data().cos;
			p.inst.y -= p.collider.get_angle_data().sin;
	
			_is_colliding_left = true;
		} else {
			break;
		}
	}

	var _spd = p.inst.ground ? p.inst.gsp : p.inst.xsp;

	if (
		(_is_colliding_left  && _spd < 0) || 
		(_is_colliding_right && _spd > 0)
	) {
		if (p.inst.ground) { 
			p.inst.gsp = 0;
		} else {
			p.inst.xsp = 0;
		}
	}
}

/// @param {Struct.Player} p  
function player_collisions_ground_gsp(_gsp, p) {
	if (!ground) return;

	x += _gsp *  p.collider.get_angle_data().cos;
	y += _gsp * -p.collider.get_angle_data().sin;
	
	if (!p.collider.is_collision_solid(PlayerCollisionDetectorSensor.FloorExtend)) {
		p.inst.ground = false;

		p.collider.set_angle(0);
		
		return;
	}

	player_collision_walls(p);
	
	p.collider.set_angle(p.collider.measure_angle());

	repeat 128 {
		if (p.collider.is_collision_solid(PlayerCollisionDetectorSensor.Bottom) == true) {
			p.inst.x -= p.collider.get_angle_data().sin;
			p.inst.y -= p.collider.get_angle_data().cos;
		} else {
			break;
		}
	}

	repeat 128 {
		if (p.collider.is_collision_solid(PlayerCollisionDetectorSensor.Bottom) == false) {
			p.inst.x += p.collider.get_angle_data().sin;
			p.inst.y += p.collider.get_angle_data().cos;
		} else {
			break;
		}
	}
}

/// @param {Struct.Player} p  
function player_collisions_air(p) {
	if (ground) return;
	
	p.collider.set_angle(0);
	
	x += xsp;
	y += ysp;
	
	player_collision_walls(p);

#region Celling
	if (p.collider.is_collision_solid(PlayerCollisionDetectorSensor.Top) && ysp < 0) {
		repeat 128 {
			if (p.collider.is_collision_solid(PlayerCollisionDetectorSensor.Top)) {
				y++;
			}
		}

		p.collider.set_angle(180);

		p.collider.set_angle(p.collider.measure_angle(true));
		
		
		if (p.collider.is_angle_in_range(91, 135) || p.collider.is_angle_in_range(226, 270)) {
			ground = true;
			gsp	   = ysp * -sign(p.collider.get_angle_data().sin);
			
			player_landing();
			
			return;
		} else {
			p.collider.set_angle(0);	
			ysp = 0;
		}
	}
#endregion
#region Ground
	if (p.collider.is_collision_solid(PlayerCollisionDetectorSensor.Bottom) && ysp > 0) {
		ground = true;

		repeat 128 {
			while (p.collider.is_collision_solid(PlayerCollisionDetectorSensor.Bottom)) {
				y--;
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
			gsp = xsp;
		} else {
			if (abs(xsp) > abs(ysp)) {
				gsp = xsp;
			} else if (_RANGE_SLOPE) {
				gsp = ysp / 2 * -sign(p.collider.get_angle_data().sin);
			} else if (_RANGE_STEEP_SLOPE) {
				gsp = ysp * -sign(p.collider.get_angle_data().sin);
			}
		} 
			
		xsp = gsp *  p.collider.get_angle_data().cos; 
		ysp = gsp * -p.collider.get_angle_data().sin;
			
		player_landing();
	}
#endregion

}


