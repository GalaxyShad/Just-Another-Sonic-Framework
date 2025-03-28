
/// @param {Struct.Player} p  
function player_landing() {
	var _states = ["roll", "spring"]; 
	
	if (array_contains(_states, state.current())) {
		state.change_to("normal");
			
		y -= 5 * collision_detector.get_angle_data().cos;
		x += 5 * collision_detector.get_angle_data().sin;
	}
	
	state.landing();

	plr.bounced_chain_count = 0;
	
	player_switch_sensor_radius();	
}