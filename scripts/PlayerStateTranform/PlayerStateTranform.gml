


function PlayerStateTransform(_transform_frame) : BaseState() constructor {
	__timer = undefined;
	__is_transformed = false; 
	__plr_ins = undefined;
	__transform_frame = _transform_frame;

	/// @param {Struct.Player} plr
	on_step = function(plr) {
		if (plr.animator.get_image_index() >= __transform_frame && !__is_transformed) {
			with (plr.inst) {
				player_set_super_form();					
				audio_play_sound(sndPlrTransform, 0, 0);
			}

			__is_transformed = true;
		}
	}
	
	/// @param {Struct.Player} plr
	on_start = function(plr) { 
		plr.ground = false;
		plr.animator.set("transform");

		plr.behavior_loop.disable(player_behavior_air_movement);

		__plr_ins = plr.inst;
		__timer = 60;
		__is_transformed = false;
	};
	
	/// @param {Struct.Player} plr
	on_animate = function(plr) { 
		plr.ysp = 0;
		plr.xsp = 0;
		
		__timer--;
		
		if (__timer == 0)
			plr.state_machine.change_to("normal");
	};
	
	/// @param {Struct.Player} plr
	on_exit = function(plr) {
		plr.animator.on_animation_finished(undefined);

		plr.behavior_loop.enable(player_behavior_air_movement);
	};
}

function PlayerStateCorksew() : BaseState() constructor {
	__spd = 0;
	__corkPos = 0;
	
	/// @param {Struct.Player} plr
	on_start = function(plr) {
		plr.behavior_loop.disable(player_behavior_apply_speed);
		plr.behavior_loop.disable(player_behavior_collisions_solid);
		plr.behavior_loop.disable(player_behavior_air_drag);
		plr.behavior_loop.disable(player_behavior_air_movement);
		plr.behavior_loop.disable(player_behavior_apply_gravity);
	
		__spd = plr.gsp;
	
		plr.ground = false;
		plr.animator.set("curling");
	};

	/// @param {Struct.Player} plr
	on_step = function(plr) {
		var _corksew = plr.collider.collision_object(
			objCorksew, PlayerCollisionDetectorSensor.MainDefault);

		if (plr.is_input_jump_pressed()) {
			plr.xsp = __spd;
			plr.ysp = -plr.physics.jump_force;

			plr.state_machine.change_to("jump");
		}

		if (_corksew != noone) {
			var _spr_x = 384;
			var _off_y = 93;
			var _off_x = -14;
			var _h = 35;
			var _w = 178;

			__corkPos = (plr.inst.x - _corksew.x) / _spr_x;
 
			plr.inst.x += __spd;
			plr.inst.y = _corksew.y + _off_y - _h + _h*dcos(((plr.inst.x - _corksew.x) / _w) * 180 + _off_x);
		} else {
			plr.state_machine.change_to("normal");
		}


	}

	/// @param {Struct.Player} plr
	on_animate = function(plr) {
		plr.animator.set("corksew");
		plr.animator.set_image_index( (floor(__corkPos * 11)) );
	}
	
	/// @param {Struct.Player} plr
	on_exit = function(plr) {
		plr.behavior_loop.enable(player_behavior_collisions_solid);
		plr.behavior_loop.enable(player_behavior_air_drag);
		plr.behavior_loop.enable(player_behavior_air_movement);
		plr.behavior_loop.enable(player_behavior_apply_gravity);
		plr.behavior_loop.enable(player_behavior_apply_speed);
	};
}