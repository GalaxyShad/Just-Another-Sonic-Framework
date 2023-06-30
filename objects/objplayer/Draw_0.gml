/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе


if (inv_timer == 0 || (inv_timer > 0 && global.tick % 10 >= 5))
	draw_self();

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