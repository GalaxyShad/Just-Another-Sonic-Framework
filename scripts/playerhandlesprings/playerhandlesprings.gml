
function player_handle_springs() {

	var f = function(s) {
		var _spring_angle = 0;
		var _o_spring = collision_detector.collision_object_exp(s, objSpringYellow, 2, 2);
		if (_o_spring == noone){	
			_o_spring = collision_detector.collision_object_exp(s, objSpringYellowDiagonal, 2, 2);
			_spring_angle = -45;
		}
		if (_o_spring == noone) return noone;


		switch (s) {
			case PlayerCollisionDetectorSensor.Bottom: _spring_angle = 0; break;
			case PlayerCollisionDetectorSensor.Right:  _spring_angle = -90; break;
			case PlayerCollisionDetectorSensor.Left:   _spring_angle = +90; break;
			case PlayerCollisionDetectorSensor.Top:    _spring_angle = 180; break;
		}

		var _ang_dif = abs(
			angle_difference(
				collision_detector.get_angle_data().degrees, 
				_o_spring.image_angle + _spring_angle
			)
		);

		return (_ang_dif < 45) ? _o_spring : noone;
	};

	var _o_spring = f(PlayerCollisionDetectorSensor.Bottom);
	if (_o_spring != noone) {
		if (!ground) ysp = 0;

		ysp += -_o_spring.spd * dcos(_o_spring.image_angle);
		xsp += -_o_spring.spd * dsin(_o_spring.image_angle);

		ground = false;

		state.change_to("spring");

		audio_play_sound(sndSpring, 0, false);

		_o_spring.image_speed = 1.00;	
	}
	
	_o_spring = f(PlayerCollisionDetectorSensor.Right);
	if (_o_spring) {
		if (state.current() != "roll" && state.current() != "skid") 
			state.change_to("normal");
		
		if (ground) 
			gsp = -_o_spring.spd;
		else 
			xsp = -_o_spring.spd;

		_o_spring.image_speed = 1.00;

		audio_play_sound(sndSpring, 0, false);
	}
	
	_o_spring = f(PlayerCollisionDetectorSensor.Left);
	if (_o_spring) {
		if (state.current() != "roll" && state.current() != "skid") 
			state.change_to("normal");
		
		if (ground) 
			gsp = _o_spring.spd;
		else 
			xsp = _o_spring.spd;

		_o_spring.image_speed = 1.00;

		audio_play_sound(sndSpring, 0, false);
	}
	
	_o_spring = f(PlayerCollisionDetectorSensor.Top);
	if (_o_spring && !ground) {
		ysp = _o_spring.spd;

		_o_spring.image_speed = 1.00;

		audio_play_sound(sndSpring, 0, false);
	}
}


