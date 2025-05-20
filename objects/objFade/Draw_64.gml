


shader_set(shader);


shader_set_uniform_f(
	shader_get_uniform(shader, $"reductionFactor"), 
	step
);

draw_surface(application_surface, 0, 0);
			
shader_reset();

// Crutch to not apply blue shader to title card 
if (instance_exists(objTitleCard)) {
	draw_surface_stretched(objTitleCard.title_card_surface, 0, 0, surface_get_width(application_surface), surface_get_height(application_surface));
}

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