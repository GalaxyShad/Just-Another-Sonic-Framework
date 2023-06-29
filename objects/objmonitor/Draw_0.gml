/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе


image_index = (global.tick) % 4;

draw_sprite_ext(sprMonitor, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);

if (item != ITEM_NONE && image_index % 2 == 1)
	draw_sprite_ext(sprMonitorIcons, item, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);








