
function PlayerStateLookUp() : BaseState() constructor {
	/// @param {Struct.Player} plr
	on_start = function(plr) { 
		plr.behavior_loop.disable(player_behavior_ground_movement);
		plr.animator.set("look_up");
	};
	
	/// @param {Struct.Player} plr
	on_exit = function(plr) { 
		plr.behavior_loop.enable(player_behavior_ground_movement);
	};
	
	/// @param {Struct.Player} plr
	on_step = function(plr) { 
		if (plr.input_y() > -1 || !plr.ground || plr.gsp != 0)
			plr.state_machine.change_to("normal");
	};
}