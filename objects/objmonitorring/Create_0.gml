/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе











// Inherit the parent event
event_inherited();
item = ITEM_RING;
action = function() {
	audio_play_sound(sndRing, 0, false);
	global.rings += 10;	
};

