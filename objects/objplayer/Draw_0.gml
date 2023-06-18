/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе


if (inv_timer == 0 || (inv_timer > 0 && global.tick % 10 >= 5))
	draw_self();

if (shield == SHIELD_CLASSIC)
	draw_sprite(sprShield, global.tick / 4, x, y);
else if (shield == SHIELD_BUBBLE)
	draw_sprite(sprWaterShield, global.tick, x, y);
else if (shield == SHIELD_ELECTRIC)
	draw_sprite(sprElectricShield, global.tick / 3, x, y);
else if (shield == SHIELD_FIRE) {
	draw_sprite(sprFireShield, global.tick, x, y);
}

if (show_debug_info) 
	sensor.draw();