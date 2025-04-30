/// @param {Struct.Player} plr
function player_handle_layers(plr) {
	
	if (place_meeting(plr.inst.x, plr.inst.y, objLayerSwitch) && plr.ground) {
		plr.collider.set_layer((plr.gsp > 0) ? 1 : 0);	
	}
	
	if (place_meeting(plr.inst.x, plr.inst.y,objLayerToHigh)) {
		plr.collider.set_layer(0);	
	}
	
	if (place_meeting(plr.inst.x, plr.inst.y,objLayerToLow)) {
		plr.collider.set_layer(1);
	}
}

/// @param {Struct.Player} plr
function player_handle_corksew(plr) {

	if (plr.collider.collision_object(objCorksewTrigger, PlayerCollisionDetectorSensor.MainDefault) && 
		 abs(plr.gsp) > 4 &&
		 plr.ground
	) {
		plr.state_machine.change_to("corksew");
	}
}