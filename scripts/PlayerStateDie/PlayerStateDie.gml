
function PlayerStateDie() : BaseState() constructor {
	on_start = function(player) {with (player) {
		audio_play_sound(sndHurt, 0, false);	
		
		xsp = 0;
		ysp = -7;
		
		animator.set("die");
		
		behavior_loop.disable_all();
		handle_loop.disable_all();
	}};
	
	on_step = function(player) { with player {
		ysp += physics.gravity_force;
	
		y += ysp;
	
		camera.set_lag_timer(1);
	}};
}