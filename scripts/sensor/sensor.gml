// Ресурсы скриптов были изменены для версии 2.3.0, подробности см. по адресу
// https://help.yoyogames.com/hc/en-us/articles/360005277377


function Sensor() constructor {
	
	x = 0;
	y = 0;
	
	angle = 0;
	
	layer = 0;
	
	max_expand = 24;
	
	floor_box = {
		hradius : 8,
		vradius : 20,
		
		coords : [
			{ x: 0, y : 0 },
			{ x: 0, y : 0 },
			{ x: 0, y : 0 },
			{ x: 0, y : 0 },
		]
	};
	
	wall_box = {
		hradius : 10,
		vradius : 0,
		
		coords : [
			{ x: 0, y : 0 },
			{ x: 0, y : 0 },
			{ x: 0, y : 0 },
			{ x: 0, y : 0 },
		]
	};
	
	/////////////////////////////////////////////////////////////////////
	
	update_coords = function() {
		x = other.x;
		y = other.y;
		
		var radang = degtorad(angle); 
		var acos   = cos(radang);
		var asin   = sin(radang);
		
		for (var i = 0; i < 4; i++) {
			var hsign = (i == 1 || i == 2) ? -1 : 1;
			var vsign = (i == 2 || i == 3) ? -1 : 1;
			
			floor_box.coords[i].x = x - floor_box.hradius *  acos * hsign
									  - floor_box.vradius *  asin * vsign;
			floor_box.coords[i].y = y - floor_box.hradius * -asin * hsign
									  - floor_box.vradius *  acos * vsign;								  
	
			wall_box.coords[i].x  = x - wall_box.hradius *  acos * hsign
									  - wall_box.vradius *  asin * vsign;
			wall_box.coords[i].y  = y - wall_box.hradius * -asin * hsign
									  - wall_box.vradius *  acos * vsign;	
		}
	};
	
	draw = function() {
		update_coords();
		
		for (var i = 0; i < 4; i++) {
			var curr = i;
			var next = (i+1) % 4;
			
			draw_set_color(make_color_hsv(i * 50, 255, 255));
			draw_circle(
				floor_box.coords[curr].x, floor_box.coords[curr].y, 
				1, false
			);
			
			draw_set_color(c_aqua);	
			draw_line(
				floor_box.coords[curr].x, floor_box.coords[curr].y,
				floor_box.coords[next].x, floor_box.coords[next].y,
			);	
			
			draw_set_color(c_red);	
			draw_line(
				wall_box.coords[curr].x, wall_box.coords[curr].y,
				wall_box.coords[next].x, wall_box.coords[next].y,
			);	
		}
		
		draw_set_color(c_green);
		draw_circle(x, y, 1, false);
		
		draw_set_color(c_white);
	};
	
	collision_object = function(object, expand = 0) {
		return collision_rectangle(
			x - floor_box.hradius - expand,
			y - floor_box.vradius - expand,
			x + floor_box.hradius + expand,
			y + floor_box.vradius + expand,
			object, true, true
		);
	};
	
	is_collision_line = function(point_a, point_b, object = parSolid) {
		update_coords();

		if (object == parSolid) {			
			return (
				collision_line(
					floor(point_a.x), floor(point_a.y), 
					floor(point_b.x), floor(point_b.y), 
					parSolid, true, true
				) || 
				(layer == 0 && collision_line(
					floor(point_a.x), floor(point_a.y), 
					floor(point_b.x), floor(point_b.y), 
					parHigh, true, true
				)) ||
				(layer == 1 && collision_line(
					floor(point_a.x), floor(point_a.y), 
					floor(point_b.x), floor(point_b.y), 
					parLow, true, true
				))
			);
		} else {
			return collision_line(
				floor(point_a.x), floor(point_a.y), 
				floor(point_b.x), floor(point_b.y), 
				object, true, true
			);
		}
	};
	
	
	is_collision_bottom = function(object = parSolid, expand = 0) {
		var temp_radius = floor_box.vradius;
		floor_box.vradius = temp_radius + expand;
		
		var collision = is_collision_line(
			floor_box.coords[2],
			floor_box.coords[3], 
			object
		);
		
		if (object == parSolid && !collision)
			collision = is_collision_line(
				floor_box.coords[2],
				floor_box.coords[3], 
				parPlatform
			);
		
		floor_box.vradius = temp_radius;
		
		return collision;
	};
	
	
	is_collision_top = function(object = parSolid, expand = 0) {
		var temp_radius = floor_box.vradius;
		floor_box.vradius = temp_radius + expand;
		
		var collision = is_collision_line(
			floor_box.coords[0],
			floor_box.coords[1], 
			object
		);
		
		floor_box.vradius = temp_radius;
		
		return collision;
	};
	
	
	is_collision_left = function(object = parSolid, expand = 0) {
		var temp_radius = wall_box.hradius;
		wall_box.hradius = temp_radius + expand;
			
		var collision = is_collision_line(
			wall_box.coords[0],
			wall_box.coords[3], 
			object
		);
		
		wall_box.hradius = temp_radius;
		
		return collision;
	};
	
	
	is_collision_right = function(object = parSolid, expand = 0) {
		var temp_radius = wall_box.hradius;
		wall_box.hradius = temp_radius + expand;
		
		var collision = is_collision_line(
			wall_box.coords[1],
			wall_box.coords[2], 
			object
		);
		
		wall_box.hradius = temp_radius;
		
		return collision;
	};
	

	is_collision_ground = function() {
				
		var temp_radius = floor_box.vradius;
		
		for (var i = 0; i < temp_radius+max_expand; i++) {
			floor_box.vradius = i;
			
			if (is_collision_bottom()) {
				floor_box.vradius = temp_radius;
				update_coords();
				
				return true;
			}
		}
		
		floor_box.vradius = temp_radius;
		update_coords();
		
		return false;
	};
	
	
	is_collision_left_edge = function() {
		var dst_point = {
			x: floor_box.coords[3].x + max_expand * dsin(angle),
			y: floor_box.coords[3].y + max_expand * dcos(angle)
		};
		
		return (
			is_collision_line(
				floor_box.coords[3], dst_point, parSolid
			) ||
			is_collision_line(
				floor_box.coords[3], dst_point, parPlatform
			) 
		);	
	};
	
	
	is_collision_right_edge = function() {
		var dst_point = {
			x: floor_box.coords[2].x + max_expand * dsin(angle),
			y: floor_box.coords[2].y + max_expand * dcos(angle)
		};
		
		return (
			is_collision_line(
				floor_box.coords[2], dst_point, parSolid
			) ||
			is_collision_line(
				floor_box.coords[2], dst_point, parPlatform
			) 
		);	
		
	};
	
	
	get_ground_angle = function(object = parSolid) {
		if (is_collision_bottom(parSolidNoAngle, 6))
			return angle;
		
		var temp_radius = floor_box.vradius;
		var temp_angle = angle;
		
		var lpoint = { is_found: false, x: 0, y: 0 };
		var rpoint = { is_found: false, x: 0, y: 0 };
		
		angle = round(temp_angle / 10) * 10;
		
		for (var i = 0; i < max_expand; i++) {
			floor_box.vradius = temp_radius + i;
			//update_coords();
			
			if (
				(
					is_collision_line(
						floor_box.coords[3], floor_box.coords[3],
						object
					) ||
					is_collision_line(
						floor_box.coords[3], floor_box.coords[3],
						parPlatform
					)
				) && 
				!lpoint.is_found
			) {
				lpoint.is_found = true;
				lpoint.x = floor_box.coords[3].x;
				lpoint.y = floor_box.coords[3].y;
			}
			
			if (
				(
					is_collision_line(
						floor_box.coords[2], floor_box.coords[2],
						object
					) ||
					is_collision_line(
						floor_box.coords[2], floor_box.coords[2],
						parPlatform
					) 
				) &&
				!rpoint.is_found
			) {
				rpoint.is_found = true;
				rpoint.x = floor_box.coords[2].x;
				rpoint.y = floor_box.coords[2].y;
			}
		}
		
		floor_box.vradius = temp_radius;
	
		angle = temp_angle;
		update_coords();
		
		var new_angle = 0;
					   
		if (rpoint.is_found && lpoint.is_found) {
			new_angle = point_direction(
				lpoint.x, lpoint.y, rpoint.x, rpoint.y
			);
		}
		
		/*
		var tollerance = 5;
		
		if (abs(angle_difference(new_angle, temp_angle)) < tollerance)
			new_angle = temp_angle;
		
		if (new_angle >= 360 - tollerance || new_angle <= 0 + tollerance)
			new_angle = 0;
			
		if (new_angle >= 90 - tollerance && new_angle <= 90 + tollerance)
			new_angle = 90;
			
		if (new_angle >= 180 - tollerance && new_angle <= 180 + tollerance)
			new_angle = 180;
			
		if (new_angle >= 270 - tollerance  && new_angle <= 270 + tollerance)
			new_angle = 270;
		*/
		
		
		return floor(new_angle);
	};
	
	

}