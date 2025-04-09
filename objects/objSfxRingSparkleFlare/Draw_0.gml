image_xscale -= 0.01;
image_alpha -= 0.1;
image_yscale = image_xscale;

if (image_alpha <= 0) {
    instance_destroy();
}

gpu_set_blendmode(bm_add);

draw_self();
draw_sprite_ext(sprite_index, 0, x, y, image_xscale * 0.25, image_yscale * 0.25, 0, c_white, 1);
gpu_set_blendmode(bm_normal);