// Ресурсы скриптов были изменены для версии 2.3.0, подробности см. по адресу
// https://help.yoyogames.com/hc/en-us/articles/360005277377
function PlayerGetHit(){
	if (inv_timer > 0 || action == ACT_HURT)
		return;
		
	if (global.rings > 0 || shield != SHIELD_NONE) {
		if (shield == SHIELD_NONE) {
			RingLoss(x, y);
			audio_play_sound(sndLoseRings, 0, false);
		} else {
			shield = SHIELD_NONE;
			audio_play_sound(sndHurt, 0, false);	
		}
			
		global.rings = 0;
			
		ground = false;	
			
		action = ACT_HURT;
		
		xsp = -2 * sign(image_xscale);
		ysp = -4;
	} else {
		audio_play_sound(sndHurt, 0, false);	
		
		action = ACT_DIE;
		
		xsp = 0;
		ysp = -7;
	}
}