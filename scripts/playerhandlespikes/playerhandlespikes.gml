// Ресурсы скриптов были изменены для версии 2.3.0, подробности см. по адресу
// https://help.yoyogames.com/hc/en-us/articles/360005277377
function PlayerHandleSpikes(){
	var oSpikesOnBottom = sensor.is_collision_bottom(objSpikes, 4);
	var oSpikesOnLeft	= sensor.is_collision_left(objSpikes, 4);
	var oSpikesOnRight	= sensor.is_collision_right(objSpikes, 4);
	var oSpikesOnTop	= sensor.is_collision_top(objSpikes, 4);
	
	var angle_tollerance = 60;
	
	if (
		(           (oSpikesOnBottom && 
					 abs(angle_difference(sensor.angle, 
										  oSpikesOnBottom.image_angle)) < angle_tollerance) ||
					(oSpikesOnTop && 
					 abs(angle_difference(sensor.angle, 
										  oSpikesOnTop.image_angle+180)) < angle_tollerance)
		) ||
		(		   (oSpikesOnLeft && 
					abs(angle_difference(sensor.angle, 
										 oSpikesOnLeft.image_angle+90)) < angle_tollerance) ||
				   (oSpikesOnRight && 
					abs(angle_difference(sensor.angle, 
										 oSpikesOnRight.image_angle-90)) < angle_tollerance)
		) 
	) {
		PlayerGetHit();
	}
}