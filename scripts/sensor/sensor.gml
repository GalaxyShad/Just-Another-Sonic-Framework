
function Sensor(_x, _y, _floor_box, _wall_box) constructor {
	
	__x = _x;
	__y = _y;
	
	__angle = 0;
	__angle_sin = 0;
	__angle_cos = 0;
	
	__layer = 0;
	
	__max_expand = 24;
	
	__floor_box = {
		hradius : _floor_box[0],
		vradius : _floor_box[1],
		
		coords : [
			{ x: 0, y : 0 },
			{ x: 0, y : 0 },
			{ x: 0, y : 0 },
			{ x: 0, y : 0 },
		]
	};
	
	__wall_box = {
		hradius : _wall_box[0],
		vradius : _wall_box[1],
		
		coords : [
			{ x: 0, y : 0 },
			{ x: 0, y : 0 },
			{ x: 0, y : 0 },
			{ x: 0, y : 0 },
		]
	};
	
	/////////////////////////////////////////////////////////////////////
	
	__update_coords = function() {
		for (var i = 0; i < 4; i++) {
			var _hsign = (i == 1 || i == 2) ? -1 : 1;
			var _vsign = (i == 2 || i == 3) ? -1 : 1;
			
			__floor_box.coords[i].x =	- __floor_box.hradius *  __angle_cos * _hsign
										- __floor_box.vradius *  __angle_sin * _vsign;
			__floor_box.coords[i].y =	- __floor_box.hradius * -__angle_sin * _hsign
										- __floor_box.vradius *  __angle_cos * _vsign;								  
	
			__wall_box.coords[i].x  =	- __wall_box.hradius *  __angle_cos * _hsign
										- __wall_box.vradius *  __angle_sin * _vsign;
			__wall_box.coords[i].y  =	- __wall_box.hradius * -__angle_sin * _hsign
										- __wall_box.vradius *  __angle_cos * _vsign;	
		}
	};
	
	__get_floor_box_bottom	= function() { return [__floor_box.coords[2], __floor_box.coords[3]]; }
	__get_floor_box_top		= function() { return [__floor_box.coords[0], __floor_box.coords[1]]; }
	__get_wall_box_left		= function() { return [__wall_box.coords[0], __wall_box.coords[3]]; }
	__get_wall_box_right	= function() { return [__wall_box.coords[1], __wall_box.coords[2]]; }
	
	#macro FLOORBOX_BOTTOM_LINE	__get_floor_box_bottom()
	#macro FLOORBOX_TOP_LINE	__get_floor_box_top()
	#macro WALLBOX_LEFT_LINE	__get_wall_box_left()
	#macro WALLBOX_RIGHT_LINE	__get_wall_box_right()
	
	
	
	draw = function() {
		__update_coords();
		
		for (var i = 0; i < 4; i++) {
			var _curr = i;
			var _next = (i+1) % 4;
			
			draw_set_color(make_color_hsv(i * 50, 255, 255));
			draw_circle(
				__x + __floor_box.coords[_curr].x - 1, __y + __floor_box.coords[_curr].y, 
				1, false
			);
			
			draw_set_color(c_aqua);	
			draw_line(
				__x + __floor_box.coords[_curr].x - 1, __y + __floor_box.coords[_curr].y,
				__x + __floor_box.coords[_next].x - 1, __y + __floor_box.coords[_next].y
			);	
			
			draw_set_color(c_red);	
			draw_line(
				__x + __wall_box.coords[_curr].x - 1, __y + __wall_box.coords[_curr].y,
				__x + __wall_box.coords[_next].x - 1, __y + __wall_box.coords[_next].y
			);	
		}
		
		draw_set_color(c_green);
		draw_circle(__x, __y, 1, false);
		
		draw_set_color(c_white);
	};
	
	__genesis_mode_angle = function(_angle) {
		if (_angle >= 000 && _angle <= 045) return 0;
		if (_angle >= 046 && _angle <= 134) return 90;
		if (_angle >= 135 && _angle <= 225) return 180;
		if (_angle >= 226 && _angle <= 314) return 270;
		return 0;
	}
	
	set_angle = function(_angle) {
		__angle = _angle;
		
		__angle_sin = dsin(__angle);
		__angle_cos = dcos(__angle);
		
		__update_coords();
	}
	
	set_layer = function(_layer) { __layer = _layer; }
	
	get_layer = function() { return __layer; }
	
	get_angle = function() { return __angle; }
	
	get_angle_sin = function() { return __angle_sin; }
	get_angle_cos = function() { return __angle_cos; }
	
	set_position = function(_x, _y) { __x = _x; __y = _y; }
	
	get_position = function() { return { x: __x, y: __y }; }
	
	set_floor_box = function(_box) {
		__floor_box.hradius = _box[0];
		__floor_box.vradius = _box[1];
		
		__update_coords();
	}
	
	get_floor_box = function() {
		return { hradius: __floor_box.hradius, vradius: __floor_box.vradius };
	}
	
	set_wall_box = function(_box) {
		__wall_box.hradius = _box[0];
		__wall_box.vradius = _box[1];
		
		__update_coords();
	}
	
	__collision_line = function(_line, _object) {
		return collision_line(
			floor(__x + _line[0].x), floor(__y + _line[0].y),
			floor(__x + _line[1].x), floor(__y + _line[1].y),
			_object, true, true
		);
	}
	
	__collision_point = function(_point, _object) {
		return collision_point(
			floor(__x + _point.x), floor(__y + _point.y),
			_object, true, true
		);	
	}
	
	__is_collision_line_solid = function(_line) {
		return (
			(__collision_line(_line, parSolid) != noone) || 
			(__collision_line(_line, parHigh) != noone && __layer == 0) ||
			(__collision_line(_line, parLow) != noone  && __layer == 1)
		);
	}
	
	__is_collision_point_solid = function(_point) {
		return (
			(__collision_point(_point, parSolid) != noone) || 
			(__collision_point(_point, parHigh) != noone && __layer == 0) ||
			(__collision_point(_point, parLow) != noone  && __layer == 1)
		);
	}
	

	
	collision_object = function(_object, _expand = 0) {
		return collision_rectangle(
			__x - __floor_box.hradius - _expand,
			__y - __floor_box.vradius - _expand,
			__x + __floor_box.hradius + _expand,
			__y + __floor_box.vradius + _expand,
			_object, true, true
		);
	};
	
	collision_bottom = function(_object, _expand = 0) { 
		return __collision_line(FLOORBOX_BOTTOM_LINE, _object);
	}
	
	collision_top = function(_object, _expand = 0) { 
		return __collision_line(FLOORBOX_TOP_LINE, _object);
	}
	
	collision_left = function(_object, _expand = 0) { 
		return __collision_line(WALLBOX_LEFT_LINE, _object);
	}
	
	collision_right = function(_object, _expand = 0) { 
		return __collision_line(WALLBOX_RIGHT_LINE, _object);	
	}
	
	
	is_collision_solid_bottom = function() {
		return __is_collision_line_solid(FLOORBOX_BOTTOM_LINE) || 
			   collision_bottom(parPlatform) != noone;
	};
	
	
	is_collision_solid_top = function() {
		return __is_collision_line_solid(FLOORBOX_TOP_LINE);
	};
	
	
	is_collision_solid_left = function() {
		return __is_collision_line_solid(WALLBOX_LEFT_LINE);
	};
	
	
	is_collision_solid_right = function() {
		return __is_collision_line_solid(WALLBOX_RIGHT_LINE);
	};
	
	
	check_expanded = function(_hexpand, _vexpand, _function) {
		__floor_box.hradius += _hexpand;
		__floor_box.vradius += _vexpand;
		__wall_box.hradius  += _hexpand;
		__wall_box.vradius  += _vexpand;
		__update_coords();
		
		var _result = _function();
		
		__floor_box.hradius -= _hexpand;
		__floor_box.vradius -= _vexpand;
		__wall_box.hradius  -= _hexpand;
		__wall_box.vradius  -= _vexpand;
		__update_coords();
		
		return _result;
	}

	is_collision_ground = function() {
		for (var i = 0; i < __max_expand; i++) {
			if (check_expanded(0, i, is_collision_solid_bottom))
				return true;
		}
		
		return false;
	};
	
	
	is_collision_ground_left_edge = function() {
		var _dst_point = {
			x: __floor_box.coords[3].x + __max_expand * __angle_sin,
			y: __floor_box.coords[3].y + __max_expand * __angle_cos
		};
		
		return __is_collision_line_solid([__floor_box.coords[3], _dst_point]) ||
			   __collision_line([__floor_box.coords[3], _dst_point], parPlatform) != noone;
	};
	
	
	is_collision_ground_right_edge = function() {
		var _dst_point = {
			x: __floor_box.coords[2].x + __max_expand * __angle_sin,
			y: __floor_box.coords[2].y + __max_expand * __angle_cos
		};
		
		return __is_collision_line_solid([__floor_box.coords[2], _dst_point]) || 
			  __collision_line([__floor_box.coords[2], _dst_point], parPlatform) != noone;
	};
	
	get_landing_ground_angle = function() {
		var _n = __floor_box.hradius / 2;
		
		var _dir = 1; 
		var _start_point = __floor_box.coords[3];
		
		if (is_collision_ground_right_edge()) {
			//show_debug_message("da");
			
			_dir = -1;
			_start_point = __floor_box.coords[2];
		}
		
		for (var i = 0; i <= _n; i++) {
			var _apoint = { 
				x: _start_point.x, 
				y: _start_point.y 
			};
			
			var _bpoint = { 
				x: _start_point.x + __angle_cos * _dir, 
				y: _start_point.y + __angle_sin * _dir
			};


			var _ang = (_dir == 1) ? 
				get_ground_angle(_apoint, _bpoint) : 
				get_ground_angle(_bpoint, _apoint);
				
			if (_ang != 0)
				return _ang;
				
			_start_point.x += __angle_cos * _dir;
			_start_point.y += __angle_sin * _dir;
		}
		
		return 0;
	};
	
	get_ground_angle = function(_left_point = __floor_box.coords[3], _right_point = __floor_box.coords[2]) {
		var _lpoint = { 
			is_found: false, 
			x: _left_point.x, 
			y: _left_point.y 
		};
		var _rpoint = { 
			is_found: false, 
			x: _right_point.x, 
			y: _right_point.y 
		};
		
		//var _temp_angle = __angle;
		//set_angle(round(_temp_angle / 10) * 10);
		
		for (var i = 0; i < __max_expand; i++) {
			if (__is_collision_point_solid(_lpoint) || __collision_point(_lpoint, parPlatform) != noone) {
				_lpoint.is_found = true;
			} else if (!_lpoint.is_found) {
				_lpoint.x += __angle_sin;
				_lpoint.y += __angle_cos;
			}
			
			if (__is_collision_point_solid(_rpoint) || __collision_point(_rpoint, parPlatform) != noone) {
				_rpoint.is_found = true;
			} else if (!_rpoint.is_found) {
				_rpoint.x += __angle_sin;
				_rpoint.y += __angle_cos;	
			}
		}
		
		var _new_angle = 0;
					   
		if (_rpoint.is_found && _lpoint.is_found) {
			_new_angle = point_direction(_lpoint.x, _lpoint.y, _rpoint.x, _rpoint.y);
		}
		
		//set_angle(_temp_angle);
		
		/*
		var tollerance = 5;
		
		if (abs(angle_difference(_new_angle, _temp_angle)) < tollerance)
			_new_angle = _temp_angle;
		
		if (_new_angle >= 360 - tollerance || _new_angle <= 0 + tollerance)
			_new_angle = 0;
			
		if (_new_angle >= 90 - tollerance && _new_angle <= 90 + tollerance)
			_new_angle = 90;
			
		if (_new_angle >= 180 - tollerance && _new_angle <= 180 + tollerance)
			_new_angle = 180;
			
		if (_new_angle >= 270 - tollerance  && _new_angle <= 270 + tollerance)
			_new_angle = 270;
		*/
		
		
		return floor(_new_angle);
	};
	
	

}