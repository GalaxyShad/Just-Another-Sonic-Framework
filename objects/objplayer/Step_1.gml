
if (keyboard_check_pressed(ord("R"))) {
	room_restart();	
}

if (debugger != noone) {
	if (keyboard_check_pressed(ord("D")))
		player_get_hit(plr);
	
	
	
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
}






	




