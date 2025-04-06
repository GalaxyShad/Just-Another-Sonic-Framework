/// @param {Struct.Player} plr
function player_handle_monitors(plr){
	var _o_monitor = noone; 

	if (plr.ground) {
		_o_monitor = plr.collider.check_expanded(
			6, 6,
			function (plr) { return plr.collider.collision_object(objMonitor, PlayerCollisionDetectorSensor.MainDefault) },
			plr
		);

		if (_o_monitor != noone && plr.state_machine.current() == "roll" && abs(plr.gsp) >= 2) {
			_o_monitor.destroy();
		}
			
	} else {
		_o_monitor = plr.collider.check_expanded(
			0, 7,
			function (plr) { return plr.collider.collision_object(objMonitor, PlayerCollisionDetectorSensor.Top) },
			plr
		);
		
		if (_o_monitor != noone && plr.ysp < 0) {
			plr.ysp = 0;
			_o_monitor.is_falling = true;
			_o_monitor.vspeed = -1.5;
		}
			
		_o_monitor = plr.collider.check_expanded(
			6, 6,
			function (plr) { return plr.collider.collision_object(objMonitor, PlayerCollisionDetectorSensor.MainDefault) },
			plr
		);
		if (_o_monitor != noone && plr.is_can_break_monitor() && plr.ysp > 0) {	
			_o_monitor.destroy(self);
			plr.ysp *= -1;
		}	
	}
}