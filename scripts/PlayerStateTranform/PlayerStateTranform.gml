


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

		plr.inst.behavior_loop.disable(player_behavior_air_movement);

		__plr_ins = plr.inst;
		__timer = 60;
		__is_transformed = false;
	};
	
	/// @param {Struct.Player} plr
	on_animate = function(plr) { 
		plr.ysp = 0;
		plr.xsp = 0;
		
		other.__timer--;
		
		if (other.__timer == 0)
			plr.state_machine.change_to("normal");
	};
	
	/// @param {Struct.Player} plr
	on_exit = function(plr) {
		plr.animator.on_animation_finished(undefined);

		plr.inst.behavior_loop.enable(player_behavior_air_movement);
	};
}

function PlayerStateCorksew() : BaseState() constructor {
	__spd = 0;
	__corkPos = 0;
	
	/// @param {Struct.Player} plr
	on_start = function(plr) {

		plr.inst.behavior_loop.disable(player_behavior_collisions_solid);
		plr.inst.behavior_loop.disable(player_behavior_air_drag);
		plr.inst.behavior_loop.disable(player_behavior_air_movement);
		plr.inst.behavior_loop.disable(player_behavior_apply_gravity);
	
		__spd = plr.gsp;
	
		plr.ground = false;
		plr.animator.set("curling");
	};

	/// @param {Struct.Player} plr
	on_step = function(plr) {
		var _corksew = plr.collider.collision_object(
			objCorksewTrigger, PlayerCollisionDetectorSensor.MainDefault);

		if (_corksew != noone) {
			var _w = sprite_get_width(_corksew.sprite_index)  * _corksew.image_xscale;
			var _h = (sprite_get_height(_corksew.sprite_index) + 8 - 20) * _corksew.image_yscale;

			__corkPos = (plr.inst.x - _corksew.x) / _w;

			plr.inst.x += __spd;
			plr.inst.y = _corksew.y+_h - abs(dsin(__corkPos * 180)) * _h;
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
		plr.inst.behavior_loop.enable(player_behavior_collisions_solid);
		plr.inst.behavior_loop.enable(player_behavior_air_drag);
		plr.inst.behavior_loop.enable(player_behavior_air_movement);
		plr.inst.behavior_loop.enable(player_behavior_apply_gravity);
	};
}