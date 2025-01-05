

var _surface_width	= surface_get_width(application_surface);
var	_surface_height	= surface_get_height(application_surface);

if (!surface_exists(surface_water))
	surface_water = surface_create(_surface_width, _surface_height);

surface_set_target(surface_water);
draw_surface_stretched(application_surface, 0, 0, _surface_width, _surface_height);
draw_set_color(c_white);

draw_set_alpha(1);
//draw_set_alpha(0.3);
draw_set_color(c_blue);
draw_rectangle(0, 0, _surface_width,  _surface_height, false);
draw_set_color(c_white);
draw_set_alpha(1.0);
surface_reset_target();

var _cam_width	= camera_get_view_width(view_camera[0]);
var	_cam_height	= camera_get_view_height(view_camera[0]);
var _pos_x = camera_get_view_x(view_camera[0]);
var _pos_y = camera_get_view_y(view_camera[0]);


var _scale_factor = _cam_height / _surface_height;
var _top = (y - _pos_y) / _scale_factor;

draw_surface_part_ext(
	surface_water, 
	0,					_top, 
	_surface_width,		_surface_height - _top,
	_pos_x,				y,
	_scale_factor,		_scale_factor,
	c_white, 1
);

