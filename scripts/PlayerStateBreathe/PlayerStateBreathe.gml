


function PlayerStateBreathe() : BaseState() constructor {
	__timer = undefined;
	
	on_start = function(player) {
		__timer = 20;
		player.animator.set("breathe");
	};
	
	on_step = function(player) {
		if (__timer > 0)
			__timer--;
		else with player {
			state.change_to("normal");
		}
	};
}