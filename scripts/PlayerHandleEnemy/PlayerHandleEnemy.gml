
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

/// @param {Struct.Player} plr  
function player_handle_enemy(plr) {
	
	var _o_enemy = plr.collider.collision_object(parEnemy, PlayerCollisionDetectorSensor.MainDefault);
	
	if (_o_enemy == noone)
		return;
		
	if (is_player_sphere()) {

		plr.bounced_chain_count++;

		var _score_to_add = calculate_bounced_score(plr.bounced_chain_count);
		score += _score_to_add;

		instance_create_depth(_o_enemy.x, _o_enemy.y, -1, objEnemyFloatingScore, {
			text: string(_score_to_add)
		});
		instance_destroy(_o_enemy);

		if (!plr.ground) {
			if (plr.ysp > 0)
				plr.ysp = -plr.ysp;
			else 
				plr.ysp -= sign(plr.ysp);
		} 
			
	} else {
		player_get_hit();			
	}	
}

/// @param {Struct.Player} plr 
function player_handle_projectile(plr) {
	var _o_projectile = plr.collider.collision_object(objProjectile, PlayerCollisionDetectorSensor.MainDefault);
	
	if (_o_projectile != noone) {
		player_get_hit();
	}

}