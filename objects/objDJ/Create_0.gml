audio_set_master_gain(0,0);

MUSIC_MAP = {
	speed_shoes:	musSpeedShoes,
	invincibility:	musInvincibility,
	drowning:		musDrowning
}

__pause_main_music = function() {
	var _music = instance_find(objLevelMusic, 0);
	if (_music == noone) return;
	
	_music.pause();
};

__resume_main_music = function() {
	var _music = instance_find(objLevelMusic, 0);
	if (_music = noone) return;
	
	_music.resume();
};

current = -1;
play_speed_shoes = function() {
	if (current == MUSIC_MAP[$ "drowning"]) return;
	
	__pause_main_music();
	
	if (current != -1) audio_stop_sound(current);
	
	current = MUSIC_MAP[$ "speed_shoes"];
	
	audio_play_sound(current, 0, false);
};

play_invincibility = function() {
	if (current == MUSIC_MAP[$ "drowning"]) return;
	
	__pause_main_music();
	
	if (current != -1) audio_stop_sound(current);
	
	current = MUSIC_MAP[$ "invincibility"];
	
	audio_play_sound(current, 0, false);
};

play_drowning = function() {
	__pause_main_music();
	
	if (current != -1) audio_stop_sound(current);
	
	current = MUSIC_MAP[$ "drowning"];
	
	audio_play_sound(current, 0, false);
};


