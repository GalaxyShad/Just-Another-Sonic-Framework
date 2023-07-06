state.step();

if (state.current() == "die") {
	ysp += physics.gravity_force;
	
	y += ysp;
	
	camera.set_lag_timer(1);
	
	exit;
}


array_foreach(behavior_loop.get_loop(), function(_value, _index) {
	if (behavior_loop.is_function_available(_value)) _value();
});

array_foreach(handle_loop.get_loop(), function(_value, _index) {
	if (handle_loop.is_function_available(_value)) _value();
});



var _is_moving_right = (ground && gsp > 0) || (!ground && xsp > 0);
var _is_moving_left = (ground && gsp < 0) || (!ground && xsp < 0);

if ((_is_moving_right && sensor.check_expanded(1, 0, sensor.is_collision_solid_right)) || 
	(_is_moving_left  && sensor.check_expanded(1, 0, sensor.is_collision_solid_left))
) {
	if (ground) {
		gsp = 0;
		
		if ((xsp < 0 && is_key_left) || (xsp > 0 && is_key_right))
			state.change_to("push");
	}
	
	xsp = 0;
}


	



	
