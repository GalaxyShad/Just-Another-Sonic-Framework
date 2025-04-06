function PlayerStateJump() : BaseState() constructor {
	
	/// @param {Struct.Player} plr
	on_start = function(plr) { 
		plr.animator.set("curling");
	};
	
	/// @param {Struct.Player} plr
	on_step = function(plr) { 
		if (!plr.is_input_jump() && plr.ysp < plr.physics.jump_release)
			plr.ysp = plr.physics.jump_release;
	};
	
	/// @param {Struct.Player} plr
	on_landing = function(plr) { 
		plr.state_machine.change_to("normal");	
	};

	/// @param {Struct.Player} plr
	on_animate = function(plr) { 
		plr.animator.set_image_speed(0.5 + abs(plr.gsp) / 8.0);
	};
}