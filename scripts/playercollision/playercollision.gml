
function player_behavior_collisions() {
	sensor.set_wall_box(
		(!sensor.angle_in_range(16, 344) && ground) ? 
			SENSOR_WALLBOX_NORMAL : SENSOR_WALLBOX_SLOPES
	);

	sensor.set_position(x, y);
	
	(ground ? player_collisions_ground : player_collisions_air)();
	
	x = sensor.get_position().x;
	y = sensor.get_position().y;
}


function player_collisions_ground() {
	#macro GSP_SLICE 16

	player_collisions_ground_gsp(gsp % GSP_SLICE);	
	if (!ground) return;
		
	for (var i = 0; i < (abs(gsp) div GSP_SLICE) * GSP_SLICE; i += GSP_SLICE) {
		player_collisions_ground_gsp(sign(gsp) * GSP_SLICE);	
				
		if (!ground) return;
	}
}

function player_collisions_ground_gsp(_gsp) {
	if (!ground) return;
	
	var _sin_ang = sensor.get_angle_sin();
	var _cos_ang = sensor.get_angle_cos();
	
	if ((gsp > 0 && sensor.check_expanded(1, 0, sensor.is_collision_solid_right)) || 
		(gsp < 0 && sensor.check_expanded(1, 0, sensor.is_collision_solid_left))
	) {
		gsp = 0;
	}
	
	xsp = _gsp *  _cos_ang;
	ysp = _gsp * -_sin_ang;
	
	sensor.set_position(
		sensor.get_position().x + xsp,
		sensor.get_position().y + ysp
	);
	
	while (sensor.is_collision_solid_right() && _gsp > 0) {
		sensor.set_position(
			sensor.get_position().x - _cos_ang,
			sensor.get_position().y + _sin_ang
		);
	}

	while (sensor.is_collision_solid_left() && _gsp < 0) {
		sensor.set_position(
			sensor.get_position().x + _cos_ang,
			sensor.get_position().y - _sin_ang
		);
	}

	while (sensor.is_collision_solid_bottom()) {
		sensor.set_position(
			sensor.get_position().x - _sin_ang,
			sensor.get_position().y - _cos_ang
		);
	}
	
	sensor.set_angle(sensor.get_ground_angle());
	
	if (!sensor.is_collision_ground()) {
		sensor.set_angle(0);
		ground = false;	
		
		return;
	}
	
	while (!sensor.is_collision_solid_bottom()) {
		sensor.set_position(
			sensor.get_position().x + _sin_ang,
			sensor.get_position().y + _cos_ang
		);
	}
		
	while (sensor.is_collision_solid_bottom()) {
		sensor.set_position(
			sensor.get_position().x - _sin_ang / 1000,
			sensor.get_position().y - _cos_ang / 1000
		);
	}
}

function player_collisions_air() {
	if (ground) return;
	
	sensor.set_angle(0);
	
#region WallCollisions
	if ((xsp > 0 && sensor.check_expanded(1, 0, sensor.is_collision_solid_right)) || 
		(xsp < 0 && sensor.check_expanded(1, 0, sensor.is_collision_solid_left))
	) {
		xsp = 0;
	}

	sensor.set_position(
		sensor.get_position().x + xsp,
		sensor.get_position().y
	);
	
	while (sensor.is_collision_solid_right() && xsp > 0) {
		sensor.set_position(
			sensor.get_position().x - sensor.get_angle_cos(),
			sensor.get_position().y + sensor.get_angle_sin()
		);
	}

	while (sensor.is_collision_solid_left() && xsp < 0) {
		sensor.set_position(
			sensor.get_position().x + sensor.get_angle_cos(),
			sensor.get_position().y - sensor.get_angle_sin()
		);
	}
#endregion

#region CellingAndGroundCollisions
	sensor.set_position(
		sensor.get_position().x,
		sensor.get_position().y + ysp
	);

#region Celling
	if (sensor.is_collision_solid_top() && ysp < 0) {
		while (sensor.is_collision_solid_top()) {
			sensor.set_position(
				sensor.get_position().x, 
				sensor.get_position().y + 1
			);
		}
		
		sensor.set_angle(180);
		
		sensor.set_angle(sensor.get_landing_ground_angle());
		
		if (sensor.angle_in_range(91, 135) || sensor.angle_in_range(226, 270)) {
			ground = true;
			gsp	   = ysp * -sign(sensor.get_angle_sin());
			
			player_landing();
			
			return;
		} else {
			sensor.set_angle(0);	
			ysp = 0;
		}
	}
#endregion

#region Ground
	if (!ground && sensor.is_collision_solid_bottom() && ysp > 0) {
		ground = true;

		while (sensor.is_collision_solid_bottom()) {
			sensor.set_position(
				sensor.get_position().x, 
				sensor.get_position().y - 1
			);
		}
			
		sensor.set_angle(sensor.get_landing_ground_angle());
		
		var _RANGE_SHALLOW		= sensor.angle_in_range(00, 23) || sensor.angle_in_range(339, 360);
		var _RANGE_SLOPE		= sensor.angle_in_range(24, 45) || sensor.angle_in_range(316, 338);
		var _RANGE_STEEP_SLOPE	= sensor.angle_in_range(46, 90) || sensor.angle_in_range(271, 315);
		
		if (_RANGE_SHALLOW) {
			gsp = xsp;
		} else if (_RANGE_SLOPE) {
			if (abs(xsp) > abs(ysp)) {
				gsp = xsp;
			} else {
				gsp = ysp / 2 * -sign(sensor.get_angle_sin());
			}
		} else if (_RANGE_STEEP_SLOPE) {
			if (abs(xsp) > abs(ysp)) {
				gsp = xsp;
			} else {
				gsp = ysp * -sign(sensor.get_angle_sin());
			}
		}
			
		xsp = gsp *  sensor.get_angle_cos(); 
		ysp = gsp * -sensor.get_angle_sin();
			
		player_landing();
	}
#endregion
#endregion

}


