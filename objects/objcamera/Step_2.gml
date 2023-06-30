/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе

var _o_follow = objPlayer;

if (!_o_follow)
	exit;
	
if (lag_timer > 0) {
	lag_timer--;
	exit;
}
	
var _follow_x = _o_follow.x + offset_x;
var _follow_y = _o_follow.y + offset_y;
	
var _cx = clamp(x - VIEW_WIDTH  / 2, 0, room_width - VIEW_WIDTH);
var _cy = clamp(y - VIEW_HEIGHT / 2, 0, room_height - VIEW_HEIGHT);

var _vbox = {
	left:	x - 16,
	right:	x,
	top:	y - 32,
	bottom:	y + 32
};

if (_o_follow.x >= _vbox.right)
	x += min(_follow_x - _vbox.right, MAX_SPD)
	
if (_o_follow.x <= _vbox.left)
	x += max(_follow_x - _vbox.left, -MAX_SPD)

if (_o_follow == objPlayer) {	
	if ( objPlayer.ground) {
		if ( objPlayer.gsp <= 8)
			y += clamp(_follow_y - y, -4, 4);
		else 
			y += clamp(_follow_y - y, -MAX_SPD, MAX_SPD);
	} else {
		if (_follow_y > _vbox.bottom)
			y += min(_follow_y - _vbox.bottom, MAX_SPD);
	
		if (_follow_y < _vbox.top)
			y += max(_follow_y - _vbox.top, -MAX_SPD);
	}
}
else{
	y += clamp(_follow_y - y, -4, 4);
}


camera_set_view_pos(view_camera[view_current], _cx, _cy);

