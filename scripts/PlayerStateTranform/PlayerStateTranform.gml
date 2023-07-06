


function PlayerStateTransform() : BaseState() constructor {
	on_start = function(player) { with player {
		ground = false;
		animator.set("transform");
		allow_movement = false;
	}};
	
	on_animate = function(player) { with player {
		ysp = 0;
		xsp = 0;
		
		if (animator.get_image_index() >= 12 && !physics.is_super()) {
			player_set_super_form();	
			audio_play_sound(sndPlrTransform, 0,0);
		}
		
		if (animator.is_animation_ended())
			state.change_to("normal");
	}};
	
	on_exit = function(player) {
		player.allow_movement = true;	
	};
}