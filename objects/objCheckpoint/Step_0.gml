
var plr = instance_place(x, y, objPlayer);

if (plr != noone) {
	
	var _x = plr.x;
	var _y = plr.y;
	
	_x = ball_start_pos.x + plr.plr.xsp * 8;
	_y = ball_start_pos.y + plr.plr.ysp * 8; 
	
	ball_pos.x += (_x - ball_pos.x) / 4;
	ball_pos.y += (_y - ball_pos.y) / 4;
	
	activated = true;
} else {
	
	if (activated) {
		global.last_checkpoint_instance = self;
	
		image_speed = 0.25;
	}

	ball_acc.x = -(ball_pos.x - ball_start_pos.x) / 4;
	ball_acc.y = -(ball_pos.y - ball_start_pos.y) / 4;

	ball_speed.x -= 0.25 * sign(ball_speed.x);
	ball_speed.y -= 0.25 * sign(ball_speed.y);

	ball_speed.x += ball_acc.x;
	ball_speed.y += ball_acc.y; 

	if (abs(ball_speed.y) > 1) {
		ball_pos.y += ball_speed.y;
	} else {
		ball_speed.y = 0;
	}
	
	if (abs(ball_speed.x) > 1) {
		ball_pos.x += ball_speed.x;
	} else {
		ball_speed.x = 0;	
	}

}

