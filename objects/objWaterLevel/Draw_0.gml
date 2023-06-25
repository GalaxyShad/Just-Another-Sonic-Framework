/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе

var _surface_width	= camera_get_view_width(view_camera[0]);
var	_surface_height	= camera_get_view_height(view_camera[0]);

if (!surface_exists(surface_water))
	surface_water = surface_create(_surface_width, _surface_height);

surface_set_target(surface_water);
draw_surface_stretched(application_surface, 0, 0, _surface_width, _surface_height);
draw_set_color(c_white);
draw_set_alpha(0.2);
draw_rectangle(0, 0, _surface_width,  _surface_height, false);
draw_set_color(c_white);
draw_set_alpha(1.0);
surface_reset_target();

var _pos_x = camera_get_view_x(view_camera[0]);
var _pos_y = camera_get_view_y(view_camera[0]);


draw_surface_part(surface_water, 0, y - _pos_y, _surface_width, _surface_height - (y - _pos_y), _pos_x, y);

