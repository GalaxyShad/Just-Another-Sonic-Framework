
function player_handle_rings(){
	if (state.current() == "hurt")
		return;
	
	var _o_ring = collision_detector.collision_object(objRing, PlayerCollisionDetectorSensor.MainDefault);
	
	if (_o_ring) {
		global.rings++;
		
		audio_play_sound(sndRing, 0, false);
		
		instance_create_depth(_o_ring.x, _o_ring.y, depth-1, objSfxRingSparkle);
		
		with _o_ring instance_destroy();
	}
}