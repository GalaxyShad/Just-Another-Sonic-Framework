
function player_behavior_jump() {
	if (!ground) 
		return;
	
	if (allow_jump && is_key_action_pressed) {
		ground = false;
	
		ysp -= physics.jump_force * dcos(sensor.get_angle()); 
		xsp -= physics.jump_force * dsin(sensor.get_angle()); 
	
		state.change_to("jump");
	
		audio_play_sound(sndPlrJump, 0, false);
	} 
}