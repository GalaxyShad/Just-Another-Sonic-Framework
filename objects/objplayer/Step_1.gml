/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе

is_key_left		= keyboard_check(vk_left);
is_key_right	= keyboard_check(vk_right);
is_key_up		= keyboard_check(vk_up);
is_key_down		= keyboard_check(vk_down);
is_key_action	= keyboard_check(ord("Z")) || keyboard_check(ord("X")) || keyboard_check(ord("C")) || keyboard_check(vk_numpad0);
is_key_action_pressed = keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(ord("X")) || keyboard_check_pressed(ord("C")) || keyboard_check_pressed(vk_numpad0);

if (keyboard_check_pressed(ord("R")))
	room_restart();

if (keyboard_check_pressed(ord("D")))
	player_get_hit();
	
if (keyboard_check_pressed(ord("A")))
	show_debug_info = !show_debug_info;
	
if (keyboard_check_pressed(ord("S"))) {
	if (!physics.is_super()) 
		player_set_super_form();
	else 
		player_cancel_super_form();	
		
	animator.set("idle");
}

if keyboard_check(ord("2"))
	game_set_speed(20, gamespeed_fps);
else if keyboard_check(ord("1"))
	game_set_speed(60, gamespeed_fps);
else if keyboard_check(ord("3"))
	game_set_speed(5, gamespeed_fps);
	




