
function player_handle_spikes() {
	var _o_spikes_bottom = sensor.check_expanded(0, 4, function() { return sensor.collision_bottom(objSpikes); });
	var _o_spikes_left	 = sensor.check_expanded(4, 0, function() { return sensor.collision_left(objSpikes); });
	var _o_spikes_right	 = sensor.check_expanded(4, 0, function() { return sensor.collision_right(objSpikes); });
	var _o_spikes_top	 = sensor.check_expanded(0, 4, function() { return sensor.collision_top(objSpikes); });
	
	#macro ANGLE_TOLLERANCE 60
	
	var _get_angle = function(_spikes_angle) {
		return abs(angle_difference(sensor.get_angle(), _spikes_angle));
	}
	
	if ((_o_spikes_bottom && _get_angle(_o_spikes_bottom.image_angle)	  < ANGLE_TOLLERANCE) ||
		(_o_spikes_top	  && _get_angle(_o_spikes_top.image_angle + 180)  < ANGLE_TOLLERANCE) ||
		(_o_spikes_left	  && _get_angle(_o_spikes_left.image_angle + 90)  < ANGLE_TOLLERANCE) ||
		(_o_spikes_right  && _get_angle(_o_spikes_right.image_angle - 90) < ANGLE_TOLLERANCE)
	) {
		player_get_hit();
	}
}