

var _draw_water = function(_bg, _cam_x, _cam_y) {
	layer_set_visible(_bg.layer_id, false);
	
	var _sprite_index	= layer_background_get_sprite(_bg.bg_id);
	var _image_index	= layer_background_get_index(_bg.bg_id);
	
	var _sprite_width   = sprite_get_width(_sprite_index);
	var _sprite_height	= sprite_get_height(_sprite_index);
	
	var _draw_sprite_part_tiled_x = function(_sprite, _index, _left, _top, 
		_width, _height, _x, _y, _xscale, _yscale, _blend, _alpha
	) {
	
	
		var _cam_x		= camera_get_view_x(view_camera[0]);
		var _cam_width	= camera_get_view_width(view_camera[0]);	
		
		var _spr_width = sprite_get_width(_sprite);
		var _num_parts = _cam_width / _spr_width;
	
		for (var i = 0; i < _num_parts+1; i++) {
			var _start = _cam_x div _spr_width;
			
			draw_sprite_part_ext(_sprite, _index, _left, _top, _width, _height, 
								 (_start + i) * _spr_width + _x mod _cam_width, _y, _xscale, _yscale, _blend, _alpha);		
		}
	}

	for (var i = 0; i < _sprite_height+1; i++) {		
		_draw_sprite_part_tiled_x(
			_sprite_index, _image_index,
			0, i, 
			_sprite_width, 1,
			_bg.start_x + _cam_x * (_bg.depth_factor + 0.010 * i),
			_bg.start_y + _cam_y * (_bg.depth_factor) + i,
			layer_background_get_xscale(_bg.bg_id),
			layer_background_get_yscale(_bg.bg_id),
			layer_background_get_blend(_bg.bg_id),
			layer_background_get_alpha(_bg.bg_id)
		)	
	}
};

var _draw_bg = function(_bg, _cam_x, _cam_y) {
	layer_x(_bg.layer_id, _bg.start_x + _cam_x * _bg.depth_factor);
	layer_y(_bg.layer_id, _bg.start_y + _cam_y * _bg.depth_factor);
}

for (var i = 0; i < array_length(bg_list); i++) {
	var _bg = bg_list[i];

	var _cam_x = camera_get_view_x(view_camera[0]);
	var _cam_y = camera_get_view_y(view_camera[0]);
	
	if (_bg.is_water)
		_draw_water(_bg, _cam_x, _cam_y);
	else
		_draw_bg(_bg, _cam_x, _cam_y);

}









