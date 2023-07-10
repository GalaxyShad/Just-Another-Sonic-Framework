
function Timer2(_count, _auto_restart = false, _callback = function(){}) constructor {
	__initital_count = _count;
	__callback_function = _callback;
	__auto_restart = _auto_restart;
	
	__count = undefined;
	__running = false;
	
	is_zero = function() {
		return (__count == 0);	
	}
	
	is_ticking = function() {
		return __running;	
	};
	
	start = function() {
		__running = true;	
	};
	
	stop = function() {
		__running = false;	
	};
	
	reset = function() {
		__count = __initital_count;	
	};
	reset();
	
	get_count = function() {
		return __count;	
	};
	
	reset_and_start = function() {
		reset();
		start();
	};
	
	tick = function() {
		if (!__running)
			return;
		
		__count--;
		
		if (__count == 0) {
			__callback_function();	
			reset();
			
			if (!__auto_restart) 
				__running = false;
		}
	};
}