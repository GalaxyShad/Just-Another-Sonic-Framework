
function player_set_super_form() {
	physics.apply_super_form();
	animator.set_form_super();
}

function player_cancel_super_form() {
	if (!physics.is_super()) return;
	
	physics.reset();
	animator.set_form_normal();
}