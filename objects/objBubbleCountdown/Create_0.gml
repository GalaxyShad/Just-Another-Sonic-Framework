


appearence_sprite = sprBubbleCountdown;
appearence_frames_count = sprite_get_number(appearence_sprite);

number_sprite = sprBubbleCountdownNumber;

anim_index = 0;
anim_speed = 0.5;

audio_play_sound(sndUnderwaterWarningNumber, 0, 0);

vspeed = -0.5;

tick = 0;

oWater = instance_nearest(x, y, objWaterLevel);
if (!oWater) 
	instance_destroy();