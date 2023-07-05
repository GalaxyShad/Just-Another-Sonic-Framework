// Ресурсы скриптов были изменены для версии 2.3.0, подробности см. по адресу
// https://help.yoyogames.com/hc/en-us/articles/360005277377
function is_shield_water_flushable(shield) {
	return (
		is_instanceof(shield, ShieldLightning) || 
		is_instanceof(shield, ShieldFlame)
	);
}