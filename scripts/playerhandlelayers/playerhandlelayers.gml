// Ресурсы скриптов были изменены для версии 2.3.0, подробности см. по адресу
// https://help.yoyogames.com/hc/en-us/articles/360005277377
function player_handle_layers() {
	
	if (place_meeting(x, y, objLayerSwitch)) {
		collision_detector.set_layer((gsp > 0) ? 1 : 0);	
	}
	
	if (place_meeting(x, y,objLayerToHigh)) {
		collision_detector.set_layer(0);	
	}
	
	if (place_meeting(x, y,objLayerToLow)) {
		collision_detector.set_layer(1);
	}
}