
function player_handle_enemy() {
	
	var _o_enemy = collision_detector.collision_object(parEnemy, PlayerCollisionDetectorSensor.MainDefault);
	
	if (_o_enemy == noone)
		return;
		
	if (is_player_sphere()) {
		instance_create_depth(_o_enemy.x, _o_enemy.y, -1, objEnemyFloatingScore);
		instance_destroy(_o_enemy);

		
		if (!ground) {
			if (ysp > 0)
				ysp = -ysp;
			else 
				ysp -= sign(ysp);
		} 
			
	} else {
		player_get_hit();			
	}	
}