/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе


if (inv_timer == 0 || (inv_timer > 0 && global.tick % 10 >= 5)) {
	
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
		
		var _pal_classic = [ #2424b4, #2448d8, #4848fc, #6c6cfc ];
		
		var _pal_super = [ 
			[ #ce9034, #ffac34, #ffce57, #ffff74 ],
			[ #ffac74, #ffce90, #ffffac, #ffffce ], 
			[ #ffffaa, #ffffaa, #ffffaa, #ffffaa ],
			[ #ffac74, #ffce90, #ffffac, #ffffce ], 
		];
		
		for (var i = 0; i <4; i++) {
			_set_col(i+1, _pal_classic[i], _pal_super[(global.tick / 4) % 4][i]);
		}
	
		draw_self();
		shader_reset();
	} else {
		draw_self();	
	}
}

switch (shield) {
	case Shield.Classic:
		draw_sprite(sprShield, global.tick / 2, x, y);
		break;
	case Shield.Bubble: {
		water_shield_scale.__xscale = 
			lerp(water_shield_scale.__xscale, water_shield_scale.xscale, 0.25);
		
		water_shield_scale.__yscale = 
			lerp(water_shield_scale.__yscale, water_shield_scale.yscale, 0.25);
	
		draw_sprite_ext(
			sprWaterShield, global.tick, 
			x, y, 
			water_shield_scale.__xscale,
			water_shield_scale.__yscale, 
			0, c_white, 1 
		);
		break;
	}
	case Shield.Lightning: {
		draw_sprite(sprElectricShield, global.tick / 3, x, y);
		break;
	}
	case Shield.Flame: {
		draw_sprite_ext(
			(using_shield_abbility && xsp != 0) ? sprFireShieldActive : sprFireShield, 
			global.tick, 
			x, y, 
			(using_shield_abbility && xsp != 0) ? sign(xsp) : 1, 1,
			0, c_white, 1
		);
	}
}


if (show_debug_info) 
	sensor.draw();