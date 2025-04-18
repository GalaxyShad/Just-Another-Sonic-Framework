
function player_set_shield(_shield) {
	if (plr.physics.is_underwater() && is_shield_water_flushable(_shield)) 
		return;
		
	plr.shield = _shield;
	plr.shield.play_pickup_sound();
}