

image_alpha -= SPD;
if (image_alpha <= 0)
	instance_destroy();

draw_self();
