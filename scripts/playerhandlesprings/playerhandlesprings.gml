// Ресурсы скриптов были изменены для версии 2.3.0, подробности см. по адресу
// https://help.yoyogames.com/hc/en-us/articles/360005277377
function PlayerHandleSprings(){
	var oSpring = sensor.is_collision_bottom(objSpringYellow, 6);
	
	if (oSpring) {
		if (abs(angle_difference(sensor.angle, oSpring.image_angle)) < 60 &&
			oSpring.image_speed == 0
		) {
			if (!ground)
				ysp = 0;
			
			ysp += -oSpring.spd * dcos(oSpring.image_angle);
			xsp += -oSpring.spd * dsin(oSpring.image_angle);
			
			ground = false;
			
			action = ACT_SPRING;
			
			audio_play_sound(sndSpring, 0, false);
			
			oSpring.image_speed = 1.00;
		}
	}
	
	oSpring = sensor.is_collision_right(objSpringYellow, 4+abs(gsp*2));
	
	if (oSpring) {
		if (abs(angle_difference(sensor.angle, oSpring.image_angle - 90)) < 60 &&
			oSpring.image_speed == 0
		) {	
			if (ground) 
				gsp = -oSpring.spd;
			else 
				xsp = -oSpring.spd;
				
			oSpring.image_speed = 1.00;
			
			audio_play_sound(sndSpring, 0, false);
		}
	}
	
	oSpring = sensor.is_collision_left(objSpringYellow, 4+abs(gsp*2));
	
	if (oSpring) {
		if (abs(angle_difference(sensor.angle, oSpring.image_angle + 90)) < 60 &&
			oSpring.image_speed == 0
		) {	
			
			if (ground) 
				gsp = oSpring.spd;
			else 
				xsp = oSpring.spd;
				
			oSpring.image_speed = 1.00;
			
			audio_play_sound(sndSpring, 0, false);
		}
	}
	
	oSpring = sensor.is_collision_top(objSpringYellow, 4+abs(ysp*2));
	
	if (oSpring && !ground) {
		if (abs(angle_difference(sensor.angle, oSpring.image_angle + 180)) < 15 &&
			oSpring.image_speed == 0
		) {	
			
			ysp = oSpring.spd;
				
			oSpring.image_speed = 1.00;
			
			audio_play_sound(sndSpring, 0, false);
		}
	}
}