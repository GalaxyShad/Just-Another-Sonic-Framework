

shader_set(shader);

shader_set_uniform_f(
	shader_get_uniform(shader, $"reductionFactor"), 
	step
);

draw_surface(application_surface, 0, 0);
			
shader_reset();

step += speed;
if (step > 2) {	
	instance_destroy();
	if (self[$ "on_finish"] != undefined) {
		
		var _t = self[$ "on_finish"];
		var _ctx = _t[0];
		var _func = _t[1];

		_func(_ctx);
	
	}
}