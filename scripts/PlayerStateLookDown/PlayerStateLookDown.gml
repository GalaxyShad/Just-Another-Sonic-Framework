

function PlayerStateLookDown() : BaseState() constructor {
	on_start = function(player) { with player {
		//allow_jump = false;
		//allow_movement = false;
		behavior_loop.disable(player_behavior_jump);
		behavior_loop.disable(player_behavior_ground_movement);
		animator.set("look_down");
	}};
	
	on_exit = function(player) { with player {
		//allow_jump = true;
		//allow_movement = true;
		behavior_loop.enable(player_behavior_jump);
		behavior_loop.enable(player_behavior_ground_movement);
	}};
	
	on_step = function(player) { with player {
		if (!is_key_down || !ground || is_key_left || is_key_right)
			state.change_to("normal");
		else if (abs(gsp) >= 1.0)
			state.change_to("roll");
			
		if (ground && is_key_action_pressed)
			state.change_to("spindash");	
	}};
}