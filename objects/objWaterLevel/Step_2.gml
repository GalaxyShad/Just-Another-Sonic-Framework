var _cam_width	= camera_get_view_width(view_camera[0]);
var	_cam_height	= camera_get_view_height(view_camera[0]);
var _pos_x = camera_get_view_x(view_camera[0]);
var _pos_y = camera_get_view_y(view_camera[0]);


//var _scale_factor = _cam_height / _surface_height;
//var _top = (y - _pos_y) / _scale_factor;

/*
draw_surface_part_ext(
	surface_water, 
	0,					_top, 
	_surface_width,		_surface_height - _top,
	_pos_x,				y,
	_scale_factor,		_scale_factor,
	c_white, 1
); */

image_xscale = _cam_width;
image_yscale = _cam_height;
x = _pos_x;
y = y;