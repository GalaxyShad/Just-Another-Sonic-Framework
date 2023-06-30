
#macro SINE_RADIUS	4	
#macro SINE_SPD		0.0078125

#macro Y_SPEED		-0.5

__end_frames = [2, 4, 6]
#macro END_FRAMES __end_frames

vspeed		= Y_SPEED;
image_speed = 0.25;

enum Sizes {
	Small,
	Medium,
	Big
};

size		= Size;
sine_value	= 0;

o_water = instance_nearest(x, y, objWaterLevel);

if (!o_water) instance_destroy();

depth = o_water.depth;