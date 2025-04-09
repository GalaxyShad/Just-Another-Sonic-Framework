

if (collision_line_platform(x, y, x, y+64)) {
	repeat 128 {
		if (!collision_line_platform(x, y, x, y+15)) {
			y++;
		} else {
			break;
		}
	}
	
	repeat 128 {
		if (collision_line_platform(x, y, x, y+15)) {
			y--;	
		} else {
			break;
		}
	}
	
} else {
	hspeed = -hspeed;
}

if (
	(collision_line_platform(x, y, x - 16, y) && hspeed < 0)
	|| (collision_line_platform(x, y, x + 16, y) && hspeed > 0)
) {
	hspeed = -hspeed;
}


if (hspeed != 0)
	image_xscale = -sign(hspeed); 

if (tick % 10 == 0) {
	instance_create_depth(x + 20 * image_xscale, y, depth+1, objSfxMotobugExhaust, { hspeed: 1 * image_xscale });
}

tick++;


