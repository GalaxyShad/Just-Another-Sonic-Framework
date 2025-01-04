
function PlayerStateLookUp() : BaseState() constructor {
	on_start = function(player) { with player {
		behavior_loop.disable(player_behavior_ground_movement);
		//allow_movement = false;	
		animator.set("look_up");
	}};
	
	on_exit = function(player) { with player {
		behavior_loop.enable(player_behavior_ground_movement);
		//allow_movement = true;	
	}};
	
	on_step = function(player) { with (player) {
		if (!is_key_up || !ground || gsp != 0)
			state.change_to("normal");
	}};
}