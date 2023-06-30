// Ресурсы скриптов были изменены для версии 2.3.0, подробности см. по адресу
// https://help.yoyogames.com/hc/en-us/articles/360005277377
function player_handle_rings(){
	if (state.current() == "hurt")
		return;
	
	var _o_ring = sensor.collision_object(objRing);
	
	if (_o_ring) {
		global.rings++;
		
		audio_play_sound(sndRing, 0, false);
		
		instance_create_depth(_o_ring.x, _o_ring.y, -1, objSfxRingSparkle);
		
		with _o_ring instance_destroy();
	}
}