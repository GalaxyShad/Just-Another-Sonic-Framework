/// @description Producing

var _x_shift	= irandom_range(-8, +7);
var _index		= 6 - amount;
var _size		= SIZES_SET[current_set][_index];


if (!was_big_bubble && (amount == 1 || irandom_range(1, 4) == 1)) {
	instance_create_depth(x + _x_shift, y, depth, objBigBubble);
	was_big_bubble = true;
} else if (was_big_bubble)  {
	instance_create_depth(x + _x_shift, y, depth, objBubble, { Size: _size });
} 

amount--;

if (amount == 0) {
	alarm[0] = 1;	 
} else {
	alarm[1] = irandom_range(1, 31);	
}