// Ресурсы скриптов были изменены для версии 2.3.0, подробности см. по адресу
// https://help.yoyogames.com/hc/en-us/articles/360005277377
function player_switch_sensor_radius() {
	var _box;
	
	if (state.current() == "roll" || state.current() == "jump" || state.current() == "dropdash") {
		_box = SENSOR_FLOORBOX_ROLL;
	} else if (state.current() == "glide" || state.current() == "glideRotation" || state.current() == "climbe" || state.current() == "land") {
		_box = SENSOR_FLOORBOX_SPECIAL;
	} else {
		_box = SENSOR_FLOORBOX_NORMAL;
	}

	collision_detector.set_radius({ 
		width:  _box[0], 
		height: _box[1] 
	}, 10);

	camera.offset_y = (state.current() == "roll") ? -5 : 0;
}