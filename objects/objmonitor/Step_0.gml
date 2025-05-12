
if (!is_falling)
	exit;
	

vspeed += 0.21875;

if (place_meeting_platform(x, y+vspeed-1) && vspeed < 0) {
	vspeed = 0;
	
	while (!place_meeting_platform(x, y))
		y--;
		
	while (place_meeting_platform(x, y+2))
		y++;
}

if (place_meeting_platform(x, y+vspeed+1) && vspeed > 0) {
	while (!place_meeting_platform(x, y))
		y++;
		
	while (place_meeting_platform(x, y+2))
		y--;
		
	vspeed = 0;
	
	y = round(y);
	
	is_falling = false;
} 










