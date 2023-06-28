
// Singleton
//if (instance_exists(objDJ))
	//instance_destroy();

__music_map__ = {
	speed_shoes:	musSpeedShoes,
	invincibility:	musInvincibility,
	drowning:		musDrowning
}
#macro MUSIC_MAP __music_map__

level_music			= Music;
level_music_offset	= 0;
current_music		= level_music; 



set_music = function(_music_name) {
	var _music = MUSIC_MAP[$ _music_name];
	
	if (current_music == level_music) {
		level_music_offset = audio_sound_get_track_position(current_music);
	}
		
	audio_stop_sound(current_music);
	
	if (!audio_is_playing(_music))
		audio_play_sound(_music, 100, false, 1.0);
		
	current_music = _music;
};

on_end = function(_music_name){};

__play_default = function() {
	//show_debug_message($"name {audio_get_name(level_music)} {audio_is_playing(level_music)}");
	if (!audio_is_playing(level_music))
		audio_play_sound(level_music, 100, true, ,level_music_offset);	
	current_music = level_music;
};

__play_default();



