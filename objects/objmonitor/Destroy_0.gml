/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе


var oIcon = instance_create_depth(x, y, 5, objMonitorIcon);
oIcon.image_index = item;
oIcon.action = action;

audio_play_sound(sndDestroy, 0, false, global.sound_volume);

instance_create_depth(x, y, 5, objSfxExplosion);
instance_create_depth(x, y, 5, objMonitorBroken);










