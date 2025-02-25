
function PlayerStateDie() : BaseState() constructor {
	on_start = function(player) {with (player) {
		audio_play_sound(sndHurt, 0, false);	
		
		plr.xsp = 0;
		plr.ysp = -7;
		
		animator.set("die");
		
		behavior_loop.disable_all();
		handle_loop.disable_all();
	}};
	
	on_step = function(player) { with player {
		plr.ysp += physics.gravity_force;
	
		y += plr.ysp;
	
		camera.set_lag_timer(1);
	}};
}