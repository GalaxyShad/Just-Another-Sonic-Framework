
function player_equip_speed_shoes() {
	plr.o_dj.play_speed_shoes();
	
	plr.timer_speed_shoes.reset();
	plr.timer_speed_shoes.start();
	
	plr.physics.apply_super_fast_shoes();	
}