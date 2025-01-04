
function player_handle_enemy() {
	
	var _o_enemy = sensor.collision_object(parEnemy, 0);
	
	if (_o_enemy == noone)
		return;
		
	if (is_player_sphere()) {
		instance_destroy(_o_enemy);
		
		if (!ground) {
			if (ysp > 0)
				ysp *= -1;
			else 
				ysp -= sign(ysp);
		} 
			
	} else {
		player_get_hit();			
	}	
}