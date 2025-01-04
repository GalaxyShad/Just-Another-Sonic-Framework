
scale = 1;

resize = function(_scale) {
	VIEW_WIDTH =	426 * _scale;// 426  480
	VIEW_HEIGHT =	240 * _scale;// 240  270
	
	wnd_scale = 3 / _scale;

	window_set_size(VIEW_WIDTH * wnd_scale, VIEW_HEIGHT * wnd_scale);

	surface_resize(application_surface, window_get_width(), window_get_height());
	
	scale = _scale;
	
	view_enabled = true;
	view_visible[view_current] = true;

	camera_set_view_size(view_camera[view_current], VIEW_WIDTH, VIEW_HEIGHT);
}




#macro MAX_SPD 24



offset_x = 0;
offset_y = 0;

lag_timer = 0;

set_lag_timer = function(_value) { lag_timer = _value; }

resize(1);
