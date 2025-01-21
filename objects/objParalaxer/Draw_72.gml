
var _cam = camera_get_active();

var _cam_x = camera_get_view_x(_cam);
var _cam_y = camera_get_view_y(_cam);
var _cam_right = _cam_x + camera_get_view_width(_cam);

var keys = variable_struct_get_names(bg_map);
for (var i = 0; i < array_length(keys); i++) {
    var k = keys[i];
    var _layer_data = bg_map[$ k];

	var _layer_x = _cam_x * _layer_data.depth_factor + _layer_data.x_shift;

	if ((_layer_x + _layer_data.width) < _cam_x) {
		_layer_data.x_shift += _layer_data.width;
	}

	if ((_layer_x + _layer_data.width) > _cam_right) {
		_layer_data.x_shift -= _layer_data.width;
	}
	
	for (var l = 0; l < 2; l++) {
		var v = (l == 1) ? _layer_data.secondary : _layer_data.primary;
		
		for (var j = 0; j < array_length(v); j++) {
			var el = v[j];
			
			var _spr_x = _layer_x + el.start_x;

			layer_sprite_x(el.sprite_id, _spr_x);
			layer_sprite_y(el.sprite_id, _cam_y + el.start_y);
		}
	}

	

}

