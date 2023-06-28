/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе

if (!is_falling)
	exit;
	

vspeed += 0.21875;

if (place_meeting(x, y+vspeed-1, parSolid) && vspeed < 0) {
	vspeed = 0;
	
	while (!place_meeting(x, y, parSolid))
		y--;
		
	while (place_meeting(x, y+2, parSolid))
		y++;
}

if (place_meeting(x, y+vspeed+1, parSolid) && vspeed > 0) {
	while (!place_meeting(x, y, parSolid))
		y++;
		
	while (place_meeting(x, y+2, parSolid))
		y--;
		
	vspeed = 0;
	
	y = round(y);
	
	is_falling = false;
} 










