shader_set(shBlueFade);

shader_set_uniform_f(
	shader_get_uniform(shBlueFade, $"reductionFactor"), 
	bright
);
			
bright -= 0.1;
if (bright < 0) {
	shader_reset();
	instance_destroy();
}
	