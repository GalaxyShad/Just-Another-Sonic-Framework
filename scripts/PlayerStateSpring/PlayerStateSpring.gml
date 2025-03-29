
function PlayerStateSpring() : BaseState() constructor {
	/// @param {Struct.Player} plr
	on_start = function(plr) {
		plr.animator.set("spring");
	};
	
	/// @param {Struct.Player} plr
	on_animate = function(plr) { 
		if (plr.ysp <= 0)	{
			plr.animator.set_image_speed(max(0.05, abs(plr.ysp) / 16) * (plr.animator.get_frames_count() / 5));
			plr.animator.set("spring");
		}
	};
	
	/// @param {Struct.Player} plr
	on_step = function(plr) { 
		if (plr.ysp > 0) plr.state_machine.change_to("normal");
	};
}