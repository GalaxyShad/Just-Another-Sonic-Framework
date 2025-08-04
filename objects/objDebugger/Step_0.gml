if (keyboard_check_pressed(vk_f2)) {
	if !instance_exists(objMenu) {
		instance_create_depth(32, 512, -100000, objMenu);
	}
}