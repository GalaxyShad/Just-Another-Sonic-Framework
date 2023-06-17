// Ресурсы скриптов были изменены для версии 2.3.0, подробности см. по адресу
// https://help.yoyogames.com/hc/en-us/articles/360005277377
function player_switch_sensor_radius() {
	if (action == ACT_ROLL || action == ACT_JUMP) {
		sensor.set_floor_box(SENSOR_FLOORBOX_ROLL);	
		camera.offset_y = (action == ACT_ROLL) ? -6 : 0;
	} else {
		sensor.set_floor_box(SENSOR_FLOORBOX_NORMAL);
		camera.offset_y = 0;
	}
}