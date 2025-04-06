/// @param {Struct.Player} plr
function player_handle_rings(plr){
	if (plr.state_machine.current() == "hurt")
		return;
	
	var _o_ring = plr.collider.collision_object(objRing, PlayerCollisionDetectorSensor.MainDefault);
	
	if (_o_ring) {
		global.rings++;
		
		audio_play_sound(sndRing, 0, false);
		
		instance_create_depth(_o_ring.x, _o_ring.y, depth-1, objSfxRingSparkle);
		
		with _o_ring instance_destroy();
	}
}