// Ресурсы скриптов были изменены для версии 2.3.0, подробности см. по адресу
// https://help.yoyogames.com/hc/en-us/articles/360005277377
function PlayerAnimator() constructor {
	__animation_map = {};
	__animation_map_super = {};
	
	__last_added = undefined;
	
	__previous_animation_name = undefined;
	__current_animation_name = undefined;
	__is_super = false;
	
	__image_index  = 0;
	__image_speed  = 1;
	__sprite_index = 0;
	
	__is_ended	   = false;
	
	__sprite_index_previous = undefined;
	
	
	__create_default = function(_name, _sprite, _is_super = false) {
		if (__animation_map[$ _name] == undefined)
			__animation_map[$ _name] = [undefined, undefined];
		
		__animation_map[$ _name][_is_super]	= {
			name: _name,
			sprite: _sprite,
			loop_frame: 0,
			stop_on_end: false,
			spd: 1,
			frames: sprite_get_number(_sprite)
		}
		
		__last_added = __animation_map[$ _name][_is_super];
	}
	
	add = function(_name, _sprite) {
		__create_default(_name, _sprite);
		
		return self;
	};
	
	add_super = function(_name, _sprite_super) {
		if (__animation_map[$ _name] == undefined)
			show_error($"Super cannot be applied to unexisting animation: [{_name}]", true);
		
		__create_default(_name, _sprite_super, true);
		
		return self;
	}
	
	speed = function(_spd) {
		__last_added.spd = _spd;
		
		return self;
	};

	
	loop_from = function(_loop_frame) {
		__last_added.loop_frame = _loop_frame;
		
		return self;
	};
	
	stop_on_end = function() {
		__last_added.stop_on_end = true;
		
		return self;
	};
	
	set_form_super  = function() { __is_super = true;  };
	set_form_normal = function() { __is_super = false; };
	
	set = function(_name) {
		/*if (__animation_map[$ _name] == undefined) {
			return;
		}*/
		
		__is_ended = false;
			
		__previous_animation_name = __current_animation_name;
		__current_animation_name  = _name;
		
		if (__previous_animation_name != __current_animation_name) {
			var _anim = __get_current_animation();
			
			__image_index = 0;
			set_image_speed(_anim.spd);
			__sprite_index = _anim.sprite;
		}
	};
	
	set_image_speed = function(_speed) {
		__image_speed = _speed;
	};
	
	current = function() {
		return __current_animation_name;	
	};
	
	
	__get_current_animation = function() {
		
		var _anim = __animation_map[$ __current_animation_name];
		
		var _base  = (_anim != undefined) ? _anim[0] : undefined;
		var _super = (_anim != undefined) ? _anim[1] : undefined;
		
		var _res = (__is_super && _super != undefined) ? _super : _base;
		
		if (_res == undefined) {
			var _temp = __current_animation_name;
			
			__current_animation_name = "__no_anim";
			_res = __get_current_animation();
			__current_animation_name = _temp;
		}
		
		return _res;
	};
	
	is_animation_ended = function() {
		return __is_ended;	
	};
	
	get_image_index = function() {
		return __image_index;
	};
	
	set_image_index = function(_image_index) {
		__image_index=_image_index;
	};
	
	animate = function() {
		var _anim = __get_current_animation();
		
		__image_index += __image_speed;
		if (__image_index >= _anim.frames) {
			if (!_anim.stop_on_end) {
				__image_index -= _anim.frames - _anim.loop_frame;
			} else {
				__image_index = _anim.frames - 1;
				__is_ended = true;
			}
		}
			
		return [__sprite_index, __image_index];
	};
	
	is = function(_arr_args_animations = []) {
		return array_contains(_arr_args_animations, current());
	};
	
	is_animation_exists = function(_name) {
		return (__animation_map[$ _name] != undefined);
	};
	
	
	__init__ = function() {
		__create_default("__no_anim", sprNoAnimation);
	}();
	
	
}