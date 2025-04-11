
function BaseState() constructor {
	super = function() {}
};



function PlayerStateNormal() : BaseState() constructor {
	__idle_anim_timer = undefined;
	
	on_start = function() {
		__idle_anim_timer = 0;
	};
	
	/// @param {Struct.Player} plr
	on_step = function(plr) {
		// Look Up and Down
		if (plr.ground && plr.input_y() < 0 && plr.gsp == 0)
			plr.state_machine.change_to("look_up");
		if (plr.ground && plr.input_y() > 0 && plr.gsp == 0)
			plr.state_machine.change_to("look_down");
			
		// To Roll
		if (plr.ground && plr.input_y() > 0 && abs(plr.gsp) >= 1) {
			plr.state_machine.change_to("roll");
			audio_play_sound(sndPlrRoll, 0, false);
		}
		
		// Skid
		if (plr.ground && abs(plr.gsp) >= 4 && 
			((plr.gsp < 0 && plr.input_x() > 0) || (plr.gsp > 0 && plr.input_x() < 0))
		) {
			plr.state_machine.change_to("skid");
			audio_play_sound(sndPlrBraking, 0, false);
		}
		
		// Balancing
		var _check_balanced = plr.collider.check_expanded(-6, 0, function(plr) { 
			return (!plr.collider.is_collision_solid(PlayerCollisionDetectorSensor.EdgeLeft) || 
					!plr.collider.is_collision_solid(PlayerCollisionDetectorSensor.EdgeRight)); 
		}, plr);
		
		if (plr.ground && plr.gsp == 0 && _check_balanced) {
			plr.state_machine.change_to("balancing");
		}

		var col_left_wall = plr.collider.check_expanded(1, 0, function(plr) {
			return plr.collider.is_collision_solid(PlayerCollisionDetectorSensor.Left);
		}, plr);
		var col_right_wall = plr.collider.check_expanded(1, 0, function(plr) {
			return plr.collider.is_collision_solid(PlayerCollisionDetectorSensor.Right);
		}, plr);
		
		// Push
		if ((plr.gsp >= 0 && plr.input_x() > 0 && col_right_wall) || 
			(plr.gsp <= 0 && plr.input_x() < 0  && col_left_wall)
		) {
			if (plr.ground) plr.state_machine.change_to("push");
		}
	};
	
	/// @param {Struct.Player} p
	on_animate = function(plr) { 
		var _abs_gsp = abs(plr.gsp);
		
		__idle_anim_timer = (plr.ground && _abs_gsp == 0) ? 
			__idle_anim_timer+1 : 0;
			
		if (!plr.ground) {
			plr.animator.set("walking");
			plr.animator.set_image_speed(0.125 + _abs_gsp / 24.0);
			
			return;
		}

		if (_abs_gsp == 0) {
			if (__idle_anim_timer >= 180 && __idle_anim_timer < 816)
				plr.animator.set("bored");
			else if (__idle_anim_timer >= 816)
				plr.animator.set("bored_ex");
			else 
				plr.animator.set("idle");
		} else {
			if (_abs_gsp < 6)
				plr.animator.set("walking");
			else if (_abs_gsp < 12)
				plr.animator.set("running");
			else 
				plr.animator.set("dash");
		}
				
		if (plr.animator.is(["walking", "running", "dash"])) {
			plr.animator.set_image_speed(0.125 + _abs_gsp / 24.0);
		} 
	};
}

function PlayerStateNoclip() : BaseState() constructor {
	/// @param {Struct.Player} plr
	on_start = function(plr) {
		plr.ground = false;
		plr.behavior_loop.disable(player_behavior_collisions_solid);
		plr.behavior_loop.disable(player_behavior_apply_gravity);
		plr.behavior_loop.disable(player_behavior_apply_speed);

		plr.handle_loop.disable_all();

		plr.animator.set("skid");
	}

	/// @param {Struct.Player} plr
	on_step = function(plr) {
		plr.inst.x += plr.xsp;
		plr.inst.y += plr.ysp;

		if (keyboard_check(vk_up)) { 
			plr.ysp -= 0.1; 
		} else if (keyboard_check(vk_down)) { 
			plr.ysp += 0.1; 
		} else { 
			plr.ysp = 0; 
		}
	}

	/// @param {Struct.Player} plr
	on_exit = function(plr) {
		plr.behavior_loop.enable(player_behavior_collisions_solid);
		plr.behavior_loop.enable(player_behavior_apply_gravity);
		plr.behavior_loop.enable(player_behavior_apply_speed);

		plr.handle_loop.enable_all();
	}
}