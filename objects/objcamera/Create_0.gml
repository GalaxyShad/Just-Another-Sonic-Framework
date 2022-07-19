/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе


#macro VIEW_WIDTH	480//426
#macro VIEW_HEIGHT	270//240

offset_x = 0;
offset_y = 0;

lagTimer = 0;

wndScale = 3;

window_set_size(VIEW_WIDTH * wndScale, VIEW_HEIGHT * wndScale);

surface_resize(application_surface, window_get_width(), window_get_height());

