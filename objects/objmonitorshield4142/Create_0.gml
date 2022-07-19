/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе











// Inherit the parent event
event_inherited();
item = ITEM_FIRE_SHIELD;
action = function() {
	audio_play_sound(sndFireShield, 0, false);
	with objPlayer shield = SHIELD_FIRE;
};

