

function PlayerStateSkid() : BaseState() constructor {
	on_step = function(player) { with player {
		if (abs(gsp) <= 0.5 || !ground || 
		    ((gsp < 0 && is_key_left) || (gsp > 0 && is_key_right))
		) {
			state.change_to("normal");	
		}
	}};
	
	on_start = function(player) { with player {
		animator.set("skid");
	}};
}