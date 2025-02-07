
/// @param {Asset.GMObject} plr_inst
function AngleMeasurer(plr_inst) constructor {

	__plr_inst = plr_inst;

	__radius = 10;

	__left_point = [0, 0];
	__right_point = [0, 0];

	__radius = 9;

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

	get_angle = function() {
		return __angle;
	}

	set_layer = function(_layer) {
		__layer = _layer;
	}

	__to_cb_arg = function(a, b) {
		return {
			start_point: {x: a[0], y: a[1]},
			end_point:   {x: b[0], y: b[1]}
		};
	}

	__ground_point = function(_start_point, _cb_collision_line) {
		var point = [_start_point[0], _start_point[1]];

		var _MAX_POINT = 128;
		
		for (var i = 0; i < 20 + _MAX_POINT; i++) {
			if (_cb_collision_line(__to_cb_arg(_start_point, point))) {
				return point;
			}

			point[0] += dsin(__angle);
			point[1] += dcos(__angle);
		}

		return undefined;
	}

	measure_edges = function(_cb_collision_line, _is_landing) {
		var _left_start_point  = [__plr_inst.x + __left_point[0], __plr_inst.y + __left_point[1]];
		var _right_start_point = [__plr_inst.x + __right_point[0], __plr_inst.y + __right_point[1]];

		var _left  = __ground_point(_left_start_point, _cb_collision_line);
		var _right = __ground_point(_right_start_point, _cb_collision_line);

		var _angle = __angle;

		if (_left != undefined && _right != undefined) {
			var _expand = _is_landing ? 3 : 1;

			_left[0] -= dsin(_angle) * _expand;
			_left[1] -= dcos(_angle) * _expand;

			_right[0] -= dsin(_angle) * _expand;
			_right[1] -= dcos(_angle) * _expand;

			_angle = point_direction(_left[0], _left[1], _right[0], _right[1]);
		}

		return {
			angle: _angle,
			left: _left,
			right: _right
		};
	}

	measure = function(_cb_collision_line, is_landing) {
		var _res = measure_edges(_cb_collision_line, is_landing);
		
		if (_res.left == undefined || _res.right == undefined) {
			return _res.angle;
		}

		draw_set_color(c_red);
		draw_line(_res.left[0], _res.left[1], _res.right[0], _res.right[1]);
		
		draw_set_color(c_white);

		if (__angle == 0 && abs(angle_difference(0, _res.angle)) > 15) {
			if (_cb_collision_line(__to_cb_arg(_res.left, _res.right))) {
				draw_text(_res.left[0], _res.left[1], string(_res.angle));
				return 0;
			} 
		}

		return _res.angle;
	}	

	measure_each = function(_cb_collision_line, on_point_found = function(){}) {
		var _start_measure_point = [__plr_inst.x + __left_point[0], __plr_inst.y + __left_point[1]];

		var _step = 1;

		var _start_point = undefined;
		var _end_point = undefined;

		for (var i = 0; i < __radius * 2 + 1; i += _step) {
			var _point = [
				_start_measure_point[0] + dcos(__angle) * i, 
				_start_measure_point[1] + -dsin(__angle) * i
			];

			var _found_point = __ground_point(_point, _cb_collision_line);

			if (_found_point == undefined) continue;

			if (_start_point == undefined) {
				_start_point = [_found_point[0], _found_point[1]];
			} else if (_found_point == undefined) {
				break;
			} else {
				_end_point = [_found_point[0], _found_point[1]];
			}
		}

		var _angle = undefined;

		if (_start_point != undefined && _end_point != undefined) {
			_angle = point_direction(
				_start_point[0], 	_start_point[1],
				_end_point[0], 		_end_point[1]
			);

			_start_point[0] -= dsin(_angle) * 5;
			_start_point[1] -= dcos(_angle) * 5;

			_end_point[0] -= dsin(_angle) * 5;
			_end_point[1] -= dcos(_angle) * 5;
		}
		
		return {
			angle: _angle,
			left: _start_point,
			right: _end_point
		};
	}

	draw = function(cb) {
		draw_set_color(c_green);
		draw_circle(__plr_inst.x, __plr_inst.y, 1, false);
		draw_line(
			__plr_inst.x +  __left_point[0], 
			__plr_inst.y +  __left_point[1], 
			__plr_inst.x + __right_point[0], 
			__plr_inst.y + __right_point[1]
		);
		
		measure(cb);

		draw_set_color(c_white);
	}
}


/// @param {Asset.GMObject} _plr_inst
function FloorWallSensor(_plr_inst) constructor {
	
	plr_inst = _plr_inst;

	wall_sensor = {
		radius: 10,
		vertical_offset: 0,
		points: {
			left:  { x: 0, y: 0 },
			right: { x: 0, y: 0 }
		}
	}

	floor_sensor = {
		radius: {
			width: 9,
			height: 20
		},
		points: {
			top: {
				left:  { x: 0, y: 0 },
				right: { x: 0, y: 0 },
			},

			bottom: {
				left:  { x: 0, y: 0 },
				right: { x: 0, y: 0 },
			},
			
			ext_bottom: {
				left:  { x: 0, y: 0 },
				right: { x: 0, y: 0 },
			}

		}
	}

	angle_data = {
		sin: 0,
		cos: 0,
		degrees: 0
	}

	__offset_point = function(offset, angle_info) {
		return {
			x: (offset.x * +angle_info.cos) + (offset.y * angle_info.sin),
			y: (offset.x * -angle_info.sin) + (offset.y * angle_info.cos)
		}
	}

	__draw_line = function(p1, p2, color) {
		draw_set_color(color);
		draw_line_color(
			plr_inst.x + p1.x, plr_inst.y + p1.y, 
			plr_inst.x + p2.x, plr_inst.y + p2.y,
			color,
			c_white
		);
		draw_set_color(c_white);
	}

	__update_points = function() {
		floor_sensor.points = {
			top: {
				left:  __offset_point({x: -floor_sensor.radius.width, y: -floor_sensor.radius.height}, angle_data),
				right: __offset_point({x: +floor_sensor.radius.width, y: -floor_sensor.radius.height}, angle_data),
			},

			bottom: {
				left:  __offset_point({x: -floor_sensor.radius.width, y: +floor_sensor.radius.height}, angle_data),
				right: __offset_point({x: +floor_sensor.radius.width, y: +floor_sensor.radius.height}, angle_data),
			},

			ext_bottom: {
				left:  __offset_point({x: -floor_sensor.radius.width, y: +floor_sensor.radius.height+8}, angle_data),
				right: __offset_point({x: +floor_sensor.radius.width, y: +floor_sensor.radius.height+8}, angle_data),
			},
		}

		wall_sensor.points = {
			left:  __offset_point({x: -wall_sensor.radius , y: wall_sensor.vertical_offset}, angle_data),
			right: __offset_point({x: +wall_sensor.radius , y: wall_sensor.vertical_offset}, angle_data),
		}
	}

	set_wall_vertical_offset = function(offset) {
		wall_sensor.vertical_offset = offset;
	}

	set_angle = function(degrees) {
		angle_data = {
			sin: dsin(degrees),
			cos: dcos(degrees),
			degrees: degrees
		}

		__update_points();
	}

	get_angle_data = function() {
		return {
			sin: angle_data.sin,
			cos: angle_data.cos,
			degrees: angle_data.degrees
		};
	}

	enum SensorLines {
		Top,
		Bottom,

		Left,
		Right,

		Floor,

		LeftEdge,
		RightEdge
	}

	get_lines = function(lines_type) {
		var pack = function(left, right) {
			return { 
				start_point: { 
					x: plr_inst.x + left.x,  
					y: plr_inst.y + left.y,
				},  
				end_point: {
					x: plr_inst.x + right.x,
					y: plr_inst.y + right.y,
				}
			};
		}

		switch (lines_type) {
			case SensorLines.Top:
				return [pack(floor_sensor.points.top.left, floor_sensor.points.top.right)];
			case SensorLines.Bottom: 
				return [pack(floor_sensor.points.bottom.left, floor_sensor.points.bottom.right)];
			case SensorLines.Left:
				return [pack(wall_sensor.points.left, {x: 0, y: 0})];
			case SensorLines.Right:
				return [pack({x: 0, y: 0}, wall_sensor.points.right)];

			case SensorLines.Floor:
				return [
					pack(floor_sensor.points.bottom.left, floor_sensor.points.ext_bottom.right),
					pack(floor_sensor.points.bottom.right, floor_sensor.points.ext_bottom.left)
				];

			case SensorLines.LeftEdge:
				return [pack(floor_sensor.points.bottom.left, floor_sensor.points.ext_bottom.left)];
			case SensorLines.RightEdge:
				return [pack(floor_sensor.points.bottom.right, floor_sensor.points.ext_bottom.right)];
		}
	}

	set_radius = function(floor_radius, wall_radius) {
		floor_sensor.radius.width = floor_radius.width;
		floor_sensor.radius.height = floor_radius.height;

		wall_sensor.radius = wall_radius;

		__update_points();
	}

	get_radius = function() {
		return {
			floor: {
				width:  floor_sensor.radius.width,
				height: floor_sensor.radius.height
			},
			wall: wall_sensor.radius
		}
	}

	draw = function() {
		__draw_line(floor_sensor.points.top.left, floor_sensor.points.top.right, c_green);
		__draw_line(floor_sensor.points.bottom.left, floor_sensor.points.bottom.right, c_red);

		__draw_line(floor_sensor.points.bottom.left, floor_sensor.points.ext_bottom.left, c_purple);
		__draw_line(floor_sensor.points.bottom.right, floor_sensor.points.ext_bottom.right, c_purple);
		__draw_line(floor_sensor.points.bottom.left, floor_sensor.points.ext_bottom.right, c_fuchsia);
		__draw_line(floor_sensor.points.bottom.right, floor_sensor.points.ext_bottom.left, c_fuchsia);

		
		__draw_line(wall_sensor.points.left, {x: 0, y: 0}, c_purple);
		__draw_line(wall_sensor.points.right, {x: 0, y: 0}, c_aqua);
	}

	set_angle(0);
}

enum PlayerCollisionDetectorSensor {
	MainDefault,
	MainCircle,
	MainRect,

	Top,
	Bottom,
	Left,
	Right,

	FloorExtend,
	EdgeLeft,
	EdgeRight
};

enum PlayerCollisionDetectorLayer {
	High, Low
};

/// @param {Asset.GMObject} _plr_inst
function PlayerCollisionDetector(_plr_inst) constructor {
	__plr_inst = _plr_inst;

	__layer = PlayerCollisionDetectorLayer.Low;

	__angle_measurer = new AngleMeasurer(_plr_inst);
	__floorSensor = new FloorWallSensor(_plr_inst);

	_main 		= layer_tilemap_get_id("solidmap_main");
	_high 		= layer_tilemap_get_id("solidmap_high");
	_low 		= layer_tilemap_get_id("solidmap_low");
	_platform 	= layer_tilemap_get_id("solidmap_platform");
	
	/////////////////////////////////////////////////////////////////////
	
	__collision_line = function(_line, _object) {
		return collision_line(
			_line.start_point.x, _line.start_point.y,
			_line.end_point.x, _line.end_point.y,
			_object, true, true
		);
	}

	__is_collision_line_solid = function(_line) {
		
		
		return (
			(__collision_line(_line, parSolid) != noone) || 
			(__collision_line(_line, parHigh)  != noone)  && __layer == PlayerCollisionDetectorLayer.High ||
			(__collision_line(_line, parLow)   != noone)  && __layer == PlayerCollisionDetectorLayer.Low  ||
			
			(_main != -1 && __collision_line(_line, _main) != noone) || 
			(_high != -1 && __collision_line(_line, _high)  != noone)  && __layer == PlayerCollisionDetectorLayer.High ||
			(_low  != -1 && __collision_line(_line, _low)   != noone)  && __layer == PlayerCollisionDetectorLayer.Low  
		);
	}

	__is_collision_line_solid_and_platform = function(_line) {
		return __is_collision_line_solid(_line) || 
			   (__collision_line(_line, parPlatform) != noone || 
			   (_platform != -1 && __collision_line(_line, _platform) != noone));
	}

	set_layer = function(layer) {
		__layer = layer;
	}

	__get_line_type = function(sensor_type) {
		switch (sensor_type) {
			case PlayerCollisionDetectorSensor.Top: return SensorLines.Top;
			case PlayerCollisionDetectorSensor.Bottom: return SensorLines.Bottom;
			case PlayerCollisionDetectorSensor.Left: return SensorLines.Left;
			case PlayerCollisionDetectorSensor.Right: return SensorLines.Right;

			case PlayerCollisionDetectorSensor.EdgeLeft: return SensorLines.LeftEdge;
			case PlayerCollisionDetectorSensor.EdgeRight: return SensorLines.RightEdge;

			case PlayerCollisionDetectorSensor.FloorExtend: return SensorLines.Floor;
		}
	}

	__collision_floor_wall_sensor_line_solid = function(sensor) {
		var f = (sensor == PlayerCollisionDetectorSensor.Bottom || 
			sensor == PlayerCollisionDetectorSensor.FloorExtend ||
			sensor == PlayerCollisionDetectorSensor.EdgeLeft ||
			sensor == PlayerCollisionDetectorSensor.EdgeRight
		   ) 
		   ? __is_collision_line_solid_and_platform 
		   : __is_collision_line_solid;

		var line_list = __floorSensor.get_lines(__get_line_type(sensor));
		
		for (var i = 0; i < array_length(line_list); i++) {
			var line = line_list[i];

			return f(line);
		}

		return false;
	}

	__collision_floor_wall_sensor_line_object = function(sensor, obj) {
		var line_list = __floorSensor.get_lines(__get_line_type(sensor));
		
		for (var i = 0; i < array_length(line_list); i++) {
			var line = line_list[i];

			return __collision_line(line, obj);
		}

		return noone;
	}

	collision_object = function(obj, sensor_type) {
		if (sensor_type == PlayerCollisionDetectorSensor.MainDefault) {
			return collision_ellipse(
				__plr_inst.x - __floorSensor.get_radius().wall,
				__plr_inst.y - __floorSensor.get_radius().floor.height,
				__plr_inst.x + __floorSensor.get_radius().wall,
				__plr_inst.y + __floorSensor.get_radius().floor.height,
				obj, 
				true, true
			);
		}

		return __collision_floor_wall_sensor_line_object(sensor_type, obj);
	}

	collision_object_exp = function(sensor_type, obj, _hexpand, _vexpand) {
		return check_expanded(_hexpand, _vexpand, collision_object, obj, sensor_type);
	}
	
	is_collision_solid = function(sensor) {
		return __collision_floor_wall_sensor_line_solid(sensor);
	}
	
	check_expanded = function(_hexpand, _vexpand, _function, _arg_a = undefined, _arg_b = undefined) {
		var radius = __floorSensor.get_radius();

		radius.floor.width  += _hexpand;
		radius.floor.height += _vexpand;
		radius.wall += _hexpand;

		__floorSensor.set_radius(radius.floor, radius.wall);
		
		var _result;

		if (_arg_b != undefined ) {
			_result = _function(_arg_a, _arg_b); 
		} else if (_arg_a != undefined ) {
			_result = _function(_arg_a); 
		} else {
			_result = _function();
		}
		
		radius.floor.width  -= _hexpand;
		radius.floor.height -= _vexpand;
		radius.wall -= _hexpand;

		__floorSensor.set_radius(radius.floor, radius.wall);
		
		return _result;
	}

	draw = function() {
		__angle_measurer.draw(__is_collision_line_solid_and_platform);
		__floorSensor.draw();
		
		draw_set_color(c_green);
		draw_circle(__plr_inst.x, __plr_inst.y, 1, false);

		draw_ellipse(
			__plr_inst.x - __floorSensor.get_radius().wall,
			__plr_inst.y - __floorSensor.get_radius().floor.height,
			__plr_inst.x + __floorSensor.get_radius().wall,
			__plr_inst.y + __floorSensor.get_radius().floor.height,
			true
		);
	};
	
	set_angle = function(_angle) {
		__floorSensor.set_angle(_angle);

		var a = round(_angle / 3) * 3;
		// var a = round(_angle / 90) * 90;
		// var a = _angle;

		var _current_angle = __angle_measurer.get_angle();
		__angle_measurer.set_angle(a);

		if (__angle_measurer.measure(__is_collision_line_solid_and_platform) == _current_angle) {
			__angle_measurer.set_angle(_current_angle);
		}
	}

	set_wall_sensor_vertical_offset = function(offset) {
		__floorSensor.set_wall_vertical_offset(offset);
	}

	is_angle_in_range = function(a, b) {
		return    __floorSensor.get_angle_data().degrees >= a 
			   && __floorSensor.get_angle_data().degrees <= b; 
	}

	get_angle_data = function() {
		return __floorSensor.get_angle_data();
	}

	set_radius = function(floor, wall) {
		__floorSensor.set_radius(floor, wall);
	}

	get_radius = function() {
		return __floorSensor.get_radius();
	}

	measure_angle = function(is_landing = false) {
		var _res = __angle_measurer.measure(__is_collision_line_solid_and_platform, is_landing);

		if (collision_object(objAngleRounder, PlayerCollisionDetectorSensor.FloorExtend)) {
			return round(_res / 90) * 90;
		}

		return _res;
	}
}
