
function PlayerStateDie() : BaseState() constructor {
	on_start = function(player) {with (player) {
		audio_play_sound(sndHurt, 0, false);	
		
		xsp = 0;
		ysp = -7;
		
		animator.set("die");
	}};
}