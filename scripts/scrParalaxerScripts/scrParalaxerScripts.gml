
function SpriteLayerUtils() constructor {

	get_layer_width = function(_layer_id) {
		var _elements = layer_get_all_elements(_layer_id);
	
		return array_reduce(_elements, function (a, b) {
			var _a_x = layer_sprite_get_x(a) + sprite_get_width(layer_sprite_get_sprite(a)) 
											   * layer_sprite_get_xscale(a);
	
			var _b_x = layer_sprite_get_x(b) + sprite_get_width(layer_sprite_get_sprite(b)) 
											   * layer_sprite_get_xscale(b);

			show_debug_message(string(_a_x) + " " + string(_b_x));
	
			return max(_a_x, _b_x);
		}, 0);
	}
	
	clone_sprite = function(_layer_id, _x, _y, _spr_id) {
		var _spr_asset = layer_sprite_get_sprite(_spr_id);
	
		var _new_spr = layer_sprite_create(_layer_id, _x, _y, _spr_asset);
	
		layer_sprite_alpha(_new_spr, layer_sprite_get_alpha(_spr_id));
		layer_sprite_angle(_new_spr, layer_sprite_get_angle(_spr_id));
		layer_sprite_blend(_new_spr, layer_sprite_get_blend(_spr_id));
		layer_sprite_index(_new_spr, layer_sprite_get_index(_spr_id));
		layer_sprite_speed(_new_spr, layer_sprite_get_speed(_spr_id));
		layer_sprite_xscale(_new_spr, layer_sprite_get_xscale(_spr_id));
		layer_sprite_yscale(_new_spr, layer_sprite_get_yscale(_spr_id));

		return _new_spr;
	}

	clone_sprites_horizontaly = function(_layer_id, _x) {
		var _sprite_list = layer_get_all_elements(_layer_id);

		var _cloned_sprites = [];

		for (var i = 0; i < array_length(_sprite_list); i++) {
			var _sprite = _sprite_list[i];

			var _sprite_x = layer_sprite_get_x(_sprite);
			var _sprite_y = layer_sprite_get_y(_sprite); 
			
			var _cloned_spr = clone_sprite(_layer_id, _x + _sprite_x, _sprite_y, _sprite);

			array_push(_cloned_sprites, _cloned_spr);
		}
		
		return _cloned_sprites;
	}

	confugure_sprite = function(_sprite_id) {
		return {
			sprite_id: _sprite_id,
			start_x:  layer_sprite_get_x(_sprite_id),
			start_y:  layer_sprite_get_y(_sprite_id),
		}
	}

	parse_layer_configuration = function(_layer_id) {
		var _layer_name = layer_get_name(_layer_id);
		var _layer_tokens = string_split(_layer_name, "_");

		var _config = {
			x_depth: 1,
			y_depth: 1
		}

		for (var i = 0; i < array_length(_layer_tokens); i++) {
			var _token = _layer_tokens[i];

			if (_token == "x") {
				_config.x_depth = real(_layer_tokens[i+1]) / 100.0;
			}
		}

		return _config;
	}
}



