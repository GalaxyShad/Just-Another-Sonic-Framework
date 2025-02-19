
function calculate_bounced_score(_bounced) {
	switch (_bounced) {
		case 1: return 100;
		case 2: return 200;
		case 3: return 500;
	}

	if (_bounced < 16) {
		return 1000;
	}

	return 10000;
}

/// @param {Struct.Player} p  
function player_handle_enemy(p) {
	
	var _o_enemy = collision_detector.collision_object(parEnemy, PlayerCollisionDetectorSensor.MainDefault);
	
	if (_o_enemy == noone)
		return;
		
	if (is_player_sphere()) {

		p.bounced_chain_count++;

		var _score_to_add = calculate_bounced_score(p.bounced_chain_count);
		score += _score_to_add;

		instance_create_depth(_o_enemy.x, _o_enemy.y, -1, objEnemyFloatingScore, {
			text: string(_score_to_add)
		});
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

function player_handle_projectile() {
	var _o_projectile = collision_detector.collision_object(objProjectile, PlayerCollisionDetectorSensor.MainDefault);
	
	if (_o_projectile != noone) {
		player_get_hit();
	}

}