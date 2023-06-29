// Ресурсы скриптов были изменены для версии 2.3.0, подробности см. по адресу
// https://help.yoyogames.com/hc/en-us/articles/360005277377
function Timer2(_count, _auto_restart = false, _callback = function(){}) constructor {
	__initital_count = _count;
	__callback_function = _callback;
	__auto_restart = _auto_restart;
	
	__count = undefined;
	__running = false;
	
	
	
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