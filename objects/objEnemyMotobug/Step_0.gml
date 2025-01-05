

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



