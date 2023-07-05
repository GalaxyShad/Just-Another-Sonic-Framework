
function player_set_shield(_shield) {
	if (physics.is_underwater() && is_shield_water_flushable(_shield)) 
		return;
		
	shield = _shield;
	shield.play_pickup_sound();
}