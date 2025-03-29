
/// @param {Struct.Player} plr
function player_landing(plr) {
	var _states = ["roll", "spring"]; 
	
	if (array_contains(_states, plr.state_machine.current())) {
		plr.state_machine.change_to("normal");
			
		y -= 5 * plr.collider.get_angle_data().cos;
		x += 5 * plr.collider.get_angle_data().sin;
	}
	
	plr.state_machine.landing();

	plr.bounced_chain_count = 0;
	
	player_switch_sensor_radius(plr);	
}