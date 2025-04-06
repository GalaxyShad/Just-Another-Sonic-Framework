/// @param {Struct.Player} plr
function player_handle_moving_platforms(plr) {
	var _o_moving_platform = plr.collider.check_expanded(
		6, 6,
		function (plr) { return plr.collider.collision_object(objMovingPlatform, PlayerCollisionDetectorSensor.MainDefault) },
		plr
	);  

	if (plr.ground && _o_moving_platform) {
		plr.inst.x += _o_moving_platform.x - _o_moving_platform.xprevious; 
	}
}