


appearence_sprite = sprBubble;
appearence_frames_count = 5;

number_sprite = sprBubbleCountdownNumber;

anim_index = 0;
anim_speed = 0.5;

audio_play_sound(sndUnderwaterWarningNumber, 0, 0, global.sound_volume);

vspeed = -0.5;

tick = 0;

oWater = instance_nearest(x, y, objWaterLevel);
if (!oWater) 
	instance_destroy();