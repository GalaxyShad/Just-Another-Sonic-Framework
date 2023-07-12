/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе

scale = 2;

#macro VIEW_WIDTH	426 * scale// 426  480
#macro VIEW_HEIGHT	240 * scale// 240  270

#macro MAX_SPD 24



offset_x = 0;
offset_y = 0;

lag_timer = 0;

set_lag_timer = function(_value) { lag_timer = _value; }

wnd_scale = 3 / scale;

window_set_size(VIEW_WIDTH * wnd_scale, VIEW_HEIGHT * wnd_scale);

surface_resize(application_surface, window_get_width(), window_get_height());

