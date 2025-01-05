
function AngleMeasurer(position) constructor {
	__position = position;

	__radius = 10;

	__left_point = [0, 0];
	__right_point = [0, 0];

	__radius = 9;

	__layer = 0;

	__angle = 0;

	set_angle = function(_angle) {
		__left_point = [
			-__radius * dcos(_angle),
			-__radius * -dsin(_angle)
		];

		__right_point = [
			__radius * dcos(_angle),
			__radius * -dsin(_angle)
		];

		__angle = _angle;
	}

	set_layer = function(_layer) {
		__layer = _layer;
	}

	__collision_line = function(a, b, obj) {
		return (collision_line(a[0], a[1], b[0], b[1], obj, true, true) != noone);
	}

	__collision_line_solid = function(a, b) {
		return __collision_line(a, b, parSolid) 
			|| __collision_line(a, b, parPlatform)
			|| (__collision_line(a, b, parHigh) && __layer == 0)
			|| (__collision_line(a, b, parLow) && __layer == 1);
	}

	__ground_point = function(_start_point) {
		var point = [_start_point[0], _start_point[1]];
		
		for (var i = 0; i < 64; i++) {
			if (__collision_line_solid(_start_point, point)) {
				return point;
			}

			point[0] += dsin(__angle);
			point[1] += dcos(__angle);
		}

		return undefined;
	}

	measure = function(on_point_found = function(){}) {
		var start_point = [__position.x + __left_point[0], __position.y + __left_point[1]];

		var point = [start_point[0], start_point[1]]

		var gnd_point = undefined;

		var first_point = undefined;

		var angle = 0;
		var count = 0;
		var same_angle_count = 0;

		var a = undefined;

		var prev_angle = undefined;

		var step = 1;
		//var step = (__radius * 2) / 8;

		for (var i = 0; i < __radius * 2 + 1; i += step) {
			a = __ground_point(point);

			if (a != undefined) {
				if (first_point == undefined) {
					first_point = [a[0], a[1]];
				}

				if (gnd_point != undefined) {
					var n = point_direction(gnd_point[0], gnd_point[1], a[0], a[1]);

					if (n != 0) {
						angle += n;
						count++;
					} else {
						same_angle_count++;
					}

					prev_angle = n;
				}
				
				gnd_point = [a[0], a[1]];


				on_point_found(point, a);
			}

			point[0] += dcos(__angle) * step ;
			point[1] += -dsin(__angle) * step;	
		}

		if (same_angle_count > count) {
			if (first_point != undefined && a != undefined) {
				var t = point_direction(first_point[0], first_point[1], a[0], a[1]);

				if (abs(angle_difference(t, __angle)) <= 30) {
					angle = t;
				} else {
					angle = __angle;
				}
			} else {
				angle = __angle;
			}

			//angle = __angle;
			
		} else  {
			if (count == 0) count = 1;
			angle /= count;
		} 

		draw_text_transformed(__position.x, __position.y - 24, 
			string(angle) + " diff:" + string(count) + " same:" + string(same_angle_count), 
			0.4, 0.4, 0);

		return angle;
	}

	draw = function() {
		draw_set_color(c_green);
		draw_circle(__position.x, __position.y, 1, false);
		draw_line(
			__position.x + __left_point[0], 
			__position.y + __left_point[1], 
			__position.x + __right_point[0], 
			__position.y + __right_point[1]
		);

		var a = measure(function(start_point, p) {
			draw_line(start_point[0], start_point[1], p[0], p[1]);
		})

		//draw_text_transformed(__position.x, __position.y - 12, string(a), 0.4, 0.4, 0);

		draw_set_color(c_white);
	}


}

function Sensor(_x, _y, _floor_box, _wall_box, _position) constructor {
	
	__x = _x;
	__y = _y;
	
	__angle = 0;
	__angle_sin = 0;
	__angle_cos = 0;

	__angle_measurer = new AngleMeasurer(_position);
	
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
	
	__left_ground_point = { 
		x: 0, 
		y: 0 
	};
	__right_ground_point = { 
		x: 0, 
		y: 0 
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
		
		draw_set_color(c_blue); //left
		draw_circle(
			__x - 1 + __left_ground_point.x, __y + __left_ground_point.y, 
			1, false
		);
		draw_set_color(c_lime) //right
		draw_circle(
			__x - 1 + __right_ground_point.x, __y + __right_ground_point.y, 
			1, false
		);
		
		draw_set_color(c_white);

		__angle_measurer.draw();
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

		var a = round(__angle / 90) * 90;

		__angle_measurer.set_angle(a);
	}
	
	angle_in_range = function(_low, _high) {
		return (__angle >= _low) && (__angle <= _high);
	}
	
	set_layer = function(_layer) { __layer = _layer; __angle_measurer.set_layer(_layer); }
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
	get_wall_box = function() {
		return { hradius: __wall_box.hradius, vradius: __wall_box.vradius };
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
		return get_ground_angle();
	};
	
	get_ground_angle = function(_left_point = __floor_box.coords[3], _right_point = __floor_box.coords[2]) {
		return __angle_measurer.measure();
	};
	
}
