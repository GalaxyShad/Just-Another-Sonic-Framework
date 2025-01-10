
function player_handle_monitors(){
	var _o_monitor = noone; 

	if (ground) {
		_o_monitor = collision_detector.check_expanded(
			6, 6,
			function () { return collision_detector.collision_object(objMonitor, PlayerCollisionDetectorSensor.MainDefault) }
		);

		if (_o_monitor != noone && state.current() == "roll" && abs(gsp) >= 2) {
			_o_monitor.destroy();
		}
			
	} else {
		_o_monitor = collision_detector.check_expanded(
			0, 7,
			function () { return collision_detector.collision_object(objMonitor, PlayerCollisionDetectorSensor.Top) }
		);
		
		if (_o_monitor != noone && ysp < 0) {
			ysp = 0;
			_o_monitor.is_falling = true;
			_o_monitor.vspeed = -1.5;
		}
			
		_o_monitor = collision_detector.check_expanded(
			6, 6,
			function () { return collision_detector.collision_object(objMonitor, PlayerCollisionDetectorSensor.MainDefault) }
		);
		if (_o_monitor != noone && is_player_sphere() && ysp > 0) {	
			_o_monitor.destroy(self);
			ysp *= -1;
		}	
	}
}