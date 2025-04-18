

if (!timer_invincibility.is_ticking() || 
	(timer_invincibility.is_ticking() && global.tick % 10 >= 5)
) {
	if (plr.physics.is_super()) {
		shader_set(shPlayerPalleteSwap);
		var _set_col = function(_index, _col_old, _col_new) {
			shader_set_uniform_f(
				shader_get_uniform(shPlayerPalleteSwap, $"old{_index}"), 
				color_get_red(_col_old) / 255, 
				color_get_green(_col_old) / 255, 
				color_get_blue(_col_old) / 255
			);
			shader_set_uniform_f(
				shader_get_uniform(shPlayerPalleteSwap, $"new{_index}"), 
				color_get_red(_col_new) / 255, 
				color_get_green(_col_new) / 255, 
				color_get_blue(_col_new) / 255
			);
		}
		
		for (var i = 0; i < 4; i++) {
			_set_col(
				i+1, 
				plr.palette.base_color_list[i], 
				plr.palette.super_form_color_list[(global.tick / 4) % array_length(plr.palette.super_form_color_list)][i]
			);
		}
	
		draw_player();
		shader_reset();
	} else {
		draw_player();	
	}
}

if (running_on_water) {
	draw_sprite_ext(
		sprSfxWaterRun, 
		global.tick / 2, 
		x,
		y + plr.collider.get_radius().floor.height, 
		image_xscale, image_yscale, 0, c_white, 1
	);	
}

if (plr.state_machine.current() == "spindash") {
	draw_sprite_ext(
		sprSfxSpindashDust, 
		global.tick / 2, 
		x,
		y + plr.collider.get_radius().floor.height,
		image_xscale, image_yscale, 0, c_white, 1
	);	
}

if (shield != undefined && !plr.physics.is_super() && !timer_powerup_invincibility.is_ticking())
	shield.draw(x, y);
	
if (timer_powerup_invincibility.is_ticking()) {
	var _dist = irandom_range(16, 20);
	var _dir = irandom(16) * 22.5;
	
	instance_create_depth(
		x + lengthdir_x(_dist, _dir), 
		y + lengthdir_y(_dist, _dir), 
		depth-2, objSfxInvicibilitySparkle
	);	
}
	
	
if (!plr.animator.is_animation_exists(plr.animator.current())) {
	draw_set_halign(fa_center);
	draw_text(x, y + 10, $"{plr.animator.current()}");	
	draw_set_halign(fa_left);
}

if (show_debug_info) {
	plr.collider.draw();
}

draw_set_font(global.sprite_font_plr_has_passed);
//draw_set_font(global.sprite_font_hud);
draw_set_halign(fa_center);
draw_set_color(c_yellow);
draw_text(x, y-32, "HELLO MY NAME IS CHICKY! WAWAMAMA")
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_font(-1);