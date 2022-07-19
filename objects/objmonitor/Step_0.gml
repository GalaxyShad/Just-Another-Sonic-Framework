/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе

if (!is_falling)
	exit;
	
vspeed += 0.125;

if (place_meeting(x, y+vspeed, parSolid)) {
	while (!place_meeting(x, y+1, parSolid))
		y++;
		
	vspeed = 0;
}








