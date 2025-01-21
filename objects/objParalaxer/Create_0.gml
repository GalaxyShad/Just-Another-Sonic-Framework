bg_map = {};

utils = new SpriteLayerUtils();

array_foreach(layer_get_all(), function(_layer_id) {
	var _layer_name = layer_get_name(_layer_id);

	if (!string_starts_with(_layer_name, "bg")) return;

	var _layer_config = utils.parse_layer_configuration(_layer_id);

	var _camera_w = 426;

	var _w = max(utils.get_layer_width(_layer_id), _camera_w);

	show_debug_message(_layer_name + ": " + string(_w) + " " + string(_camera_w));

	var _primary_elements = layer_get_all_elements(_layer_id);
	var _secondary_elements = utils.clone_sprites_horizontaly(_layer_id, _w);
	
	var _bg_layer_elements = []; 

	var _config_function = function(_x) { return utils.confugure_sprite(_x) };

	var _primary   = array_map(_primary_elements,   _config_function);
	var _secondary = array_map(_secondary_elements, _config_function); 
	
	bg_map[$ _layer_name] = {
		primary: 	_primary,
		secondary: 	_secondary,
		depth_factor: _layer_config.x_depth,
		width: _w,
		x_shift: 0
	};
	
});


