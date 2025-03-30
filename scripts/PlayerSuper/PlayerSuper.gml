
function player_set_super_form() {
	plr.physics.apply_super_form();
	plr.animator.set_form_super();
}

function player_cancel_super_form() {
	if (!plr.physics.is_super()) return;
	
	plr.physics.reset();
	plr.animator.set_form_normal();
}