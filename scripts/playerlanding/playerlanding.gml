// Ресурсы скриптов были изменены для версии 2.3.0, подробности см. по адресу
// https://help.yoyogames.com/hc/en-us/articles/360005277377
function player_landing() {
	
	if ((action == ACT_JUMP && !is_drop_dashing) || 
		 action == ACT_ROLL ||
		 action == ACT_SPRING
	) {
		action = ACT_NORMAL;
			
		y -= 5 * cos(degtorad(sensor.angle));
		x += 5 * sin(degtorad(sensor.angle));
	}
	
	if (action == ACT_HURT) {
		inv_timer = 120;
		
		action = ACT_NORMAL;
		
		gsp = 0;
		xsp = 0;
	}
	
	if (action == ACT_JUMP && is_drop_dashing) {
		if (drop_dash_timer >= 20) {
			action = ACT_ROLL;
			
			audio_play_sound(sndPlrSpindashRelease, 0, false);
		
			if (sign(image_xscale) == sign(xsp))
				gsp = (gsp / 4) + (drpspd * sign(image_xscale));
			else 
				gsp = ( (sensor.angle == 0) ? 0 : (gsp / 2)) + (drpspd * sign(image_xscale));
				
			camera.lagTimer = 15;
		} else {
			action = ACT_NORMAL;	
		}
		
		is_drop_dashing = false;
	}
	
	player_switch_sensor_radius();
	
}