/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе

if (action == ACT_DIE) {
	ysp += grv;
	
	y += ysp;
	
	camera.lagTimer = 1;
	
	exit;
}


player_switch_sensor_radius();


PlayerCollision();

//////////////////////////////////////////////////////

PlayerGroundMovement();
PlayerAirMovement();
PlayerHandleLayers();
PlayerHandleSprings();
PlayerHandleRing();
PlayerHandleSpikes();
PlayerHandleMonitors();


var oMovingPlatform = sensor.collision_object(objMovingPlatform, 6);
if (ground && oMovingPlatform) {
	x += oMovingPlatform.xsp; 
}


if (!ground && action == ACT_JUMP && is_key_action_pressed) {
	
	if (shield == SHIELD_BUBBLE) {
		audio_play_sound(sndBubbleBounce, 0, false);
		ysp = 7;
	} else if (shield == SHIELD_FIRE) {
		audio_play_sound(sndFireDash, 0, false);
		ysp = 0;
		xsp = 6 * sign(image_xscale);
		camera.lagTimer = 15;
	} else if (shield == SHIELD_ELECTRIC) {
		audio_play_sound(sndLightningJump, 0, false);
		ysp = -4;
	}
}


if (action == ACT_JUMP && 
	is_key_action_pressed && 
	!is_drop_dashing && 
	(shield == SHIELD_NONE || shield == SHIELD_CLASSIC)
) {
	drop_dash_timer = 0;
	is_drop_dashing = true;
	audio_play_sound(sndPlrDropDash, 0, false);
}

if (action == ACT_JUMP && is_drop_dashing) {
	if (!is_key_action)
		is_drop_dashing = false;
	
	drop_dash_timer++;
}

if (ground && is_key_action_pressed && 
	action != ACT_LOOK_UP && action != ACT_CROUCH &&
	action != ACT_SPINDASH && action != ACT_PEELOUT
	) {
	ground = false;
	
	ysp -= jmp * cos(degtorad(sensor.angle)); 
	xsp -= jmp * sin(degtorad(sensor.angle)); 
	
	action = ACT_JUMP;
	
	audio_play_sound(sndPlrJump, 0, false);
} 

if (action == ACT_JUMP && !is_key_action && ysp < -4)
	ysp = -4;
	
	
if (action == ACT_ROLL)	{
	if (abs(gsp) < 0.5)
		action = ACT_NORMAL;
} else if (ground && is_key_down && action == ACT_NORMAL && abs(gsp) >= 1) {
	action = ACT_ROLL;
	audio_play_sound(sndPlrRoll, 0, false);
}

if (action == ACT_LOOK_UP) {
	if (!is_key_up || !ground || gsp != 0)
		action = ACT_NORMAL;
} else if (ground && is_key_up && gsp == 0 && action == ACT_NORMAL)
	action = ACT_LOOK_UP;
	
	
if (action == ACT_CROUCH) {
	if (!is_key_down || !ground)
		action = ACT_NORMAL;
	else if (abs(gsp) >= 1.0)
		action = ACT_ROLL;
} else if (ground && is_key_down && abs(gsp) < 1.0 && action == ACT_NORMAL)
	action = ACT_CROUCH;


sensor.wall_box.hradius = 11;
if ((xsp > 0 && sensor.is_collision_right()) || (xsp < 0) && sensor.is_collision_left()) {

	
	if (ground) {
		gsp = 0;
		
		if ((xsp < 0 && is_key_left) || (xsp > 0 && is_key_right))
			action = ACT_PUSH;
	}
	
	xsp = 0;
}
sensor.wall_box.hradius = 10;


if (action == ACT_PUSH) {
	xsp = 0;
	gsp = 0;
	
	if ((image_xscale == 1 && !is_key_right) || (image_xscale == -1 && !is_key_left))
		action = ACT_NORMAL;
}

if (action == ACT_SKID) {
	if (abs(gsp) <= 0.5 || !ground || 
		((gsp < 0 && is_key_left) || (gsp > 0 && is_key_right))
	)
		action = ACT_NORMAL;
} else if (ground && abs(gsp) >= 4 && action == ACT_NORMAL) {
	if ((gsp < 0 && is_key_right) || (gsp > 0 && is_key_left)) {
		action = ACT_SKID;
		audio_play_sound(sndPlrBraking, 0, false);
	}
}

if (action == ACT_BALANCING) {
	if (gsp != 0 || !ground)
		action = ACT_NORMAL;
} else if (ground && action == ACT_NORMAL && gsp == 0) {
	var temp_radius = sensor.floor_box.hradius;
	
	sensor.floor_box.hradius = 1;
	
	if (!sensor.is_collision_left_edge() || !sensor.is_collision_right_edge())
		action = ACT_BALANCING;
		
	sensor.floor_box.hradius = temp_radius;
}

if (action == ACT_PEELOUT) {
	if (!is_key_up) {
		if (peelout_timer >= 30) {
			gsp = 12 * image_xscale;
			
			audio_stop_sound(sndPlrPeelCharge);
			audio_play_sound(sndPlrPeelRelease, 0, false);
			
			camera.lagTimer = 15;
		} else {
			peelout_timer = 0;		
		}
		
		action = ACT_NORMAL;
	}
	
	peelout_timer++;
	if peelout_timer > 30
		peelout_timer = 30;
} else if (ground && action == ACT_LOOK_UP && is_key_action) {
	action = ACT_PEELOUT;
	peelout_timer = 0;
	audio_play_sound(sndPlrPeelCharge, 0, false);
}

if (action == ACT_SPINDASH) {
	if (!is_key_down) {
		gsp = (8 + (floor(spinrev) / 2)) * sign(image_xscale);
		action = ACT_ROLL;
		
		audio_stop_sound(sndPlrSpindashCharge);
		audio_play_sound(sndPlrSpindashRelease, 0, false);
		
		camera.lagTimer = 15;
	}
	
	if (is_key_action_pressed) {
		spinrev += (spinrev < 8) ? 2 : 0;
		
		audio_stop_sound(sndPlrSpindashCharge);
		
		audio_sound_pitch(sndPlrSpindashCharge, 1 + spinrev / 10);
		audio_play_sound(sndPlrSpindashCharge, 0, false);
		
	}
	
	spinrev -= (((spinrev * 1000) div 125) / 256000);
	
	
} else if (action == ACT_CROUCH && ground && is_key_action_pressed) {
	action = ACT_SPINDASH;	
	spinrev = 0;
	
	audio_sound_pitch(sndPlrSpindashCharge, 1);
	audio_play_sound(sndPlrSpindashCharge, 0, false);
}

if (inv_timer > 0)
	inv_timer--;

	
