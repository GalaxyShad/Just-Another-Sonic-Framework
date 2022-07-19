// Ресурсы скриптов были изменены для версии 2.3.0, подробности см. по адресу
// https://help.yoyogames.com/hc/en-us/articles/360005277377
function player_switch_sensor_radius() {
	if (action == ACT_ROLL || action == ACT_JUMP) {
		sensor.floor_box.hradius = 7;
		sensor.floor_box.vradius = 14;
		
		if (action == ACT_ROLL)
			camera.offset_y = -6;
		else
			camera.offset_y = 0;
	} else {
		sensor.floor_box.hradius = 8;
		sensor.floor_box.vradius = 20;	
		camera.offset_y = 0;
	}
}