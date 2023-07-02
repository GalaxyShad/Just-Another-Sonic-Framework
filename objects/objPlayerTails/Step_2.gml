/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе



if (!ground) {
	animation_angle += angle_difference(0, animation_angle) / 10;
} else {
	var _ang = (sensor.get_angle() >= 35 && sensor.get_angle() <= 325) ? sensor.get_angle() : 0;
	animation_angle += angle_difference(_ang, animation_angle) / 4;
}

if (sprite_index == sprTailsRoll)
	animation_angle = 0;

if (animation_angle < 0) animation_angle = 360 + animation_angle;
animation_angle = (abs(animation_angle) % 360);

image_angle = animation_angle;

if (ground) {
	if		(is_key_right && gsp > 0)	image_xscale = 1;
	else if (is_key_left  && gsp < 0)	image_xscale = -1;
} else if(!climbe) {
	if		(is_key_right)	image_xscale = 1;
	else if (is_key_left)	image_xscale = -1;	
}

if (gsp == 0 && state.current() == "normal")
	idle_anim_timer++;
else
	idle_anim_timer = 0;

switch (state.current()) {
	case "normal": {
		if (ground) {
			if (abs(gsp) == 0) {
				
				if (idle_anim_timer >= 180 && idle_anim_timer < 816)
					sprite_index = sprTailsBored;
				else
					sprite_index = sprTails;
					
				if (idle_anim_timer > 236 && sprite_index == sprSonicBored) {
					if (image_index < 1)
						image_index = 0;
				}
				
				
			} else if (abs(gsp) < 6)
				sprite_index = sprTailsWalk;
			else if (abs(gsp) < 12) 
				sprite_index = sprTailsRun;
			else
				sprite_index = sprTailsDash;
				
				
			if (sprite_index == sprTailsWalk || sprite_index == sprTailsRun)
				image_speed = 0.125 + abs(gsp) / 8.0;
			else if (sprite_index == sprTailsBored)
				image_speed = 1;
			
		} else if (sprite_index != sprTailsWalk && sprite_index != sprTailsRun) {
			sprite_index = sprTailsWalk;
			image_speed = 0.25 + abs(gsp) / 32.0;
		}
		
		break;
	}
	
	case "jump":
	case "roll": {
		sprite_index = sprTailsRoll;
		image_speed = 0.5 + abs(gsp) / 8.0;
	
		break;
	}
	
	case "look_down": {
		sprite_index = sprTailsCrouch;
		image_speed = 0.5;
		if (image_index >= 1)
			image_index = 1;
		break;
	}
	
	case "look_up": {
		sprite_index = sprTailsLookUp;
		image_speed = 0.5;
		if (image_index >= 1)
			image_index = 1;
		break;
	}
	
	case "push": {
		sprite_index = sprTailsPush;
		image_speed = 1;
		break;
	}
	
	case "skid": {
		sprite_index = sprTailsSkid;
		image_speed = 0.55;
		
		if (image_index > 2)
			image_index = 2;
		
		break;
	}
	
	case "balancing": {
		image_speed = 1;
		sprite_index = sprTailsBalancing;
		break;
	}
	
	case "peelout": {
		image_speed = 0.25 + peelout_timer / 25;
		
		if (peelout_timer < 15)
			sprite_index = sprTailsWalk;
		else
			sprite_index = sprTailsRun;
			
		break;
	}
	
	case "spindash": {
		image_speed = 1;
		sprite_index = sprTailsSpindash;
		break;
	}

	case "spring": {
		image_speed = 0.125 + abs(ysp) / 10;
		
		if (ysp <= 0)
			sprite_index = sprTailsSpring;
		else
			sprite_index = sprTailsWalk;
		break;
	}
	
	case "hurt": {
		sprite_index = sprTailsHurt;
		break;
	}
	
	case "die": {
		image_speed = 0;
		image_index = 0;
		sprite_index = sprTailsDie;
		break;
	}
	
	case "breathe": {
		sprite_index = sprTailsBreathe;
	} break;

}

if (sprite_index != sprite_index_prev)
	image_index = 0;

sprite_index_prev = sprite_index;


