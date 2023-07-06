




function player_behavior_collisions_ground() {
	if (!ground) return;
	
	if ((gsp > 0 && sensor.check_expanded(1, 0, sensor.is_collision_solid_right)) || 
		(gsp < 0 && sensor.check_expanded(1, 0, sensor.is_collision_solid_left))
	) {
		gsp = 0;
	}
	
	var _gsp = gsp;

	var _d = 16;

	gsp = _gsp % _d;
	player_collisions_ground();	

	if (ground) {
		for (var i = 0; i < floor(abs(_gsp) / _d) * _d; i+=_d) {
			gsp = sign(_gsp)*_d;
			player_collisions_ground();	
			if (!ground) break;
		}
	}

	gsp = _gsp;
}

function player_collisions_ground() {
	if (!ground) return;
		
	xsp = gsp *  sensor.get_angle_cos();  
	ysp = gsp * -sensor.get_angle_sin();
	
	x += xsp;
	y += ysp;
	
	sensor.set_position(x, y);
	
	var _sin_ang = sensor.get_angle_sin();
	var _cos_ang = sensor.get_angle_cos();
	
#region WallCollisions
	sensor.set_wall_box(
		( (sensor.get_angle() <= 15 || sensor.get_angle() >= 345 ) && ground) ? 
		SENSOR_WALLBOX_NORMAL : SENSOR_WALLBOX_SLOPES
	);
	
	
	
	while (sensor.is_collision_solid_right()) {
		sensor.set_position(
			sensor.get_position().x - _cos_ang,
			sensor.get_position().y + _sin_ang
		);
	}

	while (sensor.is_collision_solid_left()) {
		sensor.set_position(
			sensor.get_position().x + _cos_ang,
			sensor.get_position().y - _sin_ang
		);
	}
#endregion
#region SlopesCollision
	while (sensor.is_collision_solid_bottom()) {
		sensor.set_position(
			sensor.get_position().x - _sin_ang,
			sensor.get_position().y - _cos_ang
		);
	}
		
	while (!sensor.is_collision_solid_bottom() && 
			sensor.is_collision_ground()
	) {
		sensor.set_position(
			sensor.get_position().x + _sin_ang,
			sensor.get_position().y + _cos_ang
		);
	}
#endregion
		
	sensor.set_angle(sensor.get_ground_angle());
		
	while (sensor.is_collision_solid_bottom()) {
		sensor.set_position(
			sensor.get_position().x - _sin_ang / 1000,
			sensor.get_position().y - _cos_ang / 1000
		);
	}
		
	x += sensor.get_position().x - x;
	y += sensor.get_position().y - y;
		
	if (!sensor.is_collision_ground()) {
		sensor.set_angle(0);
		ground = false;
	} 
}

function player_behavior_collisions_air() {
	if (ground) return;
	
	if ((xsp > 0 && sensor.check_expanded(1, 0, sensor.is_collision_solid_right)) || 
		(xsp < 0 && sensor.check_expanded(1, 0, sensor.is_collision_solid_left))
	) {
		xsp = 0;
	}
	
	x += xsp;
	y += ysp;
	
	sensor.set_position(x, y);
	sensor.set_angle(0);
	
	var _sin_ang = sensor.get_angle_sin();
	var _cos_ang = sensor.get_angle_cos();
	
	#region WallCollisions
	while (sensor.is_collision_solid_right()) {
		sensor.set_position(
			sensor.get_position().x - _cos_ang,
			sensor.get_position().y + _sin_ang
		);
	}

	while (sensor.is_collision_solid_left()) {
		sensor.set_position(
			sensor.get_position().x + _cos_ang,
			sensor.get_position().y - _sin_ang
		);
	}
	
	x += sensor.get_position().x - x;
	y += sensor.get_position().y - y;
	
	#endregion
		
	#region Celling
	if (sensor.is_collision_solid_top() && ysp < 0) {
		sensor.set_angle(180);
		
		var _ang = sensor.get_ground_angle();
		if (_ang == 0) 
			_ang = sensor.get_landing_ground_angle();
			
		
		if ((_ang >= 91 && _ang <= 135) || (_ang >= 226 && _ang <= 270)) {
			sensor.set_angle(_ang);
			ground = true;
			gsp = ysp * -sign(sensor.get_angle_sin());
			
			player_landing();
			
			player_behavior_collisions_ground();
			
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
			y--;
			sensor.set_position(x, y);
		}
			
		var _ang = sensor.get_ground_angle();
		
		if (_ang == 0) 
			_ang = sensor.get_landing_ground_angle();
		
		sensor.set_angle(_ang);
		
		_ang = abs(sensor.get_angle());
		if (_ang >= 180) 
			_ang = 360 - _ang;
		
		if ( _ang >= 0 &&  _ang <= 23)
			gsp = xsp;
				
		else if ( _ang >= 24 &&  _ang <= 45) {
			if (abs(xsp) > abs(ysp)) 
				gsp = xsp;
			else 
				gsp = ysp / 2 * -sign(sensor.get_angle_sin());
			
		} else if ( _ang >= 46 &&  _ang <= 100) {
			if (abs(xsp) > abs(ysp))
				gsp = xsp;
			else 
				gsp = ysp * -sign(sensor.get_angle_sin());
		}
			
		xsp = gsp *  sensor.get_angle_cos(); 
		ysp = gsp * -sensor.get_angle_sin();
			
		player_landing();
	}
	#endregion
}



