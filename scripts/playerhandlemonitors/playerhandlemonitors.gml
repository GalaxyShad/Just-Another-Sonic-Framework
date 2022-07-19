// Ресурсы скриптов были изменены для версии 2.3.0, подробности см. по адресу
// https://help.yoyogames.com/hc/en-us/articles/360005277377
function PlayerHandleMonitors(){
	
	
	var oMonitor = noone; 
	

	if (ground) {
		oMonitor = sensor.collision_object(objMonitor, 4+abs(gsp)*2);
		
		if (oMonitor != noone && action == ACT_ROLL && abs(gsp) >= 2) {
			with oMonitor instance_destroy();
		}
			
	} else {
		oMonitor = sensor.is_collision_top(objMonitor, -ysp*2);
		
		if (oMonitor != noone && ysp < 0) {
			ysp = 0;
			oMonitor.is_falling = true;
			oMonitor.vspeed = -2;
		}
			
		oMonitor = sensor.collision_object(objMonitor, ysp*2);	
		
		if (oMonitor != noone && (action == ACT_JUMP || action == ACT_ROLL) && ysp > 0) {	
			with oMonitor instance_destroy();
			ysp *= -1;
		}
		
	}
	
	
	

}