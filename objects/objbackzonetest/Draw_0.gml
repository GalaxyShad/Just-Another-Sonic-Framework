

var _height = 256 / 32;

var _x = camera_get_view_x(view_camera[0]);
var _y = camera_get_view_y(view_camera[0]);
var _w = camera_get_view_width(view_camera[0])
var _h = camera_get_view_height(view_camera[0])

for (var i = 0; i < _height; i++) {
	draw_sprite_tiled_ext(sprBackZoneTest, 0, _x * min(0.10 + i / 10, 0.9),  _y + (i * 16),
						 (i + 1) / 6 + 1, 1, make_color_hsv(160, 100, 255-i*24), 1);
	draw_sprite_tiled_ext(sprBackZoneTest, 0, _x * min(0.10 + i / 10, 0.9),  _y - 16 - (i * 16),
						 (i + 1) / 6 + 1, 1, make_color_hsv(160, 100, 255-i*24), 1);
				
}   
