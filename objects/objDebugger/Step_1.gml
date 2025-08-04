if (keyboard_check_pressed(ord("C"))) {
	var _changer = instance_find(objCharacterChanger, 0);
	if (_changer != noone)
		_changer.change(inst_player);
}

if (keyboard_check_pressed(ord("R")))
	room_restart();

if keyboard_check(ord("1"))
	game_set_speed(60, gamespeed_fps);
else if keyboard_check(ord("2"))
	game_set_speed(20, gamespeed_fps);
else if keyboard_check(ord("3"))
	game_set_speed(10, gamespeed_fps);
else if keyboard_check(ord("4"))
	game_set_speed(5, gamespeed_fps);
else if keyboard_check(ord("5"))
	game_set_speed(1, gamespeed_fps);
	
if (keyboard_check_pressed(ord("A")))
	show_debug_info = !show_debug_info;