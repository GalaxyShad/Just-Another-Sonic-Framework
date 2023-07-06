
function PlayerLoop(_player) constructor {
	__player = _player;
	__function_map = {};
	
	static add = function(_function) {
		show_debug_message($"sdds ${_function}")
		
		var _func_name = script_get_name(_function);
		
		__function_map[$ _func_name] = {
			func:	_function,
			active:		true
		};
		
		return self;
	}
	
	static enable_all = function(_function) {
		struct_foreach(__function_map, function(_key, _value) {
			_value.active = true;
		});
	}
	
	static disable_all = function(_function) {
		struct_foreach(__function_map, function(_key, _value) {
			_value.active = false;
		});
	}
	
	static enable = function(_function) {
		var _func_name = script_get_name(_function);
		__function_map[$ _func_name].active = true;
	}
	
	static disable = function(_function) {
		var _func_name = script_get_name(_function);
		__function_map[$ _func_name].active = false;
	}
	
	static get_loop = function() {
		return 	__function_map;
	}
	
}