


function PlayerStateTransform() : BaseState() constructor {
	__timer = undefined;
	
	on_start = function(player) { with player {
		ground = false;
		animator.set("transform");
		//behavior_loop.disable(player_behavior_air_movement);
		allow_movement = false;
		other.__timer = 30;
	}};
	
	on_animate = function(player) { with player {
		ysp = 0;
		xsp = 0;
		
		if (animator.get_image_index() >= 12 && !physics.is_super()) {
			player_set_super_form();	
			audio_play_sound(sndPlrTransform, 0,0);
		}
		
		other.__timer--;
		
		if (other.__timer == 0)
			state.change_to("normal");
	}};
	
	on_exit = function(player) {
		player.allow_movement = true;
		//behavior_loop.enable(player_behavior_air_movement);
	};
}