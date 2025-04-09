
if (place_meeting_platform(x, y)) {
	if (floating) {
		hspeed = irandom(1) ? 1 : -1;	
	}
	
	floating = false;	
	image_speed = 0.25;
	
	vspeed = -4;
	
}

vspeed += 0.2;

if (!floating && image_index < 1) {
	image_index = 1;
		
}

if (hspeed != 0)
	image_xscale = sign(hspeed);