// Knuckles by Adol

function KnucklesStateJump() : PlayerStateJump() constructor {	
	/// @param {Struct.Player} plr
	override_on_step = function(plr) { 
		super(); 

		if (plr.is_input_jump_pressed()) {
			if (plr.ysp < 0) plr.ysp = 0;

			plr.xsp = 4 * sign(plr.inst.image_xscale);
			plr.state_machine.change_to("glide");
		}
	};
}

function KnucklesStateGlide() : BaseState() constructor {
	const_glide_acceleration  = 0.015625;
	const_glide_gravity_force = 0.125;
	
	/// @param {Struct.Player} plr
	on_start = function(plr) {
		plr.inst.behavior_loop.disable(player_behavior_apply_gravity);
		plr.inst.behavior_loop.disable(player_behavior_air_movement);
		plr.inst.visual_loop.disable(player_behavior_visual_flip);

		plr.animator.set("glide");
	};
	
	/// @param {Struct.Player} plr
	on_step = function(plr) {
		if (plr.ysp < 0.5) plr.ysp += const_glide_gravity_force;
		if (plr.ysp > 0.5) plr.ysp -= const_glide_gravity_force;

		if (plr.ysp > 16) plr.ysp = 16;

		if ((plr.collider.check_expanded(1, 0, plr.collider.is_collision_solid, PlayerCollisionDetectorSensor.Left)) || 
			(plr.collider.check_expanded(1, 0, plr.collider.is_collision_solid, PlayerCollisionDetectorSensor.Right))
		) {
			audio_play_sound(sndGrab, 0, false);
			plr.state_machine.change_to("climbe");
		}

		if (!plr.is_input_jump()) plr.state_machine.change_to("drop");

		plr.xsp += const_glide_acceleration * sign(plr.xsp);

		if ((plr.input_x() < 0 && plr.xsp > 0) || (plr.input_x() > 0 && plr.xsp < 0)) 
			plr.state_machine.change_to("glideRotation");
	};
	
	/// @param {Struct.Player} plr
	on_landing = function(plr) {
		plr.state_machine.change_to("land");
	};
	
	/// @param {Struct.Player} plr
	on_exit = function(plr) {
		plr.inst.behavior_loop.enable(player_behavior_apply_gravity);
		plr.inst.behavior_loop.enable(player_behavior_air_movement);
		plr.inst.visual_loop.enable(player_behavior_visual_flip);
	};
}

function KnucklesStateGlideRotation() : BaseState() constructor {
	const_glide_acceleration_rotation	= 2.8125;
	const_glide_acceleration  = 0.015625;
	const_glide_gravity_force = 0.125;

	__a = undefined;
	__t = undefined;
	__r = undefined;
	
	/// @param {Struct.Player} plr
	on_start = function(plr) { 
		plr.inst.behavior_loop.disable(player_behavior_apply_gravity);
		plr.inst.behavior_loop.disable(player_behavior_air_movement);
		
		plr.inst.visual_loop.disable(player_behavior_visual_flip);
		
		__a = 90 - 90 * plr.inst.image_xscale;
		__t = plr.xsp;
		__r = 1;

		plr.animator.set("glideRotation");
	};
	
	/// @param {Struct.Player} plr
	on_step = function(plr) {
		if (plr.ysp < 0.5) plr.ysp += const_glide_gravity_force;
		if (plr.ysp > 0.5) plr.ysp -= const_glide_gravity_force;

		if ((plr.collider.check_expanded(1, 0, plr.collider.is_collision_solid, PlayerCollisionDetectorSensor.Left)) || 
			(plr.collider.check_expanded(1, 0, plr.collider.is_collision_solid, PlayerCollisionDetectorSensor.Right))
		) {
			audio_play_sound(sndGrab, 0, false);
			plr.state_machine.change_to("climbe");
		}
		
		if (!plr.is_input_jump()) plr.state_machine.change_to("drop");
		
		if (plr.input_x() < 0) __r = 1;
		if (plr.input_x() > 0) __r = -1;
		
		__a += const_glide_acceleration_rotation * sign(__t) * __r;

		plr.xsp = abs(__t) * dcos(__a);
		
		if (dcos(__a) == 1 || dcos(__a) == -1) 
			plr.state_machine.change_to("glide");
	};
	
	/// @param {Struct.Player} plr
	on_animate = function(plr) {
		plr.animator.set("glideRotation");
		plr.animator.set_image_index(__a / 45);
	};
	
	/// @param {Struct.Player} plr
	on_landing = function(plr) {
		plr.state_machine.change_to("land");
	};
	
	/// @param {Struct.Player} plr
	on_exit = function(plr) { 
		if (sign(__t) != sign(plr.xsp)) plr.inst.image_xscale *= -1;

		plr.inst.behavior_loop.enable(player_behavior_apply_gravity);
		plr.inst.behavior_loop.enable(player_behavior_air_movement);
		plr.inst.visual_loop.enable(player_behavior_visual_flip);
	};
}

function KnucklesStateDrop() : BaseState() constructor {		
	/// @param {Struct.Player} plr
	on_start = function(plr) {
		plr.inst.behavior_loop.disable(player_behavior_ground_movement);
		plr.inst.behavior_loop.disable(player_behavior_air_movement);
		plr.inst.behavior_loop.disable(player_behavior_jump);

		drop_time = 0;
		
		plr.animator.set("drop");
	};
	
	/// @param {Struct.Player} plr
	on_animate = function(plr) {
		if (plr.ground) plr.animator.set("look_down");
	};
	
	/// @param {Struct.Player} plr
	on_step = function(plr) {
		if (plr.ground) {
			drop_time++;
			if (drop_time > 10) plr.state_machine.change_to("normal");
		}
	};
	
	/// @param {Struct.Player} plr
	on_landing = function(plr) {
		drop_time = 0;
		audio_play_sound(sndLand, 0, false);
		plr.gsp = 0;
	};
	
	/// @param {Struct.Player} plr
	on_exit = function(plr) { 
		plr.inst.behavior_loop.enable(player_behavior_ground_movement);
		plr.inst.behavior_loop.enable(player_behavior_air_movement);
		plr.inst.behavior_loop.enable(player_behavior_jump);
	};
}

function KnucklesStateClimbe() : BaseState() constructor {
	const_climbe_acceleration	= 1;
		
	/// @param {Struct.Player} plr
	on_start = function(plr) {
		plr.inst.behavior_loop.disable(player_behavior_apply_gravity);
		plr.inst.behavior_loop.disable(player_behavior_air_movement);
		plr.inst.visual_loop.disable(player_behavior_visual_flip);

		if (plr.collider.check_expanded(1, 0, plr.collider.is_collision_solid, PlayerCollisionDetectorSensor.Left)) 
			image_xscale = -1;
		else if(plr.collider.check_expanded(1, 0, plr.collider.is_collision_solid, PlayerCollisionDetectorSensor.Right)) 
			image_xscale = 1;

		plr.animator.set("climbe");
	};
	
	/// @param {Struct.Player} plr
	on_step = function(plr) {
		if (plr.is_input_jump_pressed()) {
			plr.inst.image_xscale *= -1;

			plr.xsp = 4 * plr.inst.image_xscale;
			plr.ysp = -4;

			plr.state_machine.change_to("jump");

			return;
		}

		plr.ysp = 0;

		if (plr.input_y() < 0 && !plr.collider.check_expanded(0, 1, plr.collider.is_collision_solid, PlayerCollisionDetectorSensor.Top)) 
			plr.ysp -= const_climbe_acceleration;
		if (plr.input_y() > 0) 
			plr.ysp += const_climbe_acceleration;
		
		if (!plr.collider.check_expanded(1, 0, plr.collider.is_collision_solid, PlayerCollisionDetectorSensor.Bottom) 
			|| plr.collider.check_expanded(-1, 1, plr.collider.is_collision_solid, PlayerCollisionDetectorSensor.Bottom)
		) { 
			plr.state_machine.change_to("drop"); return; 
		}
		
		if (!plr.collider.check_expanded(1, 0, plr.collider.is_collision_solid, PlayerCollisionDetectorSensor.Top)) { 
			plr.state_machine.change_to("clambering"); return; 
		}
	};
	
	/// @param {Struct.Player} plr
	on_animate = function(plr) {
		plr.animator.set_image_speed(plr.ysp/10);
	};
	
	/// @param {Struct.Player} plr
	on_exit = function(plr) {
		plr.inst.behavior_loop.enable(player_behavior_apply_gravity);
		plr.inst.behavior_loop.enable(player_behavior_air_movement);
		plr.inst.visual_loop.enable(player_behavior_visual_flip);
	};
}

function KnucklesStateClambering() : BaseState() constructor {
	/// @param {Struct.Player} plr
	on_start = function(plr) {
		plr.inst.behavior_loop.disable(player_behavior_jump);
		plr.inst.behavior_loop.disable(player_behavior_ground_movement);

		time_climbeEx = 40;
		plr.xsp = 0;

		plr.inst.y -= 27;
		plr.inst.x += 19 * sign(plr.inst.image_xscale);

		plr.animator.set("clambering");
	};
	
	/// @param {Struct.Player} plr
	on_step = function(plr) {
		if (time_climbeEx < 0)	
			plr.state_machine.change_to("normal");
		else 					
			time_climbeEx--;
	};
	
	/// @param {Struct.Player} plr
	on_exit = function(plr) {
		plr.inst.behavior_loop.enable(player_behavior_jump);
		plr.inst.behavior_loop.enable(player_behavior_ground_movement);
	};
}

function KnucklesStateLand() : BaseState() constructor {
	/// @param {Struct.Player} plr
	on_start = function(plr) {
		plr.inst.behavior_loop.disable(player_behavior_ground_movement);
		plr.inst.behavior_loop.disable(player_behavior_ground_friction);
		plr.inst.behavior_loop.disable(player_behavior_jump);

		rise_time=0;

		plr.animator.set("land");
	};
	
	/// @param {Struct.Player} plr
	on_step = function(plr) {
		if (plr.xsp == 0) {
			rise_time++;
			if (rise_time > 10) 
				plr.state_machine.change_to("normal");
		}

		plr.gsp -= min(abs(plr.gsp), 0.125) * sign(plr.gsp);
	};
	
	/// @param {Struct.Player} plr
	on_animate = function(plr) {
		if (plr.xsp==0) 
			plr.animator.set_image_index(1);
		else 
			plr.animator.set_image_index(0);
	};
	
	/// @param {Struct.Player} plr	
	on_exit = function(plr) {
		plr.inst.behavior_loop.enable(player_behavior_ground_movement);
		plr.inst.behavior_loop.enable(player_behavior_ground_friction);
		plr.inst.behavior_loop.enable(player_behavior_jump);
	};
}

