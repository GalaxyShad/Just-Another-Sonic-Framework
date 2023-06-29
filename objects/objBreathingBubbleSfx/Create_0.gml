/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе

vspeed = -1;
image_speed = 0.25;

sine_value = 0;

oWater = instance_nearest(x, y, objWaterLevel);

if (!oWater)
	instance_destroy();
	
if (choose(1, 2) == 2 && CanCreateNew)
	alarm[0] = irandom_range(6, 16);