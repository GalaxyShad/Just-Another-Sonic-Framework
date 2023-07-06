
function player_handle_moving_platforms() {
	var _o_moving_platform = sensor.collision_object(objMovingPlatform, 6);
	if (ground && _o_moving_platform) {
		x += _o_moving_platform.x - _o_moving_platform.xprevious; 
		sensor.set_position(x, y);
	}
}