
/// @param {Struct.Player} plr
function player_get_hit(plr){
	if (plr.inst.timer_invincibility.is_ticking() || 
		plr.state_machine.current() == "hurt" || 
		plr.physics.is_super() ||
		plr.inst.timer_powerup_invincibility.is_ticking()
	) {
		return;
	}

		
	if (global.rings > 0 || plr.inst.shield != undefined) {
		if (plr.inst.shield == undefined) {
			ring_loss(plr.inst.x, plr.inst.y);
			audio_play_sound(sndLoseRings, 0, false);
		} else {
			plr.inst.shield = undefined;
			audio_play_sound(sndHurt, 0, false);	
		}
			
		global.rings = 0;
			
		plr.ground = false;	
			
		plr.state_machine.change_to("hurt");	
	} else {
		plr.state_machine.change_to("die");
	}
}