draw_self();

hand_angle = abs(angle_difference(0, hand_angle)) * 0.9 * -sign(image_xscale);

draw_sprite_ext(
    sprCoconutsHand, (image_index + 1) % 2 , 
    x + 10 * sign(image_xscale), y, 
    image_xscale, 1, 
    hand_angle, 
    c_white, 1);