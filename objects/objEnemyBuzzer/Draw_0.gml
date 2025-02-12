draw_self();

if (shoot_timer == 0) {
    draw_sprite_ext(
        sprBuzzerFire, fire_anim_frame, 
        x + 32 * image_xscale, y, 
        image_xscale, image_yscale, 
        image_angle, c_white, image_alpha);
}