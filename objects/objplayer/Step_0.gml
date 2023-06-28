
if (state.current() == "die") {
	ysp += grv;
	y += ysp;
	camera.lagTimer = 1;
	exit;
}


player_switch_sensor_radius();


if (ground) {
	var _gsp = gsp;

	var _d = 16;

	gsp = _gsp % _d;
	PlayerCollision();

	if (ground) {
		for (var i = 0; i < floor(abs(_gsp) / _d) * _d; i+=_d) {
			gsp = sign(_gsp)*_d;
			PlayerCollision();	
			if (!ground) break;
		}
	}

	gsp = _gsp;
} else {
	PlayerCollision();	
}


//////////////////////////////////////////////////////

PlayerGroundMovement();
PlayerAirMovement();
PlayerHandleObjects();


state.step();

var oMovingPlatform = sensor.collision_object(objMovingPlatform, 6);
if (ground && oMovingPlatform) {
	x += oMovingPlatform.x - oMovingPlatform.xprevious; 
	sensor.set_position(x, y);
}


if (allow_jump && (ground || clamb) && is_key_action_pressed) {
	ground = false;
	clamb = false;
	
	ysp -= jmp * dcos(sensor.get_angle()); 
	xsp -= jmp * dsin(sensor.get_angle()); 
	
	state.change_to("jump");
	
	audio_play_sound(sndPlrJump, 0, false);
} 

var _is_moving_right = (ground && gsp > 0) || (!ground && xsp > 0);
var _is_moving_left = (ground && gsp < 0) || (!ground && xsp < 0);

if ((_is_moving_right && sensor.check_expanded(1, 0, sensor.is_collision_solid_right)) || 
	(_is_moving_left  && sensor.check_expanded(1, 0, sensor.is_collision_solid_left))
) {
	if (ground) {
		gsp = 0;
		if (((xsp < 0 && is_key_left) || (xsp > 0 && is_key_right)) && state.current() != "clamb")
			state.change_to("push");
	} else if (!ground && object_index==objPlayerKnuckles && state.current() == "glid") {
		state.change_to("clamb");	
	} else xsp = 0;
}

if(state.current() == "clamb"){
	if((image_xscale==1 && !sensor.check_expanded(1, 0, sensor.is_collision_solid_right)) ||
	(image_xscale==-1 && !sensor.check_expanded(1, 0, sensor.is_collision_solid_left))){
		state.change_to("clambEx");
	}
}

if (inv_timer > 0) inv_timer--;
	

