
function player_behavior_jump() {
	if (!plr.ground) 
		return;
	
	if (allow_jump && is_key_action_pressed) {
		plr.ground = false;
	
		plr.ysp -= physics.jump_force * collision_detector.get_angle_data().cos; 
		plr.xsp -= physics.jump_force * collision_detector.get_angle_data().sin; 
	
		state.change_to("jump");
	
		audio_play_sound(sndPlrJump, 0, false);
	} 
}