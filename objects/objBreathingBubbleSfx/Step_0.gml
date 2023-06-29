/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе


x = xstart + sin(sine_value);

sine_value += 0.125;

if (image_index >= 2)
	image_speed = 0;
	
if (y <= oWater.y)
	instance_destroy();
