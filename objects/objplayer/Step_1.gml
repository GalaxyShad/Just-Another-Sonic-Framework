

if (keyboard_check_pressed(ord("R")))
	room_restart();

if (keyboard_check_pressed(ord("D")))
	player_get_hit(plr);
	
if (keyboard_check_pressed(ord("A")))
	show_debug_info = !show_debug_info;
	
if (keyboard_check_pressed(ord("S"))) {
	if (!plr.physics.is_super())  {
		plr.state_machine.change_to("transform");
	} else {
		player_cancel_super_form();	
	}
}

if (keyboard_check_pressed(ord("X"))) {
	plr.state_machine.change_to((plr.state_machine.current() == "noclip") ? "normal" : "noclip");
}

if (keyboard_check_pressed(ord("C"))) {
	var _changer = instance_find(objCharacterChanger, 0);
	if (_changer != noone)
		_changer.change(id);
}

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
	




