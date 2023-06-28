// Ресурсы скриптов были изменены для версии 2.3.0, подробности см. по адресу
// https://help.yoyogames.com/hc/en-us/articles/360005277377
function PlayerHandleSprings(){
	var oSpring = sensor.check_expanded(0, 2, function() { return sensor.collision_bottom(objSpringYellow);} );
	
	if (oSpring) {
		if (abs(angle_difference(sensor.get_angle(), oSpring.image_angle)) < 60 &&
			oSpring.image_speed == 0
		) {
			if (!ground) ysp = 0;
			
			ysp += -oSpring.spd * dcos(oSpring.image_angle);
			xsp += -oSpring.spd * dsin(oSpring.image_angle);
			
			ground = false;
			
			state.change_to("spring");
			//action = ACT_SPRING;
			
			audio_play_sound(sndSpring, 0, false);
			
			oSpring.image_speed = 1.00;
		}
	}
	
	oSpring = sensor.check_expanded(2, 0, function() { return sensor.collision_right(objSpringYellow);} );
	
	if (oSpring) {
		if (abs(angle_difference(sensor.get_angle(), oSpring.image_angle - 90)) < 60 &&
			oSpring.image_speed == 0
		) {
			if(state.current() != "roll") state.change_to("normal");
			
			if (ground) 
				gsp = -oSpring.spd;
			else 
				xsp = -oSpring.spd;
			
			oSpring.image_speed = 1.00;
			
			audio_play_sound(sndSpring, 0, false);
		}
	}
	
	oSpring = sensor.check_expanded(2, 0, function() { return sensor.collision_left(objSpringYellow);} );
	
	if (oSpring) {
		if (abs(angle_difference(sensor.get_angle(), oSpring.image_angle + 90)) < 60 &&
			oSpring.image_speed == 0
		) {	
			if(state.current() != "roll") state.change_to("normal");
			
			if (ground) 
				gsp = oSpring.spd;
			else 
				xsp = oSpring.spd;
			
			oSpring.image_speed = 1.00;
			
			audio_play_sound(sndSpring, 0, false);
		}
	}
	
	oSpring = sensor.check_expanded(0, 2, function() { return sensor.collision_top(objSpringYellow);} );
	
	if (oSpring && !ground) {
		if (abs(angle_difference(sensor.get_angle(), oSpring.image_angle + 180)) < 15 &&
			oSpring.image_speed == 0
		) {	
			
			ysp = oSpring.spd;
				
			oSpring.image_speed = 1.00;
			
			audio_play_sound(sndSpring, 0, false);
		}
	}
}