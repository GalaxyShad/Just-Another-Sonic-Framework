
function player_equip_speed_shoes() {
	o_dj.play_speed_shoes();
	
	timer_speed_shoes.reset();
	timer_speed_shoes.start();
	
	plr.physics.apply_super_fast_shoes();	
}