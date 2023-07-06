

function PlayerStatePush() : BaseState() constructor {
	on_step = function(player) { with player {
		xsp = 0;
		gsp = 0;
	
		if ((image_xscale == +1 && !is_key_right) || 
			(image_xscale == -1 && !is_key_left)
		) {
			state.change_to("normal");
		}
	}};
	
	on_animate = function(player) { with player {
		animator.set("push");
	}};
}