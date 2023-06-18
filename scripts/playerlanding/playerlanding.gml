// Ресурсы скриптов были изменены для версии 2.3.0, подробности см. по адресу
// https://help.yoyogames.com/hc/en-us/articles/360005277377
function player_landing() {
	
	
	
	var _states = ["roll", "spring"]; 
	
	if (array_contains(_states, state.current())) {
		state.change_to("normal");
			
		y -= 5 * dcos(sensor.get_angle());
		x += 5 * dsin(sensor.get_angle());
	}
	
	state.landing();
	
	
	
	player_switch_sensor_radius();
	
}