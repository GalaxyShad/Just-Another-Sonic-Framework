// Ресурсы скриптов были изменены для версии 2.3.0, подробности см. по адресу
// https://help.yoyogames.com/hc/en-us/articles/360005277377
function player_switch_sensor_radius() {
	if (state.current() == "roll"		|| 
		state.current() == "jump"		|| 
		state.current() == "dropdash"		
	) {
		sensor.set_floor_box(SENSOR_FLOORBOX_ROLL);	
		camera.offset_y = (action == ACT_ROLL) ? -6 : 0;
	/*
	} else if(
		state.current() == "glid"		||
		state.current() == "land"		||
		state.current() == "clamb"
	) {
		sensor.set_floor_box(SENSOR_FLOORBOX_GLID);
		camera.offset_y = (action == ACT_ROLL) ? -6 : 0;
	*/
	} else {
		sensor.set_floor_box(SENSOR_FLOORBOX_NORMAL);
		camera.offset_y = 0;
	}
}