

if (collision_line(x, y, x, y+64, parSolid, true, true)) {
	while (!collision_line(x, y, x, y+15, parSolid, true, true)) {
		y++;
	}
	
	while (collision_line(x, y, x, y+15, parSolid, true, true)) {
		y--;	
	}
	
} else {
	hspeed = -hspeed;
}

if (
	(collision_line(x, y, x - 16, y, parSolid, true, true) && hspeed < 0)
	|| (collision_line(x, y, x + 16, y, parSolid, true, true) && hspeed > 0)
) {
	hspeed = -hspeed;
}


if (hspeed != 0)
	image_xscale = -sign(hspeed); 

if (tick % 10 == 0) {
	instance_create_depth(x + 20 * image_xscale, y, depth+1, objSfxMotobugExhaust, { hspeed: 1 * image_xscale });
}

tick++;


