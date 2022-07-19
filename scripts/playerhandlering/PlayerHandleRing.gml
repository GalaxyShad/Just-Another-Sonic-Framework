// Ресурсы скриптов были изменены для версии 2.3.0, подробности см. по адресу
// https://help.yoyogames.com/hc/en-us/articles/360005277377
function PlayerHandleRing(){
	if (action == ACT_HURT)
		return;
	
	var oRing = sensor.collision_object(objRing);
	
	if (oRing) {
		global.rings++;
		
		audio_play_sound(sndRing, 0, false);
		
		instance_create_depth(oRing.x, oRing.y, -1, objSfxRingSparkle);
		
		with oRing instance_destroy();
	}
}