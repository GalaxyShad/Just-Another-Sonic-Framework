/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе

var objFollow = objPlayer;
if (!objFollow)
	exit;
	
if (lagTimer > 0) {
	lagTimer--;
	exit;
}
	
var follow_x = objFollow.x + offset_x;
var follow_y = objFollow.y + offset_y;
	
var cx = clamp(x - VIEW_WIDTH  / 2, 0, room_width - VIEW_WIDTH);
var cy = clamp(y - VIEW_HEIGHT / 2, 0, room_height - VIEW_HEIGHT);

var vbox = {
	left:	x - 16,
	right:	x,
	top:	y - 32,
	bottom:	y + 32
};

if (objFollow.x >= vbox.right)
	x += min(follow_x - vbox.right, MAX_SPD)
	
if (objFollow.x <= vbox.left)
	x += max(follow_x - vbox.left, -MAX_SPD)

if (objFollow == objPlayer) {	
	if ( objPlayer.ground) {
		if ( objPlayer.gsp <= 8)
			y += clamp(follow_y - y, -4, 4);
		else 
			y += clamp(follow_y - y, -MAX_SPD, MAX_SPD);
	} else {
		if (follow_y > vbox.bottom)
			y += min(follow_y - vbox.bottom, MAX_SPD);
	
		if (follow_y < vbox.top)
			y += max(follow_y - vbox.top, -MAX_SPD);
	}
}


camera_set_view_pos(view_camera[view_current], cx, cy);

