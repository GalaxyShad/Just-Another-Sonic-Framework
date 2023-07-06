
function PlayerStateLookUp() : BaseState() constructor {
	on_start = function(player) { with player {
		allow_jump = false;	
		allow_movement = false;	
		animator.set("look_up");
	}};
	
	on_exit = function(player) { with player {
		allow_jump = true;	
		allow_movement = true;	
	}};
	
	on_step = function(player) { with (player) {
		if (!is_key_up || !ground || gsp != 0)
			state.change_to("normal");
			
		if (ground && is_key_action)
			state.change_to("peelout");
	}};
}