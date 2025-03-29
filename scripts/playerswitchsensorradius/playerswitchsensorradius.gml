
/// @param {Struct.Player} plr
function player_switch_sensor_radius(plr) {
	var _box;
	
	if (plr.state_machine.is_one_of(["roll", "jump", "dropdash"])) {
		_box = plr.collider_radius.curling;
	} else if (plr.inst.object_index == objCharacterKnuckles && plr.state_machine.is_one_of(["glide", "glideRotation", "climbe", "land"])) {
		_box = SENSOR_FLOORBOX_SPECIAL;
	} else {
		_box = plr.collider_radius.base;
	}

	plr.collider.set_radius({ 
		width:  _box.horizontal, 
		height: _box.vertical
	}, 10);

	plr.collider.set_wall_sensor_vertical_offset((plr.ground && plr.collider.get_angle_data().degrees == 0) ? 8 : 0);

	if (plr.inst.camera.FollowingObject == self) {
		plr.inst.camera.offset_y = (plr.state_machine.current() == "roll") ? -5 : 0;
	}
}