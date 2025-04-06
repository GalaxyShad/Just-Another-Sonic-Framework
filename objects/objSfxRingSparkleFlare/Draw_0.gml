image_xscale -= 0.01;
image_alpha -= 0.1;
image_yscale = image_xscale;

if (image_alpha <= 0) {
    instance_destroy();
}

gpu_set_blendmode(bm_add);

draw_self();
gpu_set_blendmode(bm_normal);