
function PlayerLoop(_player) constructor {
	__player = _player;
	__function_accessibility = {};
	__function_list = [];
	
	static add = function(_function) {
		var _func_name = script_get_name(_function);
		
		array_push(__function_list, _function);
		__function_accessibility[$ _func_name] = true;
		
		return self;
	}
	
	static enable_all = function() {
		struct_foreach(__function_accessibility, function(_key) {
			__function_accessibility[$ _key] = true;
		});
	}
	
	static disable_all = function() {
		struct_foreach(__function_accessibility, function(_key) {
			__function_accessibility[$ _key] = false;
		});
	}
	
	static enable = function(_function) {
		var _func_name = script_get_name(_function);
		__function_accessibility[$ _func_name] = true;
	}
	
	static disable = function(_function) {
		var _func_name = script_get_name(_function);
		__function_accessibility[$ _func_name] = false;
	}
	
	static is_function_available = function(_function) {
		var _func_name = script_get_name(_function);
		return __function_accessibility[$ _func_name];
	}
	
	static get_loop = function() {
		return 	__function_list;
	}
	
}