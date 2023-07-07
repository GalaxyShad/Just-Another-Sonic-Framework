/// @description Insert description here
// You can write your code in this editor

if ((state.current()=="normal" || state.current()=="look_up" || state.current()=="look_down" || state.current()=="hang") && gsp==0 || state.current()=="breathe") draw_sprite_ext(sprTailsTailType1,global.tick/10,x,y,image_xscale,1,0,c_white,255);
if (state.current()=="push" || state.current()=="skid") draw_sprite_ext(sprTailsTailType2,global.tick/10,x-6*image_xscale,y+10,image_xscale,1,0,c_white,255);
if (state.current()=="spindash") draw_sprite_ext(sprTailsTailType2,global.tick/10,x-12*image_xscale,y+10,image_xscale,1,0,c_white,255);
if (state.current()=="roll" || state.current()=="jump") draw_sprite_ext(sprTailsTailType3,global.tick/10,x,y,1,xsp!=0 ? sign(xsp) : 1,point_direction(0,0,xsp,ysp),c_white,255);

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

if (shield != undefined && !physics.is_super())
	shield.draw(x, y);
	
if (!animator.is_animation_exists(animator.current())) {
	draw_set_halign(fa_center);
	draw_text(x, y + 10, $"{animator.current()}");	
	draw_set_halign(fa_left);
}

if (show_debug_info) 
	sensor.draw();