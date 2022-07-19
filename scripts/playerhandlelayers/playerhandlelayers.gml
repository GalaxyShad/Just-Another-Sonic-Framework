// Ресурсы скриптов были изменены для версии 2.3.0, подробности см. по адресу
// https://help.yoyogames.com/hc/en-us/articles/360005277377
function PlayerHandleLayers() {
	
	if (sensor.collision_object(objLayerSwitch)) {
		if (gsp > 0) {
			sensor.layer = 1;	
		} else {
			sensor.layer = 0;
		}
	}
	
	if (sensor.collision_object(objLayerToHigh)) {
		sensor.layer = 0;
	}
	
	if (sensor.collision_object(objLayerToLow)) {
		sensor.layer = 1;
	}
}