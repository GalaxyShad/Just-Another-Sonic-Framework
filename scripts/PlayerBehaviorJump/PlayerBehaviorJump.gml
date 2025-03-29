/// @param {Struct.Player} plr
function player_behavior_jump(plr) {
	if (!plr.ground) 
		return;
	
	if (plr.is_input_jump()) {
		plr.ground = false;
	
		plr.ysp -= plr.physics.jump_force * plr.collider.get_angle_data().cos; 
		plr.xsp -= plr.physics.jump_force * plr.collider.get_angle_data().sin; 
	
		plr.state_machine.change_to("jump");
	
		audio_play_sound(sndPlrJump, 0, false);
	} 
}