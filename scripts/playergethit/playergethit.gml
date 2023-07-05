
function player_get_hit(){
	
	
	if (inv_timer > 0 || state.current() == "hurt" || physics.is_super())
		return;
		
	if (global.rings > 0 || shield != undefined) {
		if (shield == undefined) {
			ring_loss(x, y);
			audio_play_sound(sndLoseRings, 0, false);
		} else {
			shield = undefined;
			audio_play_sound(sndHurt, 0, false);	
		}
			
		global.rings = 0;
			
		ground = false;	
			
		state.change_to("hurt");	
	} else {
		state.change_to("die");
	}
}