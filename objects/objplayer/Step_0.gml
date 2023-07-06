state.step();

if (state.current() == "die") {
	ysp += physics.gravity_force;
	
	y += ysp;
	
	camera.set_lag_timer(1);
	
	exit;
}


struct_foreach(behavior_loop.get_loop(), function(_key, _value) {
	var _fun = _value.func;
			
	if (_value.active == true)
		_fun();
});

struct_foreach(handle_loop.get_loop(), function(_key, _value) {
	var _fun = _value.func;
			
	if (_value.active == true)
		_fun();
});





if (allow_jump && ground && is_key_action_pressed) {
	ground = false;
	
	ysp -= physics.jump_force * dcos(sensor.get_angle()); 
	xsp -= physics.jump_force * dsin(sensor.get_angle()); 
	
	state.change_to("jump");
	
	audio_play_sound(sndPlrJump, 0, false);
} 

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


	



	
