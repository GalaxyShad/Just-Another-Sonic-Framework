
function State(_owner) constructor {
	__current_state = undefined;
	
	__state_map = { };
	
	__owner = _owner;
	
	__state = function() {
		return __state_map[$ __current_state];
	}
	
	add = function(_state_name, _state) {
		__state_map[$ _state_name] = _state;
	}
	
	change_to = function(_new_state) {
		var _prev = __state_map[$ __current_state];
		
		if (_prev != undefined && _prev[$ "on_exit"] != undefined) 
			_prev.on_exit(__owner);
			
		__current_state = _new_state;
		
		var _new = __state();
		
		if (_new && _new[$ "on_start"] != undefined)
			_new.on_start(__owner);
	};
	
	step = function() {
		if (!__state()) return;
		
		if (__state()[$ "on_step"] != undefined)
			__state().on_step(__owner);
	};
	
	landing = function() {
		if (!__state()) return;
		
		if (__state()[$ "on_landing"] != undefined)
			__state().on_landing(__owner);
	}
	
	current = function() { 
		return __current_state; 
	}
}