
/// @param {Struct.Player} plr
function player_behavior_apply_gravity(plr) {
	if (plr.ground) return;
		
	plr.ysp += plr.physics.gravity_force;
	
	if (plr.ysp > 16) 
		plr.ysp = 16;
}

/// @param {Struct.Player} plr
function player_behavior_air_movement(plr) {
	if (plr.ground) return;

	if (plr.input_x() < 0 && plr.xsp > -plr.physics.top_speed) 
		plr.xsp -= plr.physics.air_acceleration_speed;
	else if (plr.input_x() > 0 && plr.xsp < plr.physics.top_speed) 
		plr.xsp += plr.physics.air_acceleration_speed;
}

/// @param {Struct.Player} plr
function player_behavior_air_drag(plr) {
	if (plr.ground) return;
	
	if (plr.ysp < 0 && plr.ysp > -4) {
	    plr.xsp -= (((plr.xsp * 1_000) div 125) / 256_000);
	}	
}
