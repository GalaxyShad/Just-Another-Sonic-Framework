state();

fire_anim_frame = fire_anim_timer;
fire_anim_frame /= 3;
fire_anim_frame += 3;

fire_anim_timer++;
if (fire_anim_timer >= 6) {
    fire_anim_timer = 0;
}

image_xscale = is_facing_right ? -1 : 1;