
x = xstart + sin(sine_value) * SINE_RADIUS;

sine_value += SINE_SPD;

if (image_index >= END_FRAMES[size])
	image_speed = 0;
	
if (y <= oWater.y)
	instance_destroy();
