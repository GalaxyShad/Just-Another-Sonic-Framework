

image_alpha -= SPD;
if (image_alpha <= 0)
	instance_destroy();


gpu_set_fog(true,image_blend,0,0);
draw_self();
gpu_set_fog(false,c_white,0,0);

//draw_self();
