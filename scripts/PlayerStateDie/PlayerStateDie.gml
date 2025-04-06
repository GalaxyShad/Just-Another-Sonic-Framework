
function PlayerStateDie() : BaseState() constructor {
	/// @param {Struct.Player} plr
	on_start = function(plr) {
		audio_play_sound(sndHurt, 0, false);	
		
		plr.xsp = 0;
		plr.ysp = -7;
		
		plr.animator.set("die");

		plr.inst.behavior_loop.disable_all();
		
		plr.inst.handle_loop.disable_all();
	};
	
	/// @param {Struct.Player} plr
	on_step = function(plr) { 
		plr.ysp += plr.physics.gravity_force;
	
		plr.inst.y += plr.ysp;
	
		plr.inst.camera.set_lag_timer(1);
	};
}