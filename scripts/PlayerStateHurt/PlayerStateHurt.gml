


function PlayerStateHurt() : BaseState() constructor {
	/// @param {Struct.Player} plr
	on_start = function(plr) {
		plr.inst.behavior_loop.disable(player_behavior_air_movement);
		//allow_movement = false;		
		
		plr.xsp = -2 * sign(plr.inst.image_xscale);
		plr.ysp = -4;
		
		if (plr.physics.is_underwater()) {
			plr.xsp /= 2;
			plr.ysp /= 2;
		}
		
		plr.animator.set("hurt");
	};
	
	/// @param {Struct.Player} plr
	on_exit = function(plr) {
		plr.inst.behavior_loop.enable(player_behavior_air_movement);
	};
	
	/// @param {Struct.Player} plr
	on_landing = function(plr) {
		plr.inst.timer_invincibility.reset_and_start();
		
		plr.state_machine.change_to("normal");
		
		plr.gsp = 0;
		plr.xsp = 0;
	};
}