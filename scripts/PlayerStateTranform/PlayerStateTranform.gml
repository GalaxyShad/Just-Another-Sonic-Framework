


function PlayerStateTransform(_transform_frame) : BaseState() constructor {
	__timer = undefined;
	__is_transformed = false; 
	__plr_ins = undefined;
	__transform_frame = _transform_frame;

	on_step = function(p) {
		if (p.animator.get_image_index() >= __transform_frame && !__is_transformed) {
			with (p) {
				player_set_super_form();					
				audio_play_sound(sndPlrTransform, 0, 0);
			}

			__is_transformed = true;
		}
	}
	
	on_start = function(p) { 
		p.ground = false;
		p.animator.set("transform");

		//behavior_loop.disable(player_behavior_air_movement);
		p.allow_movement = false;

		__plr_ins = p;
		__timer = 60;
		__is_transformed = false;
	};
	
	on_animate = function(player) { with player {
		ysp = 0;
		xsp = 0;
		
		other.__timer--;
		
		if (other.__timer == 0)
			state.change_to("normal");
	}};
	
	on_exit = function(player) {
		player.animator.on_animation_finished(undefined);
		player.allow_movement = true;
		//behavior_loop.enable(player_behavior_air_movement);
	};
}

function PlayerStateCorksew() : BaseState() constructor {
	__spd = 0;
	__corkPos = 0;
	
	on_start = function(player) {

		player.behavior_loop.disable(player_behavior_collisions);
		player.behavior_loop.disable(player_behavior_air_drag);
		player.behavior_loop.disable(player_behavior_air_movement);
		player.behavior_loop.disable(player_behavior_apply_gravity);
	
		__spd = player.gsp;
		
	with player {
		ground = false;
		animator.set("curling");
		//behavior_loop.disable(player_behavior_air_movement);
	}};

	on_step = function(p) {

		

		var _corksew = p.collision_detector.collision_object(
			objCorksewTrigger, PlayerCollisionDetectorSensor.MainDefault);

		if (_corksew != noone) {
			var _w = sprite_get_width(_corksew.sprite_index)  * _corksew.image_xscale;
			var _h = (sprite_get_height(_corksew.sprite_index) + 8) * _corksew.image_yscale;

			__corkPos = (p.x - _corksew.x) / _w;

			p.x += __spd * dcos(point_direction(p.xprevious, p.yprevious, p.x, p.y));
			p.y = _corksew.y+_h - abs(dsin(__corkPos * 180)) * _h;
		} else {
			p.state.change_to("normal");
		}
	}

	on_animate = function(p) {
		p.animator.set("corksew");
		p.animator.set_image_index( (floor(__corkPos * 11)) );
	}
	
	on_exit = function(player) {

		with player {
			behavior_loop.enable(player_behavior_collisions);
			behavior_loop.enable(player_behavior_air_drag);
			behavior_loop.enable(player_behavior_air_movement);
			behavior_loop.enable(player_behavior_apply_gravity);
		}

		// player.allow_movement = true;
		//behavior_loop.enable(player_behavior_air_movement);
	};
}