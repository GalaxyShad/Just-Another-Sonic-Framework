/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе

if (mode == 0) {
	var _oPlayer = instance_nearest(x, y, objPlayer);
	
	if (_oPlayer != noone) {
		if ((distance_to_object(_oPlayer) < 64) && _oPlayer.shield == 4) {
			is_magnetized = true;
		}
		
		if (is_magnetized) {
			var _sx = sign(_oPlayer.x - x);
			var _sy = sign(_oPlayer.y - y);
	
			//check relative movement
			var _tx = (sign(xsp) == _sx)
			var _ty = (sign(ysp) == _sy)
	
	
			var _ringacceleration;
			_ringacceleration[0] = 0.75;
			_ringacceleration[1] = 0.1875;
		
			//add to speed
			xsp += (_ringacceleration[_tx] * _sx)
			ysp += (_ringacceleration[_ty] * _sy)
		}
	}
	
	//move
	x += xsp;
	y += ysp;
}

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








