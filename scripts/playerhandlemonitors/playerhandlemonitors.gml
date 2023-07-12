// Ресурсы скриптов были изменены для версии 2.3.0, подробности см. по адресу
// https://help.yoyogames.com/hc/en-us/articles/360005277377
function player_handle_monitors(){
	var _o_monitor = noone; 

	if (ground) {
		_o_monitor = sensor.collision_object(objMonitor, 6);
		
		if (_o_monitor != noone && state.current() == "roll" && abs(gsp) >= 2) {
			_o_monitor.destroy(self);
		}
			
	} else {
		_o_monitor =  sensor.check_expanded(0, 7, function() { return sensor.collision_top(objMonitor); });
		if (_o_monitor != noone && ysp < 0) {
			ysp = 0;
			_o_monitor.is_falling = true;
			_o_monitor.vspeed = -1.5;
		}
			
		_o_monitor = sensor.collision_object(objMonitor, 6);
		if (_o_monitor != noone && is_player_sphere() && ysp > 0) {	
			_o_monitor.destroy(self);
			ysp *= -1;
		}	
	}
}