function PlayerStateJump() : BaseState() constructor {
	on_start = function(player) { with player {
		animator.set("curling");
	}};
	
	on_step = function(player) { with (player) {
		if (!is_key_action && ysp < physics.jump_release)
			ysp = physics.jump_release;
	}};
	
	on_landing = function(player) { with (player) {	
		state.change_to("normal");	
	}};

	on_animate = function(player) { with player {
		animator.set_image_speed(0.5 + abs(gsp) / 8.0);
	}};
}