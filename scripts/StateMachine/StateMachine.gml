
function State(_owner) constructor {
	__current_state = undefined;
	
	__state_map = { };
	
	__owner = _owner;
	
	__super_method = undefined;
	
	__state = function() {
		return __state_map[$ __current_state];
	}
	
	add = function(_state_name, _state) {
		if (__state_map[$ _state_name] != undefined) {
			show_error(
				$"[STATE] [{object_get_name(_owner.object_index)}]\n" +
				$"State [{_state}] already exists.\n" +
				"If you want to override state, use [override] function.",
				true
			)
		}
		
		_state.super = function() {
			__super_method(__owner);
			//show_debug_message($"{__owner}");	
		}
		
		__state_map[$ _state_name] = _state;
		
		return self;
	}
	
	override = function(_state_name, _state) {
		if (__state_map[$ _state_name] == undefined) {
			show_error(
				$"[STATE] [{object_get_name(_owner.object_index)}]\n" +
				$"Cannot override state [{_state}], because its not exists.\n",
				true
			)
		}
		
		_state.super = function() {
			__super_method(__owner);
		}
		
		__state_map[$ _state_name] = _state;
	}
	
	change_to = function(_new_state) {
		if (__state_map[$ _new_state] == undefined) {
			show_error(
				$"[STATE] [{object_get_name(__owner.object_index)}]\n" +
				$"State [{_new_state}] does not exist.\n",
				true
			)
		}
		
		var _prev = __state_map[$ __current_state];
		
		if (_prev != undefined && _prev[$ "on_exit"] != undefined) 
			_prev.on_exit(__owner);
			
		__current_state = _new_state;
		
		var _new = __state();
		
		if (_new && _new[$ "on_start"] != undefined)
			_new.on_start(__owner);
	};
	

	__call_if_exists = function(_method_name) {
		if (__state() == undefined) return;
		if (__state()[$ _method_name] == undefined) return;
		
		if (__state()[$ "override_" + _method_name] != undefined) {
			__super_method = __state()[$ _method_name];
			__state()[$ "override_" + _method_name](__owner);
			return;
		}
		
		
		__state()[$ _method_name](__owner);
	}
	

	step = function()	 { __call_if_exists("on_step");		};
	animate = function() { __call_if_exists("on_animate");	};
	landing = function() { __call_if_exists("on_landing");	};
	
	current = function() { 
		return __current_state; 
	};
}