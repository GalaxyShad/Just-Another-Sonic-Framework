// Ресурсы скриптов были изменены для версии 2.3.0, подробности см. по адресу
// https://help.yoyogames.com/hc/en-us/articles/360005277377
function player_handle_layers() {
	
	if (sensor.collision_object(objLayerSwitch)) {
		sensor.set_layer((gsp > 0) ? 1 : 0);	
	}
	
	if (sensor.collision_object(objLayerToHigh)) {
		sensor.set_layer(0);	
	}
	
	if (sensor.collision_object(objLayerToLow)) {
		sensor.set_layer(1);
	}
}