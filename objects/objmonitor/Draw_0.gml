/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе


image_index = (global.tick) % 4;

draw_sprite(sprMonitor, image_index, x, y);

if (item != ITEM_NONE && image_index % 2 == 1)
	draw_sprite(sprMonitorIcons, item, x, y);








