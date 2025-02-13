timer--;
if (timer == 0) {
    is_lowered = !is_lowered; 
    timer = duration;
}

x = lerp(x, xstart - lengthdir_y(sprite_height * is_lowered, image_angle), 0.2);
y = lerp(y, ystart + lengthdir_x(sprite_height * is_lowered, image_angle), 0.2);