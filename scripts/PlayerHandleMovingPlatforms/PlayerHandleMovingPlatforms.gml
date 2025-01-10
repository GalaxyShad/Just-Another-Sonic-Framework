
function player_handle_moving_platforms() {
	var _o_moving_platform = collision_detector.check_expanded(
		6, 6,
		function () { return collision_detector.collision_object(objMovingPlatform, PlayerCollisionDetectorSensor.MainDefault) }
	);  

	if (ground && _o_moving_platform) {
		x += _o_moving_platform.x - _o_moving_platform.xprevious; 
	}
}