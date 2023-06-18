/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе

scale = 1;

#macro VIEW_WIDTH	480*scale//426
#macro VIEW_HEIGHT	270*scale//240

#macro MAX_SPD 16

offset_x = 0;
offset_y = 0;

lagTimer = 0;

wndScale = 3 / scale;

window_set_size(VIEW_WIDTH * wndScale, VIEW_HEIGHT * wndScale);

surface_resize(application_surface, window_get_width(), window_get_height());

