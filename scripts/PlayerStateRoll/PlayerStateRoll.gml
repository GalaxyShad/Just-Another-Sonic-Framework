

function PlayerStateRoll() : BaseState() constructor {
	on_start = function(player) { with player {
		animator.set("curling");
	}};
	
	on_step = function(player) { with player {
		var _agsp = abs(gsp);
		
		if (_agsp < 0.5)
			state.change_to("normal");
	}};
	
	on_animate = function(player) { with player {
		animator.set_image_speed(0.5 + abs(gsp) / 8.0);
	}};
}