
/// @param {Struct.Player} plr
function player_handle_springs(plr) {

	var f = function(s) {
		var _spring_angle = 0;
		var _o_spring;
		
		if (s == PlayerCollisionDetectorSensor.Bottom || s == PlayerCollisionDetectorSensor.Top) {
			_o_spring = plr.collider.collision_object_exp(s, objSpringYellow, 0, 2);
		} else {
			_o_spring = plr.collider.collision_object_exp(s, objSpringYellow, 2, 0);
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
				plr.collider.get_angle_data().degrees, 
				_o_spring.image_angle + _spring_angle
			)
		);

		return (_ang_dif < 45) ? _o_spring : noone;
	};

	var _o_spring = f(PlayerCollisionDetectorSensor.Bottom);
	if (_o_spring != noone) {
		if (!plr.ground) plr.ysp = 0;

		if (_o_spring.reset_plr_speed) {
			plr.xsp = -_o_spring.xsp;
			plr.ysp = -_o_spring.ysp;
		} else {
			plr.xsp += -_o_spring.xsp;
			plr.ysp += -_o_spring.ysp;
		}

		plr.ground = false;

		plr.state_machine.change_to("spring");

		audio_play_sound(sndSpring, 0, false);

		_o_spring.image_speed = 1.00;	
	}
	
	_o_spring = f(PlayerCollisionDetectorSensor.Right);
	if (_o_spring) {
		if (plr.state_machine.current() != "roll" && plr.state_machine.current() != "skid") 
			plr.state_machine.change_to("normal");
		
		if (plr.ground) 
			plr.gsp = -_o_spring.spd;
		else 
			plr.xsp = -_o_spring.spd;

		_o_spring.image_speed = 1.00;

		audio_play_sound(sndSpring, 0, false);
	}
	
	_o_spring = f(PlayerCollisionDetectorSensor.Left);
	if (_o_spring) {
		if (plr.state_machine.current() != "roll" && plr.state_machine.current() != "skid") 
			plr.state_machine.change_to("normal");
		
		if (plr.ground) 
			plr.gsp = _o_spring.spd;
		else 
			plr.xsp = _o_spring.spd;

		_o_spring.image_speed = 1.00;

		audio_play_sound(sndSpring, 0, false);
	}
	
	_o_spring = f(PlayerCollisionDetectorSensor.Top);
	if (_o_spring && !plr.ground) {
		plr.ysp = _o_spring.spd;

		_o_spring.image_speed = 1.00;

		audio_play_sound(sndSpring, 0, false);
	}
}


