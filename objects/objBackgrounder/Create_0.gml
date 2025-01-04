

bg_list = [];


array_foreach(layer_get_all(), function(_layer_id) {
	var _layer_name = layer_get_name(_layer_id);
	
	if (string_starts_with(_layer_name, "_bg")) {
		var _bg = layer_get_all_elements(_layer_id)[0];

		var _depth = 0.875;
		
		if (layer_get_element_type(_bg) == layerelementtype_background) {
			array_push(bg_list, {
				layer_id: _layer_id,
				bg_id:	  _bg,
				depth_factor: _depth,//0.975,
				start_x:  layer_get_x(_layer_id) - ((layer_get_x(_layer_id)) * _depth) + 210,
				start_y:  layer_get_y(_layer_id) - ((layer_get_y(_layer_id)) * _depth) + 120,
				is_water: true,
			});	
		}
	}
});











