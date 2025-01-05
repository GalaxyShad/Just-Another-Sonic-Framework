/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе

audio_play_sound(sndDestroy, 0, 0);
instance_create_depth(x, y, depth, objSfxExplosion);
instance_create_depth(x, y, depth - 1, objFlicky);



