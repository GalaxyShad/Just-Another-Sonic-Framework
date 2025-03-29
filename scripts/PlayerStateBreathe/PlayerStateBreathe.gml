


function PlayerStateBreathe() : BaseState() constructor {
	__timer = undefined;
	
	/// @param {Struct.Player} plr
	on_start = function(plr) {
		__timer = 20;
		plr.animator.set("breathe");
	};
	
	/// @param {Struct.Player} plr
	on_step = function(plr) {
		if (__timer > 0)
			__timer--;
		else {
			plr.state_machine.change_to("normal");
		}
	};
}