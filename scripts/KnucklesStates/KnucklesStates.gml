
function KnucklesStateJump() : PlayerStateJump() constructor {	
	override_on_step = function(player) { super(); with (player) {
		if (is_key_action_pressed) {
			if (ysp<0) ysp = 0;
			xsp = 4 * sign(image_xscale);
			state.change_to("glide");
		}
	}};
}

function KnucklesStateGlide() : BaseState() constructor {
	#macro GLIDE_ACCELERATION	0.015625
	#macro GLIDE_GRAVITY_FORCE	0.125
	
	on_start = function(player) {with (player) {
		behavior_loop.disable(player_behavior_apply_gravity);
		behavior_loop.disable(player_behavior_air_movement);
		visual_loop.disable(player_behavior_visual_flip);
		allow_jump = false;
		animator.set("glide");
	}};
	
	on_step = function(player) {with player {
		if(ysp<0.5) ysp += GLIDE_GRAVITY_FORCE;
		if(ysp>0.5) ysp -= GLIDE_GRAVITY_FORCE;
		if (ysp > 16) ysp = 16;
		if ((sensor.check_expanded(1, 0, sensor.is_collision_solid_right)) || 
			(sensor.check_expanded(1, 0, sensor.is_collision_solid_left))
		) {
			state.change_to("climbe");
		}
		if (!is_key_action) state.change_to("drop");
		xsp += GLIDE_ACCELERATION * sign(xsp);
		if((is_key_left && xsp>0) || (is_key_right && xsp<0)) state.change_to("glideRotation");
	}};
	
	on_landing = function(player) {with player {
		state.change_to("land");
	}};
	
	on_exit = function(player) {with (player) {
		allow_jump = true;
		behavior_loop.enable(player_behavior_apply_gravity);
		behavior_loop.enable(player_behavior_air_movement);
		visual_loop.enable(player_behavior_visual_flip);
	}};
}

function KnucklesStateGlideRotation() : BaseState() constructor {
	#macro GLIDE_ACCELERATION_ROTATION	2.8125
	__a = undefined;
	__t = undefined;
	__r = undefined;
	
	on_start = function(player) { with player {
		behavior_loop.disable(player_behavior_apply_gravity);
		behavior_loop.disable(player_behavior_air_movement);
		visual_loop.disable(player_behavior_visual_flip);
		other.__a = 90 - 90 * image_xscale;
		other.__t = xsp;
		other.__r = 1;
		show_debug_message($"IT IS __T and XSP, {other.__t}, {xsp}");
		animator.set("glideRotation");
	}};
	
	on_step = function(player) {with player {
		if(ysp<0.5) ysp += GLIDE_GRAVITY_FORCE;
		if(ysp>0.5) ysp -= GLIDE_GRAVITY_FORCE;
		if ((sensor.check_expanded(1, 0, sensor.is_collision_solid_right)) || (sensor.check_expanded(1, 0, sensor.is_collision_solid_left))) { state.change_to("climbe"); }
		if (!is_key_action) state.change_to("drop");
		
		
		if (is_key_left) other.__r=1;
		if (is_key_right) other.__r=-1;
		other.__a += GLIDE_ACCELERATION_ROTATION * sign(other.__t) * other.__r;
		xsp = abs(other.__t) * dcos(other.__a);
		
		
		show_debug_message($"{other.__a}, {dcos(other.__a)}");
		if(dcos(other.__a)==1 || dcos(other.__a)==-1) state.change_to("glide");
	}};
	
	on_animate = function(player) {with player {
		animator.set("glideRotation");
		animator.set_image_index(other.__a/45);
	}};
	
	on_landing = function(player) {with player {
		state.change_to("land");
	}};
	
	on_exit = function(player) { with player {
		if(sign(other.__t) != sign(xsp)) image_xscale *= -1;
		behavior_loop.enable(player_behavior_apply_gravity);
		behavior_loop.enable(player_behavior_air_movement);
		visual_loop.enable(player_behavior_visual_flip);
	}};
}

function KnucklesStateDrop() : BaseState() constructor {		
	on_start = function(player) {with (player) {
		behavior_loop.disable(player_behavior_ground_movement);
		behavior_loop.disable(player_behavior_air_movement);
		allow_jump = false;
		drop_time=0;
		animator.set("drop");
	}};
	
	on_animate = function(player) {with (player) {
		if(ground) animator.set("look_down");
	}};
	
	on_step = function(player) {with (player) {
		if(ground) {
			drop_time++;
			if(drop_time>10) state.change_to("normal");
		}
	}};
	
	on_landing = function(player) {with player {
		drop_time=0;
		gsp=0;
	}};
	
	on_exit = function(player) { with player {
		behavior_loop.enable(player_behavior_ground_movement);
		behavior_loop.enable(player_behavior_air_movement);
		allow_jump = true;
	}};
}

function KnucklesStateClimbe() : BaseState() constructor {
	#macro CLIMBE_ACCELERATION	1
		
	on_start = function(player) {with (player) {
		behavior_loop.disable(player_behavior_apply_gravity);
		behavior_loop.disable(player_behavior_air_movement);
		visual_loop.disable(player_behavior_visual_flip);
		//allow_movement = false;
		if(sensor.check_expanded(1, 0, sensor.is_collision_solid_right)) image_xscale = 1;
		if(sensor.check_expanded(1, 0, sensor.is_collision_solid_left)) image_xscale = -1;
		animator.set("climbe");
	}};
	
	on_step = function(player) {with player {
		if (is_key_action_pressed){
			image_xscale *= -1;
			xsp = 4 * image_xscale;
			ysp = -4;
			state.change_to("jump");
			return;
		}
		ysp = 0;
		if (is_key_up && !sensor.check_expanded(0, 1, sensor.is_collision_solid_top)) ysp -= CLIMBE_ACCELERATION;
		if (is_key_down) ysp += CLIMBE_ACCELERATION;
		
		if(!sensor.check_expanded(1, 0, sensor.is_collision_solid_bottom) || sensor.check_expanded(-1, 1, sensor.is_collision_solid_bottom)){ state.change_to("drop"); return; }
		if(!sensor.check_expanded(1, 0, sensor.is_collision_solid_top)){ state.change_to("clambering"); return; }
	}};
	
	on_animate = function(player) {with player {
		animator.set_image_speed(ysp/10);
	}};
	
	on_exit = function(player) {with (player) {
		//allow_movement = true;
		behavior_loop.enable(player_behavior_apply_gravity);
		behavior_loop.enable(player_behavior_air_movement);
		visual_loop.enable(player_behavior_visual_flip);
	}};
}

function KnucklesStateClambering() : BaseState() constructor {
	on_start = function(player) {with (player) {
		allow_jump = false;
		//allow_movement = false;
		behavior_loop.disable(player_behavior_ground_movement);
		time_climbeEx=40;
		xsp=0;
		y-=27;
		x+=19*sign(image_xscale);
		animator.set("clambering");
	}};
	
	on_step = function(player) {with player {
		if(time_climbeEx<0)	state.change_to("normal");
		else time_climbeEx--;
	}};
	
	on_exit = function(player) {with (player) {
		behavior_loop.enable(player_behavior_ground_movement);
		allow_jump = true;
		//allow_movement = true;
	}};
}

function KnucklesStateLand() : BaseState() constructor {
	on_start = function(player) {with (player) {
		behavior_loop.disable(player_behavior_ground_movement);
		behavior_loop.disable(player_behavior_ground_friction);
		allow_jump = false;
		rise_time=0;
		animator.set("land");
	}};
	
	on_step = function(player) {with player {
		if(xsp==0) {
			rise_time++;
			if (rise_time>10) state.change_to("normal");
		}
		gsp -= min(abs(gsp), 0.125) * sign(gsp);
		
	}};
	
	on_animate = function(player) {with (player) {
		if(xsp==0) animator.set_image_index(1);
		else animator.set_image_index(0);
	}};
	
	on_exit = function(player) {with (player) {
		behavior_loop.enable(player_behavior_ground_movement);
		behavior_loop.enable(player_behavior_ground_friction);
		allow_jump = true;
	}};
}

