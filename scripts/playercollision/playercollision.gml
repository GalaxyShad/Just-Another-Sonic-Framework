// Ресурсы скриптов были изменены для версии 2.3.0, подробности см. по адресу
// https://help.yoyogames.com/hc/en-us/articles/360005277377
function PlayerHandleObjects() {
	PlayerHandleLayers();
	PlayerHandleSprings();
	PlayerHandleRing();
	PlayerHandleSpikes();
	PlayerHandleMonitors();	
	
	var _oBubble = sensor.collision_object(objBigBubble);
	if (_oBubble) {
		xsp = 0;
		ysp = 0;
		
		state.change_to("breathe");
		
		instance_destroy(_oBubble);
		
		audio_play_sound(sndPlayerBreathe, 0, 0);
		
		player_underwater_regain_air();
	}
}

function PlayerCollision() {

	if (ground) {
		xsp = gsp *  dcos(sensor.get_angle());
		ysp = gsp * -dsin(sensor.get_angle());
	}
	
	
	x += xsp;
	y += ysp;	
	
	
	sensor.set_position(x, y);
	
	x = clamp(x, 0, room_width);

	
	sensor.set_wall_box(
		( (sensor.get_angle() <= 15 || sensor.get_angle() >= 345 ) && (ground || state.current()=="glide")) ? 
		SENSOR_WALLBOX_NORMAL : SENSOR_WALLBOX_SLOPES
	);
	
	var _cos_ang = dcos(sensor.get_angle());
	var _sin_ang = dsin(sensor.get_angle());
	
	
	while (sensor.is_collision_solid_right()) {
		x -= _cos_ang;
		y += _sin_ang;
		
		sensor.set_position(x, y);
	}

	while (sensor.is_collision_solid_left()) {
		x += _cos_ang;
		y -= _sin_ang;
		
		sensor.set_position(x, y);
	}
	
	if (!ground) {	
		//sensor.set_angle( sensor.get_angle() + angle_difference(0, sensor.get_angle()) / 20 );
		
		sensor.set_angle(0);
		
		if (sensor.is_collision_solid_top() && ysp < 0) {
	
			sensor.set_angle(180);
			var _ang = sensor.get_ground_angle();
			if (_ang == 0) 
				_ang = sensor.get_landing_ground_angle();
			
		
			if ((_ang >= 91 && _ang <= 135) || (_ang >= 226 && _ang <= 270)) {
				sensor.set_angle(_ang);
				ground = true;
				gsp = ysp * -sign(dsin(sensor.get_angle()));
			
				player_landing();
			} else {
				sensor.set_angle(0);	
				ysp = 0;
			}
		}

		
		
		

		// Landing
		
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
					gsp = ysp / 2 * -sign(dsin(sensor.get_angle()));
			
			} else if ( _ang >= 46 &&  _ang <= 100) {
				if (abs(xsp) > abs(ysp))
					gsp = xsp;
				else 
					gsp = ysp * -sign(dsin(sensor.get_angle()));
			}
			
			xsp = gsp *  dcos(sensor.get_angle());
			ysp = gsp * -dsin(sensor.get_angle());
			
			player_landing();
		}
	}
	
	if (ground) {
		_cos_ang = dcos(sensor.get_angle());
		_sin_ang = dsin(sensor.get_angle());
		
		while (sensor.is_collision_solid_bottom()) {
			sensor.set_position(
				sensor.get_position().x - _sin_ang,
				sensor.get_position().y - _cos_ang,
			);
		}
		
		while (!sensor.is_collision_solid_bottom() && 
				sensor.is_collision_ground()
		) {
			sensor.set_position(
				sensor.get_position().x + _sin_ang,
				sensor.get_position().y + _cos_ang,
			);
		}
		
		while (sensor.is_collision_solid_bottom()) {
			sensor.set_position(
				sensor.get_position().x - _sin_ang / 1000,
				sensor.get_position().y - _cos_ang / 1000,
			);
		}
		
		x += sensor.get_position().x - x;
		y += sensor.get_position().y - y;
		
		var _new_ang	= sensor.get_ground_angle();
		sensor.set_angle(_new_ang);
		
			
		
		if (!sensor.is_collision_ground()) {
			sensor.set_angle(0);
			ground = false;
		} 
	} 
	
	
	

}

