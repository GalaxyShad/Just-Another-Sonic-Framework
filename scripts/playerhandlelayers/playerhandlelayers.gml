
function player_handle_layers() {
	
	if (place_meeting(x, y, objLayerSwitch)) {
		collision_detector.set_layer((plr.gsp > 0) ? 1 : 0);	
	}
	
	if (place_meeting(x, y,objLayerToHigh)) {
		collision_detector.set_layer(0);	
	}
	
	if (place_meeting(x, y,objLayerToLow)) {
		collision_detector.set_layer(1);
	}
}

function player_handle_corksew() {

	if (collision_detector.collision_object(objCorksewTrigger, PlayerCollisionDetectorSensor.MainDefault) && 
		 abs(plr.gsp) > 1
	) {
		state.change_to("corksew");
	}
}