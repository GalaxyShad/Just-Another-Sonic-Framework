
function player_collision_room_borders() {
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

function player_behavior_collisions() {
	// sensor.set_wall_box(
	// 	(!sensor.angle_in_range(16, 344) && ground) ? 
	// 		SENSOR_WALLBOX_NORMAL : SENSOR_WALLBOX_SLOPES
	// );

	// TODO

	var f = ground ? player_collisions_ground : player_collisions_air;
	
	f();
	
	player_collision_room_borders();
	
	//x = sensor.get_position().x;
	//y = sensor.get_position().y;
}

function player_collisions_ground() {
	#macro GSP_SLICE 16

	player_collisions_ground_gsp(gsp);	
	
	if (!ground) {
		return;
	}
	
		
	// for (var i = 0; i < (abs(gsp) div GSP_SLICE) * GSP_SLICE; i += GSP_SLICE) {
	// 	player_collisions_ground_gsp(sign(gsp) * GSP_SLICE);	
		
	// 	xsp = gsp *  sensor.get_angle_cos();
	// 	ysp = gsp * -sensor.get_angle_sin();
		
	// 	if (!ground) {
	// 		return;
	// 	}
	// }
}

function player_collisions_ground_gsp(_gsp) {
	if (!ground) return;

	xsp = _gsp *  collision_detector.get_angle_data().cos;
	ysp = _gsp * -collision_detector.get_angle_data().sin;

	x += xsp;
	y += ysp;
	
	if ((gsp > 0 && collision_detector.is_collision_solid(PlayerCollisionDetectorSensor.Right)) || 
		(gsp < 0 && collision_detector.is_collision_solid(PlayerCollisionDetectorSensor.Left))
	) {
		gsp = 0;

		while (collision_detector.is_collision_solid(PlayerCollisionDetectorSensor.Right)) {
			x -= collision_detector.get_angle_data().cos;
			y += collision_detector.get_angle_data().sin;
		}
	
		while (collision_detector.is_collision_solid(PlayerCollisionDetectorSensor.Left)) {
			x += collision_detector.get_angle_data().cos;
			y -= collision_detector.get_angle_data().sin;
		}
	}
	
	if (collision_detector.is_collision_solid(PlayerCollisionDetectorSensor.FloorExtend)) {
		
		
		while (collision_detector.is_collision_solid(PlayerCollisionDetectorSensor.Bottom)) {
			x -= collision_detector.get_angle_data().sin;
			y -= collision_detector.get_angle_data().cos;
		}

		while (!collision_detector.is_collision_solid(PlayerCollisionDetectorSensor.Bottom)) {
			x += collision_detector.get_angle_data().sin;
			y += collision_detector.get_angle_data().cos;
		}
		
		collision_detector.set_angle(collision_detector.measure_angle());
	} else {
		ground = false;
	}
}

function player_collisions_air() {
	if (ground) return;
	
	collision_detector.set_angle(0);
	
#region WallCollisions

	x += xsp;
	y += ysp;
	
	if ((xsp > 0 && collision_detector.is_collision_solid(PlayerCollisionDetectorSensor.Right)) || 
		(xsp < 0 && collision_detector.is_collision_solid(PlayerCollisionDetectorSensor.Left))
	) {
		while (xsp > 0 && collision_detector.is_collision_solid(PlayerCollisionDetectorSensor.Right)) {
			x--;
		}

		while (xsp < 0 && collision_detector.is_collision_solid(PlayerCollisionDetectorSensor.Left)) {
			x++;
		}

		xsp = 0;
	}

#endregion

#region CellingAndGroundCollisions
	

#region Celling
	if (collision_detector.is_collision_solid(PlayerCollisionDetectorSensor.Top) && ysp < 0) {
		while (collision_detector.is_collision_solid(PlayerCollisionDetectorSensor.Top)) {
			y++;
		}

		collision_detector.set_angle(180);

		collision_detector.set_angle(collision_detector.measure_angle(true));
		
		
		if (collision_detector.is_angle_in_range(91, 135) || collision_detector.is_angle_in_range(226, 270)) {
			ground = true;
			gsp	   = ysp * -sign(collision_detector.get_angle_data().sin);
			
			player_landing();
			
			return;
		} else {
			collision_detector.set_angle(0);	
			ysp = 0;
		}
	}
#endregion
#region Ground
	if (collision_detector.is_collision_solid(PlayerCollisionDetectorSensor.Bottom) && ysp > 0) {
		ground = true;

		while (collision_detector.is_collision_solid(PlayerCollisionDetectorSensor.Bottom)) {
			y--;
		}
		
		var _ang = collision_detector.measure_angle(true);

		show_debug_message(_ang);

		collision_detector.set_angle(_ang);
		
		var _RANGE_SHALLOW		= collision_detector.is_angle_in_range(  0,  23) || 
								  collision_detector.is_angle_in_range(339, 360);

		var _RANGE_SLOPE		= collision_detector.is_angle_in_range( 24,  45) || 
								  collision_detector.is_angle_in_range(316, 338);

		var _RANGE_STEEP_SLOPE	= collision_detector.is_angle_in_range( 46,  90) || 
								  collision_detector.is_angle_in_range(271, 315);
		
		if (_RANGE_SHALLOW) {
			gsp = xsp;
		} else if (_RANGE_SLOPE) {
			if (abs(xsp) > abs(ysp)) {
				gsp = xsp;
			} else {
				gsp = ysp / 2 * -sign(collision_detector.get_angle_data().sin);
			}
		} else if (_RANGE_STEEP_SLOPE) {
			if (abs(xsp) > abs(ysp)) {
				gsp = xsp;
			} else {
				gsp = ysp * -sign(collision_detector.get_angle_data().sin);
			}
		}
			
		xsp = gsp *  collision_detector.get_angle_data().cos; 
		ysp = gsp * -collision_detector.get_angle_data().sin;
			
		player_landing();
	}
#endregion
#endregion

}


