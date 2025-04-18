
plr.state_machine.step();

array_foreach(plr.behavior_loop.get_loop(), function(_value, _index) {
	if (plr.behavior_loop.is_function_available(_value)) _value(plr);
});

array_foreach(plr.handle_loop.get_loop(), function(_value, _index) {
	if (plr.handle_loop.is_function_available(_value)) _value(plr);
});

if (keyboard_check_pressed(vk_f2)) {
	if !instance_exists(objMenu) {
		instance_create_depth(32, 512, -100000, objMenu);
	}
}
