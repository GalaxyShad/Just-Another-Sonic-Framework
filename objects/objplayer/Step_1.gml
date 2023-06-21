/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе

is_key_left		= keyboard_check(vk_left);
is_key_right	= keyboard_check(vk_right);
is_key_up		= keyboard_check(vk_up);
is_key_down		= keyboard_check(vk_down);
is_key_action	= keyboard_check(ord("Z")) || keyboard_check(ord("X")) || keyboard_check(ord("C"));
is_key_action_pressed = keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(ord("X")) || keyboard_check_pressed(ord("C"));

if (keyboard_check_pressed(ord("R")))
	room_restart();

if (keyboard_check_pressed(ord("S")))
	PlayerGetHit();
	
if (keyboard_check_pressed(ord("A")))
	show_debug_info = !show_debug_info;

if keyboard_check(ord("2"))
	room_speed = 5;
else if keyboard_check(ord("1"))
	room_speed = 60;
else if keyboard_check(ord("3"))
	room_speed = 1;
	




