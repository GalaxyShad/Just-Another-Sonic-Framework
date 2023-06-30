/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе


var _o_icon = instance_create_depth(x, y, 5, objMonitorIcon);
_o_icon.image_index = item;
_o_icon.action = action;

audio_play_sound(sndDestroy, 0, false);

instance_create_depth(x, y, 5, objSfxExplosion);
instance_create_depth(x, y, 5, objMonitorBroken);










