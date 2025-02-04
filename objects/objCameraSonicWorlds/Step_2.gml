if (keyboard_check_pressed(ord("P"))) {
	resize(scale + 1);	
}

if (keyboard_check_pressed(ord("O"))) {
	resize(scale - 1);	
}

var _o_follow = FollowingObject;

if (!_o_follow)
	exit;
	
if (!instance_exists(_o_follow))
	return;
	
if (lag_timer > 0) {
	lag_timer--;
	exit;
}
	

if (object_get_parent(_o_follow.object_index) == objPlayer) {	
	if ( (abs(_o_follow.gsp) >= 5 && _o_follow.ground) || (abs(_o_follow.xsp) >= 5) ) {
		var _max_offset = 120;
		var _speed_factor = 0.03;

		var _follow_angle = point_direction(_o_follow.xprevious, _o_follow.yprevious, _o_follow.x, _o_follow.y);

		offset_x += (lengthdir_x(_max_offset, _follow_angle) - offset_x) * _speed_factor;
		offset_y += (lengthdir_y(_max_offset, _follow_angle) - offset_y) * _speed_factor;

		offset_x = clamp(offset_x, -_max_offset, _max_offset);
		offset_y = clamp(offset_y, -_max_offset, _max_offset);
	} else if (_o_follow.state.is_one_of(["spindash", "peelout"])) {
		var _max_offset = 120;
		
		offset_x += (_max_offset - offset_x) * 0.1 * _o_follow.image_xscale;

		offset_x = clamp(offset_x, -_max_offset, _max_offset);
	} else {
		offset_x += -offset_x * 0.1;
	}

	follow_x += (_o_follow.x + offset_x - follow_x) * 0.2;
	follow_y += (_o_follow.y + offset_y - follow_y) * 0.2;

	if (_o_follow.ground == false) {
		margin_vertical = lerp(margin_vertical, 32, 0.2);
	} else {
		margin_vertical = lerp(margin_vertical, 0, 0.1);
	}

	if (follow_x > x ) 		 x = follow_x;
	if (follow_x < x - 16 )  x = follow_x + 16;

	if (follow_y > y + margin_vertical) y = follow_y - margin_vertical;
	if (follow_y < y - margin_vertical) y = follow_y + margin_vertical;
}

var _cx = clamp(x - VIEW_WIDTH  / 2, 0, room_width - VIEW_WIDTH);
var _cy = clamp(y - VIEW_HEIGHT / 2, 0, room_height - VIEW_HEIGHT);

camera_set_view_pos(view_camera[view_current], _cx, _cy);

