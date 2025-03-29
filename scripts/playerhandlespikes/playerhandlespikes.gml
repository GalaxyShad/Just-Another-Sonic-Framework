
/// @param {Struct.Player} plr
function player_handle_spikes(plr) {
	var _o_spikes_bottom = plr.collider.collision_object_exp(PlayerCollisionDetectorSensor.Bottom, objSpikes, 0, 4);
	var _o_spikes_left	 = plr.collider.collision_object_exp(PlayerCollisionDetectorSensor.Left,   objSpikes, 4, 0);
	var _o_spikes_right	 = plr.collider.collision_object_exp(PlayerCollisionDetectorSensor.Right,  objSpikes, 4, 0);
	var _o_spikes_top	 = plr.collider.collision_object_exp(PlayerCollisionDetectorSensor.Top,    objSpikes, 0, 4);
	
	#macro ANGLE_TOLLERANCE 60
	
	var _get_angle = function(_spikes_angle) {
		return abs(angle_difference(plr.collider.get_angle_data().degrees, _spikes_angle));
	}
	
	if ((_o_spikes_bottom && _get_angle(_o_spikes_bottom.image_angle)	  < ANGLE_TOLLERANCE) ||
		(_o_spikes_top	  && _get_angle(_o_spikes_top.image_angle + 180)  < ANGLE_TOLLERANCE) ||
		(_o_spikes_left	  && _get_angle(_o_spikes_left.image_angle + 90)  < ANGLE_TOLLERANCE) ||
		(_o_spikes_right  && _get_angle(_o_spikes_right.image_angle - 90) < ANGLE_TOLLERANCE)
	) {
		player_get_hit();
	}
}