
function player_behavior_apply_gravity() {
	if (plr.ground) return;
		
	plr.ysp += physics.gravity_force;
	
	if (plr.ysp > 16) 
		plr.ysp = 16;
}

function player_behavior_air_movement() {
	if (plr.ground) return;
	
	if (!allow_movement)
		return;

	if (is_key_left && plr.xsp > -physics.top_speed) 
		plr.xsp -= physics.air_acceleration_speed;
	else if (is_key_right && plr.xsp < physics.top_speed) 
		plr.xsp += physics.air_acceleration_speed;
}

function player_behavior_air_drag() {
	if (plr.ground) return;
	
	if (plr.ysp < 0 && plr.ysp > -4) {
	    plr.xsp -= (((plr.xsp * 1_000) div 125) / 256_000);
	}	
}
