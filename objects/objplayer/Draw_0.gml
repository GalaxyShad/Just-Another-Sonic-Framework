/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе


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

if (shield != undefined)
	shield.draw(x, y);

if (show_debug_info) 
	sensor.draw();