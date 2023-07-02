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

if (gsp == 0 && state.current() == "normal")
	idle_anim_timer++;
else
	idle_anim_timer = 0;


switch (state.current()) {
	case "normal": {
		if (ground) {
			if (abs(gsp) == 0) {
				

				if (idle_anim_timer >= 180 && idle_anim_timer < 816)
					animator.set("bored");
					//sprite_index = sprSonicBored;
				else if (idle_anim_timer >= 816)
					animator.set("bored_ex");
					//sprite_index = sprSonicBoredEx;
				else
					animator.set("idle");
					//sprite_index = sprSonic;
					
				/*if (idle_anim_timer > 236 && animator.current() == "bored") {
					if (image_index < 2)
						image_index = 2;
				}
				
				if (idle_anim_timer >= 816 && animator.current() == "bored_ex") {
					if (idle_anim_timer >= 832 && image_index < 2)
						image_index = 2;
				}*/
				
				
			} else if (abs(gsp) < 6)
				animator.set("walking");
			else if (abs(gsp) < 12) 
				animator.set("running");
			else
				animator.set("dash");
				
				
			if (animator.current() == "walking" || 
				animator.current() == "running" || 
				animator.current() == "dash"
			) {
				animator.set_image_speed(0.125 + abs(gsp) / 24.0);
				//image_speed = 0.5 + abs(gsp) / 8.0;
			} else if (animator.current() == "bored" || 
					   animator.current() == "bored_ex"
			) { 
				//animator.set_image_speed(1);
				//image_speed = 1;
			}
			
		} else if (animator.current() != "walking" && 
				   animator.current() != "running" && 
				   animator.current() != "dash"
		) {
			animator.set("walking");
			animator.set_image_speed(0.25 + abs(gsp) / 8.0);
			//image_speed = 0.25 + abs(gsp) / 8.0;
		}
		
		break;
	}
	
	case "roll":
	case "jump": {
		animator.set("curling");
		animator.set_image_speed(0.5 + abs(gsp) / 8.0);
		//sprite_index = sprSonicRoll;
		//image_speed = 0.5 + abs(gsp) / 8.0;	
		break;
	}
	
	case "dropdash": {
		animator.set("dropdash");
		animator.set_image_speed(0.5 + abs(gsp) / 8.0);
		//sprite_index = sprSonicDropDash;
		//image_speed = 0.5 + abs(gsp) / 8.0;
		break;
	}
	
	case "look_down": {
		animator.set("look_down");
		/*sprite_index = sprSonicCrouch;
		image_speed = 0.5;
		if (image_index >= 1)
			image_index = 1;*/
		break;
	}
	
	case "look_up": {
		animator.set("look_up");
		/*sprite_index = sprSonicLookUp;
		image_speed = 0.5;
		if (image_index >= 1)
			image_index = 1;*/
		break;
	}
	
	case "push": {
		animator.set("push");
		//sprite_index = sprSonicPush;
		//image_speed = 0.125;
		break;
	}
	
	case "skid": {
		animator.set("skid");
		/*image_speed = 0.55;
		
		if (image_index > 3)
			image_index = 3;*/
		
		break;
	}
	
	case "balancing": {
		if ((image_xscale == 1  && sensor.is_collision_ground_left_edge()) || 
			(image_xscale == -1 && sensor.is_collision_ground_right_edge())
		)
			animator.set("balancing_a");
		else
			animator.set("balancing_b");
		
		break;
	}
	
	case "peelout": {
		animator.set_image_speed(0.25 + peelout_animation_spd / 25);
		
		if (peelout_animation_spd < 15)
			animator.set("walking");
		else if (peelout_animation_spd < 30)
			animator.set("running");
		else
			animator.set("dash");
			
		break;
	}
	
	case "spindash": {
		animator.set("spindash");
	}
	break;

	case "spring": {
		animator.set_image_speed(0.125 + abs(ysp) / 10);
		
		if (ysp <= 0)	animator.set("spring");
		else			animator.set("walking");
	}
	break;
	
	case "hurt": {
		animator.set("hurt");
	} break;
	
	case "die": {
		animator.set("die");
	} break;
	
	case "breathe": {
		animator.set("breathe");
	} break;
	
}

//sprite_index = animator.get_sprite();
/*
if (sprite_index != sprite_index_prev) {
	image_speed = 1;
	image_index = 0;
}

sprite_index_prev = sprite_index;
*/

var _res = animator.animate();
sprite_index = _res[0];
image_index = _res[1];
image_speed = 0;

if (physics.is_underwater() && shield != Shield.Bubble)
	timer_underwater.tick();
timer_speed_shoes.tick();

