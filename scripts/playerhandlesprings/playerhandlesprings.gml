// Ресурсы скриптов были изменены для версии 2.3.0, подробности см. по адресу
// https://help.yoyogames.com/hc/en-us/articles/360005277377
function player_handle_springs(){
	var _o_spring = sensor.check_expanded(0, 2, function() { return sensor.collision_bottom(objSpringYellow);} );
	if (_o_spring) {
		if (abs(angle_difference(sensor.get_angle(), _o_spring.image_angle)) < 60 && _o_spring.image_speed == 0) {
			if (!ground)ysp = 0;
			ysp += -_o_spring.spd * dcos(_o_spring.image_angle);
			xsp += -_o_spring.spd * dsin(_o_spring.image_angle);
			ground = false;
			state.change_to("spring");
			audio_play_sound(sndSpring, 0, false);
			_o_spring.image_speed = 1.00;
		}
	}
	
	_o_spring = sensor.check_expanded(2, 0, function() { return sensor.collision_right(objSpringYellow);} );
	if (_o_spring) {
		if (abs(angle_difference(sensor.get_angle(), _o_spring.image_angle - 90)) < 60 && _o_spring.image_speed == 0) {
			if(state.current() != "roll") state.change_to("normal");
			if (ground) gsp = -_o_spring.spd;
			else xsp = -_o_spring.spd;
			_o_spring.image_speed = 1.00;
			audio_play_sound(sndSpring, 0, false);
		}
	}
	
	_o_spring = sensor.check_expanded(2, 0, function() { return sensor.collision_left(objSpringYellow);} );
	if (_o_spring) {
		if (abs(angle_difference(sensor.get_angle(), _o_spring.image_angle + 90)) < 60 && _o_spring.image_speed == 0) {	
			if(state.current() != "roll") state.change_to("normal");
			if (ground) gsp = _o_spring.spd;
			else xsp = _o_spring.spd;
			_o_spring.image_speed = 1.00;
			audio_play_sound(sndSpring, 0, false);
		}
	}
	
	_o_spring = sensor.check_expanded(0, 2, function() { return sensor.collision_top(objSpringYellow);} );
	if (_o_spring && !ground) {
		if (abs(angle_difference(sensor.get_angle(), _o_spring.image_angle + 180)) < 15 && _o_spring.image_speed == 0) {	
			//if(state.current() != "roll") state.change_to("normal");
			ysp = _o_spring.spd;
			_o_spring.image_speed = 1.00;
			audio_play_sound(sndSpring, 0, false);
		}
	}
}


