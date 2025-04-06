
plr.state_machine.step();

array_foreach(behavior_loop.get_loop(), function(_value, _index) {
	if (behavior_loop.is_function_available(_value)) _value(plr);
});

array_foreach(handle_loop.get_loop(), function(_value, _index) {
	if (handle_loop.is_function_available(_value)) _value(plr);
});

if (keyboard_check_pressed(vk_f2)) {
	if !instance_exists(objMenu) {
		instance_create_depth(32, 512, -100000, objMenu);
	}
}
