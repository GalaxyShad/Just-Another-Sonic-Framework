
function player_behavior_jump() {
	if (!ground) 
		return;
	
	if (allow_jump && is_key_action_pressed) {
		ground = false;
	
		ysp -= physics.jump_force * collision_detector.get_angle_data().cos; 
		xsp -= physics.jump_force * collision_detector.get_angle_data().sin; 
	
		state.change_to("jump");
	
		audio_play_sound(sndPlrJump, 0, false);
	} 
}