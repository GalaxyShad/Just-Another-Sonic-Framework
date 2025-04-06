

function PlayerStateLookDown() : BaseState() constructor {
	/// @param {Struct.Player} plr
	on_start = function(plr) { 
		plr.inst.behavior_loop.disable(player_behavior_jump);
		plr.inst.behavior_loop.disable(player_behavior_ground_movement);
		plr.animator.set("look_down");
	};
	
	/// @param {Struct.Player} plr
	on_exit = function(plr) { 
		plr.inst.behavior_loop.enable(player_behavior_jump);
		plr.inst.behavior_loop.enable(player_behavior_ground_movement);
	};
	
	/// @param {Struct.Player} plr
	on_step = function(plr) { 
		if ((plr.input_y() != 1) || !plr.ground || plr.input_x() != 0)
			plr.state_machine.change_to("normal");
		else if (abs(plr.gsp) >= 1.0)
			plr.state_machine.change_to("roll");
			
		if (plr.ground && plr.is_input_jump())
			plr.state_machine.change_to("spindash");	
	};
}