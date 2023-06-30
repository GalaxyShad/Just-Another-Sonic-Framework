// Ресурсы скриптов были изменены для версии 2.3.0, подробности см. по адресу
// https://help.yoyogames.com/hc/en-us/articles/360005277377
function player_get_hit(){
	if (inv_timer > 0 || state.current() == "hurt")
		return;
		
	if (global.rings > 0 || shield != Shield.None) {
		if (shield == Shield.None) {
			ring_loss(x, y);
			audio_play_sound(sndLoseRings, 0, false);
		} else {
			shield = Shield.None;
			audio_play_sound(sndHurt, 0, false);	
		}
			
		global.rings = 0;
			
		ground = false;	
			
		state.change_to("hurt");
		
		xsp = -2 * sign(image_xscale);
		ysp = -4;
		
		if (physics.is_underwater()) {
			xsp /= 2;
			ysp /= 2;
		}
			
	} else {
		state.change_to("die");
	}
}