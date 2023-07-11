

if (!timer_invincibility.is_ticking() || 
	(timer_invincibility.is_ticking() && global.tick % 10 >= 5)
) {
	if (physics.is_super()) {
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
				PAL_CLASSIC[i], 
				PAL_SUPER[(global.tick / 4) % PALLETE_SUPER_CYCLE_LENGTH][i]
			);
		}
	
		draw_self();
		shader_reset();
	} else {
		draw_self();	
	}
}

if (running_on_water) {
	draw_sprite_ext(
		sprSfxWaterRun, 
		global.tick / 2, 
		x,
		y + sensor.get_floor_box().vradius,
		image_xscale, image_yscale, 0, c_white, 1
	);	
}

if (state.current() == "spindash") {
	draw_sprite_ext(
		sprSfxSpindashDust, 
		global.tick / 2, 
		x,
		y + sensor.get_floor_box().vradius,
		image_xscale, image_yscale, 0, c_white, 1
	);	
}

if (shield != undefined && !physics.is_super() && !timer_powerup_invincibility.is_ticking())
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
	
	
if (!animator.is_animation_exists(animator.current())) {
	draw_set_halign(fa_center);
	draw_text(x, y + 10, $"{animator.current()}");	
	draw_set_halign(fa_left);
}

if (show_debug_info) 
	sensor.draw();