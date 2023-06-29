
#macro SINE_RADIUS	4	
#macro SINE_SPD		0.0078125

#macro Y_SPEED		-0.5

END_FRAMES = [2, 4, 6]

vspeed		= Y_SPEED;
image_speed = 0.25;

enum Sizes {
	Small,
	Medium,
	Big
};

size		= Size;
sine_value	= 0;

oWater = instance_nearest(x, y, objWaterLevel);

if (!oWater) instance_destroy();

depth = oWater.depth;