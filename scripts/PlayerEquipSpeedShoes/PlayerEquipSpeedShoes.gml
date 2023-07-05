
function player_equip_speed_shoes() {
	o_dj.set_music("speed_shoes");
	
	timer_speed_shoes.reset();
	timer_speed_shoes.start();
	
	physics.apply_super_fast_shoes();	
}