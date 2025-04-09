// Tails by Adol

function TailsStateJump() : PlayerStateJump() constructor {	
	/// @param {Struct.Player} plr	
	override_on_step = function(plr) { 
		super(); 
		if (plr.is_input_jump_pressed()) {
			plr.state_machine.change_to("fly");
		}
	};
}

function TailsStateFly() : BaseState() constructor {
	FLY_GRAVITY_FORCE = 0.03125;
	FLY_FLYING_FORCE  = 0.125;
	
	/// @param {Struct.Player} plr	
	on_start = function(plr) {
		plr.inst.behavior_loop.disable(player_behavior_apply_gravity);

		__tired			= false;
		__time_fly		= 0;
		__fly_action	= false;

		audio_play_sound(sndFlying, 0, true);
	};
	
	/// @param {Struct.Player} plr	
	on_step = function(plr) {
		if(__fly_action && !plr.collider.is_collision_solid(PlayerCollisionDetectorSensor.Top)) 
			plr.ysp -= FLY_FLYING_FORCE;
		else 
			plr.ysp += FLY_GRAVITY_FORCE;
			
		if (__time_fly > 480) 
			__tired = true;
			
		if (!__tired) {
			if (plr.is_input_jump_pressed() && plr.ysp != 1) 
				__fly_action = true;
		}
		
		if (plr.ysp < -1 || __tired) 
			__fly_action = false;
		
		__time_fly++;
	};
	
	/// @param {Struct.Player} plr	
	on_animate = function(plr) {
		if (__tired) {
			if (!plr.physics.is_underwater()) plr.animator.set("fly_tired");
			else						  	  plr.animator.set("swim_tired");
		} else {
			if (!plr.physics.is_underwater()) plr.animator.set("fly");
			else						  	  plr.animator.set("swim");
		}
	};
	
	/// @param {Struct.Player} plr	
	on_landing = function(plr) {
		plr.state_machine.change_to("normal");
	};
	
	/// @param {Struct.Player} plr	
	on_exit = function(plr) {
		audio_stop_sound(sndFlying);
		plr.inst.behavior_loop.enable(player_behavior_apply_gravity);
	};
}
