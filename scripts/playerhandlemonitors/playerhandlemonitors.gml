// Ресурсы скриптов были изменены для версии 2.3.0, подробности см. по адресу
// https://help.yoyogames.com/hc/en-us/articles/360005277377
function PlayerHandleMonitors(){
	
	
	var oMonitor = noone; 
	

	if (ground) {
		oMonitor = sensor.collision_object(objMonitor, 6);
		
		if (oMonitor != noone && state.current() == "roll" && abs(gsp) >= 2) {
			with oMonitor instance_destroy();
		}
			
	} else {
		oMonitor =  sensor.check_expanded(0, 7, function() { return sensor.collision_top(objMonitor); });
		
		if (oMonitor != noone && ysp < 0) {
			ysp = 0;
			oMonitor.is_falling = true;
			oMonitor.vspeed = -1.5;
		}
			
		oMonitor = sensor.collision_object(objMonitor, 6);	
		
		if (oMonitor != noone && is_player_sphere() && ysp > 0) {	
			with oMonitor instance_destroy();
			if(state.current() != "glide") ysp *= -1;
		}
		
	}
	
	
	

}