
image_index = (global.tick) % 4;

draw_sprite_ext(sprMonitor, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);

if (item != ITEM_NONE && global.tick % 2 < 1)
	draw_sprite_ext(sprMonitorIcons, item, x, y - 16, image_xscale, image_yscale, image_angle, image_blend, image_alpha);

if (global.tick % 2 >= 1) {
    draw_sprite(sprMonitorIconStatic, ((global.tick / 2) % 3), x, y - 16); 
}






