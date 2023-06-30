/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе



if (!ground) {
	animation_angle += angle_difference(0, animation_angle) / 10;
} else {
	var _ang = (sensor.get_angle() >= 35 && sensor.get_angle() <= 325) ? sensor.get_angle() : 0;
	animation_angle += angle_difference(_ang, animation_angle) / 4;
}

if (sprite_index == sprKnucklesRoll)
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

if (gsp == 0 && state.current() == "normal")
	idle_anim_timer++;
else
	idle_anim_timer = 0;

switch (state.current()) {
	case "normal": {
		if (ground) {
			if (abs(gsp) == 0) {
				
				if (idle_anim_timer >= 180 && idle_anim_timer < 816)
					sprite_index = sprKnucklesBored;
				else if (idle_anim_timer >= 816)
					sprite_index = sprKnucklesBoredEx;
				else
					sprite_index = sprKnuckles;
					
				if (idle_anim_timer > 236 && sprite_index == sprSonicBored) {
					if (image_index < 1)
						image_index = 0;
				}
				
				if (idle_anim_timer >= 816 && sprite_index == sprKnucklesBoredEx) {
					if (idle_anim_timer >= 832)
						image_index += 0.1;
				}
				
				
			} else if (abs(gsp) < 6)
				sprite_index = sprKnucklesWalk;
			else sprite_index = sprKnucklesRun;
				
				
			if (sprite_index == sprKnucklesWalk || sprite_index == sprKnucklesRun)
				image_speed = 0.125 + abs(gsp) / 8.0;
			else if (sprite_index == sprKnucklesBored || sprite_index == sprKnucklesBoredEx)
				image_speed = 1;
				
			//show_debug_message($"img spd {image_speed}");
			
		} else if (sprite_index != sprKnucklesWalk && sprite_index != sprKnucklesRun) {
			sprite_index = sprKnucklesWalk;
			image_speed = 0.25 + abs(gsp) / 32.0;
		}
		
		break;
	}
	
	case "jump":
	case "roll": {
		sprite_index = sprKnucklesRoll;
		image_speed = 0.5 + abs(gsp) / 8.0;
	
		break;
	}
	
	case "look_down": {
		sprite_index = sprKnucklesCrouch;
		image_speed = 0.5;
		if (image_index >= 1)
			image_index = 1;
		break;
	}
	
	case "look_up": {
		sprite_index = sprKnucklesLookUp;
		image_speed = 0.5;
		if (image_index >= 1)
			image_index = 1;
		break;
	}
	
	case "push": {
		sprite_index = sprKnucklesPush;
		image_speed = 1;
		break;
	}
	
	case "skid": {
		sprite_index = sprKnucklesSkid;
		image_speed = 0.55;
		
		if (image_index > 2)
			image_index = 2;
		
		break;
	}
	
	case "balancing": {
		image_speed = 1;
		
		if ((image_xscale == 1  && sensor.is_collision_ground_left_edge()) || 
			(image_xscale == -1 && sensor.is_collision_ground_right_edge()))
				sprite_index = sprKnucklesBalancing;
		else
			sprite_index = sprKnucklesBalancingB;
		break;
	}
	
	case "peelout": {
		image_speed = 0.25 + peelout_timer / 25;
		
		if (peelout_timer < 15)
			sprite_index = sprKnucklesWalk;
		else
			sprite_index = sprKnucklesRun;
			
		break;
	}
	
	case "spindash": {
		image_speed = 1;
		sprite_index = sprKnucklesSpindash;
		break;
	}

	case "spring": {
		image_speed = 0.125 + abs(ysp) / 10;
		
		if (ysp <= 0)
			sprite_index = sprKnucklesSpring;
		else
			sprite_index = sprKnucklesWalk;
		break;
	}
	
	case "hurt": {
		sprite_index = sprKnucklesHurt;
		break;
	}
	
	case "die": {
		image_speed = 0;
		image_index = 0;
		sprite_index = sprKnucklesDie;
		break;
	}

	case "glid": {
		//sprite_index = sprKnucklesGlid;
		
		sprite_index = sprKnucklesUngroundedRotation;
		
		if(abs(xsp)>kgr) _gg=kgr*sign(xsp);
		else _gg = xsp;
		image_index = kgr - _gg * sign(image_xscale);
		
		break;
	}
	
	case "land": {
		sprite_index = sprKnucklesLand;
		if(abs(xsp)>2) image_index=0;
		else image_index=1;
		break;
	}
	
	case "drop": {
		sprite_index = sprKnucklesDrop;
		if(ysp<3) image_index=0;
		else image_index=1;
		break;
	}
}

if (sprite_index != sprite_index_prev)
	image_index = 0;

sprite_index_prev = sprite_index;


