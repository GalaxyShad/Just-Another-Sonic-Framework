// Ресурсы скриптов были изменены для версии 2.3.0, подробности см. по адресу
// https://help.yoyogames.com/hc/en-us/articles/360005277377
function PlayerHandleSpikes(){
	var oSpikesOnBottom = sensor.check_expanded(0, 4, function() { return sensor.collision_bottom(objSpikes); });
	var oSpikesOnLeft	= sensor.check_expanded(4, 0, function() { return sensor.collision_left(objSpikes); });
	var oSpikesOnRight	= sensor.check_expanded(4, 0, function() { return sensor.collision_right(objSpikes); });
	var oSpikesOnTop	= sensor.check_expanded(0, 4, function() { return sensor.collision_top(objSpikes); });
	
	var angle_tollerance = 60;
	
	if (
		(           (oSpikesOnBottom && 
					 abs(angle_difference(sensor.get_angle(), 
										  oSpikesOnBottom.image_angle)) < angle_tollerance) ||
					(oSpikesOnTop && 
					 abs(angle_difference(sensor.get_angle(), 
										  oSpikesOnTop.image_angle+180)) < angle_tollerance)
		) ||
		(		   (oSpikesOnLeft && 
					abs(angle_difference(sensor.get_angle(), 
										 oSpikesOnLeft.image_angle+90)) < angle_tollerance) ||
				   (oSpikesOnRight && 
					abs(angle_difference(sensor.get_angle(), 
										 oSpikesOnRight.image_angle-90)) < angle_tollerance)
		) 
	) {
		PlayerGetHit();
	}
}