
function PlayerStateSpring() : BaseState() constructor {
	on_start = function(player) {
		player.animator.set("spring");
	};
	
	on_animate = function(player) { with player {
		if (ysp <= 0)	{
			animator.set_image_speed(max(0.05, abs(ysp) / 16) * (animator.get_frames_count() / 5));
			animator.set("spring");
		}
	}};
	
	on_step = function(player) { with player {
		if (ysp > 0) state.change_to("normal");
	}};
}
		/*else {
			animator.set_image_speed(0.25);
			animator.set("walking");
			
			//Why animator and not status?
			//Because they will all be standing in the air
			//Then why not check air movement in the animator status normal?
			//Because it is
		}*/