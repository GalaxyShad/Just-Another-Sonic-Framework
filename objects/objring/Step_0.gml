/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе

if mode != 1
	exit;

ysp += 0.09375;

if (place_meeting(x, y+ysp, parSolid)) {
	ysp *= -0.75;	
}

if (place_meeting(x+xsp, y, parSolid)) {
	xsp *= -0.75;	
}

x += xsp;
y += ysp;

if (life_span > 0)
	life_span--;
else
	instance_destroy();








