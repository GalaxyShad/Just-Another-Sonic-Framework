/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе



if (!ground) {
	animation_angle += angle_difference(0, animation_angle) / 10;
} else {
	var _ang = (sensor.get_angle() >= 35 && sensor.get_angle() <= 325) ? sensor.get_angle() : 0;
	animation_angle += angle_difference(_ang, animation_angle) / 4;
}

if (sprite_index == sprSonicRoll)
	animation_angle = 0;

if (animation_angle < 0) animation_angle = 360 + animation_angle;
animation_angle = (abs(animation_angle) % 360);

image_angle = animation_angle;

if (!ground) {
	if		(is_key_right)	image_xscale = 1;
	else if (is_key_left)	image_xscale = -1;
} else {
	if		(is_key_right && gsp > 0)	image_xscale = 1;
	else if (is_key_left  && gsp < 0)	image_xscale = -1;
}

if (gsp == 0 && action == ACT_NORMAL)
	idle_anim_timer++;
else
	idle_anim_timer = 0;

switch (state.current()) {
	case "normal": {
		if (ground) {
			if (abs(gsp) == 0) {
				
				if (idle_anim_timer >= 180 && idle_anim_timer < 816)
					sprite_index = sprSonicBored;
				else if (idle_anim_timer >= 816)
					sprite_index = sprSonicBoredEx;
				else
					sprite_index = sprSonic;
					
				if (idle_anim_timer > 236 && sprite_index == sprSonicBored) {
					if (image_index < 2)
						image_index = 2;
				}
				
				if (idle_anim_timer >= 816 && sprite_index == sprSonicBoredEx) {
					if (idle_anim_timer >= 832 && image_index < 2)
						image_index = 2;
				}
				
				
			} else if (abs(gsp) < 6)
				sprite_index = sprSonicWalk;
			else if (abs(gsp) < 12) 
				sprite_index = sprSonicRun;
			else
				sprite_index = sprSonicDash;
				
				
			if (sprite_index == sprSonicWalk || 
				sprite_index == sprSonicRun  || 
				sprite_index == sprSonicDash
			) {
				image_speed = 0.5 + abs(gsp) / 8.0;
			} else if (sprite_index == sprSonicBored || 
					   sprite_index == sprSonicBoredEx
			) { 
				image_speed = 1;
			}
			
		} else if (sprite_index != sprSonicWalk && sprite_index != sprSonicRun && sprite_index != sprSonicDash) {
			sprite_index = sprSonicWalk;
			image_speed = 0.25 + abs(gsp) / 8.0;
		}
		
		break;
	}
	
	case "roll":
	case "jump": {
		sprite_index = sprSonicRoll;
		image_speed = 0.5 + abs(gsp) / 8.0;	
		break;
	}
	
	case "dropdash": {
		sprite_index = sprSonicDropDash;
		image_speed = 0.5 + abs(gsp) / 8.0;
		break;
	}
	
	case "look_down": {
		sprite_index = sprSonicCrouch;
		image_speed = 0.5;
		if (image_index >= 1)
			image_index = 1;
		break;
	}
	
	case "look_up": {
		sprite_index = sprSonicLookUp;
		image_speed = 0.5;
		if (image_index >= 1)
			image_index = 1;
		break;
	}
	
	case "push": {
		sprite_index = sprSonicPush;
		image_speed = 0.125;
		break;
	}
	
	case "skid": {
		sprite_index = sprSonicSkid;
		image_speed = 0.55;
		
		if (image_index > 3)
			image_index = 3;
		
		break;
	}
	
	case "balancing": {
		image_speed = 0.5;
		
		if ((image_xscale == 1  && sensor.is_collision_ground_left_edge()) || 
			(image_xscale == -1 && sensor.is_collision_ground_right_edge()))
				sprite_index = sprSonicBalancing;
		else
			sprite_index = sprSonicBalancingB;
		
		break;
	}
	
	case "peelout": {
		image_speed = 0.25 + peelout_animation_spd / 25;
		
		if (peelout_animation_spd < 15)
			sprite_index = sprSonicWalk;
		else if (peelout_animation_spd < 30)
			sprite_index = sprSonicRun;
		else
			sprite_index = sprSonicDash;
			
		break;
	}
	
	case "spindash": {
		image_speed = 1;
		sprite_index = sprSonicSpindash;
	}
	break;

	case "spring": {
		image_speed = 0.125 + abs(ysp) / 10;
		
		if (ysp <= 0)
			sprite_index = sprSonicSpring;
		else
			sprite_index = sprSonicWalk;
	}
	break;
	
	case "hurt": {
		sprite_index = sprSonicHurt;
	} break;
	
	
	case "die": {
		image_speed = 0;
		image_index = 0;
		sprite_index = sprSonicDie;
	} break;
	
}


if (sprite_index != sprite_index_prev)
	image_index = 0;

sprite_index_prev = sprite_index;


