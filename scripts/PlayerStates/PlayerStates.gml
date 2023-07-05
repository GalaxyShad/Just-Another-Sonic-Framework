
function is_player_sphere() {
	return array_contains([
		"jump",
		"roll",
		"dropdash",
		//"glid",
		"land",
	], state.current());
}

function create_basic_player_states() {
state = new State(id);

state.add("normal", {
	__idle_anim_timer: undefined,
	
	on_start: function() {
		__idle_anim_timer = 0;
	},
	
	on_step: function(player) {with (player) {
		// Look Up and Down
		if (ground && is_key_up && gsp == 0)
			state.change_to("look_up");
		if (ground && is_key_down && gsp == 0)
			state.change_to("look_down");
			
		// To Roll
		if (ground && is_key_down && abs(gsp) >= 1) {
			state.change_to("roll");
			audio_play_sound(sndPlrRoll, 0, false);
		}
		
		// Skid
		if (ground && abs(gsp) >= 4 && 
			((gsp < 0 && is_key_right) || (gsp > 0 && is_key_left))
		) {
			state.change_to("skid");
			audio_play_sound(sndPlrBraking, 0, false);
		}
		
		// Balancing
		var _check_balanced = (sensor.check_expanded(-6, 0, function() { 
			return (!sensor.is_collision_ground_left_edge() || !sensor.is_collision_ground_right_edge()); 
		}));
		
		if (ground && gsp == 0 && _check_balanced) {
			state.change_to("balancing");
		}
		
		
	}},
	

	on_exit: function() {
		
	},
	
	on_animate: function(player) { with player {
		var _abs_gsp = abs(gsp);
		
		other.__idle_anim_timer = (ground && _abs_gsp == 0) ? 
			other.__idle_anim_timer+1 : 0;
			
		if (!ground) {
			animator.set("walking");
			animator.set_image_speed(0.125 + _abs_gsp / 24.0);
			
			return;
		}
		

		if (_abs_gsp == 0) {
			if (other.__idle_anim_timer >= 180 && other.__idle_anim_timer < 816)
				animator.set("bored");
			else if (other.__idle_anim_timer >= 816)
				animator.set("bored_ex");
			else 
				animator.set("idle");
		} else {
			if (_abs_gsp < 6)
				animator.set("walking");
			else if (_abs_gsp < 12)
				animator.set("running");
			else 
				animator.set("dash");
		}
				
				
		if (animator.is(["walking", "running", "dash"])) {
			animator.set_image_speed(0.125 + _abs_gsp / 24.0);
		} 
	}},
});

state.add("jump", {
	__bounce_force: 7.5,
	
	on_start: function(player) {
		
	},
	
	__use_shield: function(player) { with player {
		if (!is_instanceof(shield, ShieldUseable)) return;
		
		if (shield.is_ability_used()) return;
		
		shield.use_ability(player);
	}},
	
	on_step: function(player) { with (player) {
		if (!is_key_action && ysp < physics.jump_release)
			ysp = physics.jump_release;
			
		if (is_key_action_pressed && !is_instanceof(shield, ShieldUseable)) {
			if(object_index==objPlayer){
				audio_play_sound(sndPlrDropDash, 0, false);
				state.change_to("dropdash");
			}
			else if(object_index==objPlayerKnuckles){
				ysp = 0;
				xsp = (3+xsp/3) * sign(image_xscale);//0->(3+xsp/3)
				state.change_to("glid");
			}
			//show_debug_message($"This is player -> {object_get_name(object_index)}");
		}
		
		if (!ground && is_key_action_pressed)  {
			other.__use_shield(self);
		}
	}},
	
	on_landing: function(player) { with (player) {
		if (is_instanceof(shield, ShieldUseable)) {			
			if (is_instanceof(shield, ShieldBubble) && shield.is_ability_used()) {
				shield.bounce(self);
				shield.reset_ability();
				return;	
			}
			
			shield.reset_ability();
		}
			
		state.change_to("normal");	
	}},
	
	on_exit: function(player) {
		player.using_shield_abbility = false;
	},
	
	on_animate: function(player) { with player {
		animator.set("curling");
		animator.set_image_speed(0.5 + abs(gsp) / 8.0);
	}},
});

state.add("look_up", {
	on_start: function(player) { with player {
		allow_jump = false;	
		allow_movement = false;	
		animator.set("look_up");
	}},
	
	on_exit: function(player) { with player {
		allow_jump = true;	
		allow_movement = true;	
	}},
	
	on_step: function(player) { with (player) {
		if (!is_key_up || !ground || gsp != 0)
			state.change_to("normal");
			
		if (ground && is_key_action)
			if(object_index==objPlayer) state.change_to("peelout");
			else state.change_to("jump")
	}},
});

state.add("look_down", {
	on_start: function(player) { with player {
		allow_jump = false;	
		allow_movement = false;	
		animator.set("look_down");
	}},
	
	on_exit: function(player) { with player {
		allow_jump = true;	
		allow_movement = true;	
	}},
	
	on_step: function(player) { with player {
		if (!is_key_down || !ground)
			state.change_to("normal");
		else if (abs(gsp) >= 1.0)
			state.change_to("roll");
			
		if (ground && is_key_action_pressed)
			state.change_to("spindash");	
	}},
});

state.add("push", {
	on_step: function(player) { with player {
		xsp = 0;
		gsp = 0;
	
		if ((image_xscale == 1 && !is_key_right) || (image_xscale == -1 && !is_key_left))
			state.change_to("normal");
	}},
	
	on_animate: function(player) { with player {
		animator.set("push");
	}},
});

state.add("roll", {
	on_step: function(player) { with player {
		var _agsp = abs(gsp);
		
		if (_agsp < 0.5)
			state.change_to("normal");
	}},
	
	on_animate: function(player) { with player {
		animator.set("curling");
		animator.set_image_speed(0.5 + abs(gsp) / 8.0);
	}},
});

state.add("skid", {
	on_step: function(player) { with player {
		if (abs(gsp) <= 0.5 || !ground || 
		    ((gsp < 0 && is_key_left) || (gsp > 0 && is_key_right))
		) {
			state.change_to("normal");	
		}
	}},
	
	on_start: function(player) { with player {
		animator.set("skid");
	}},
});

state.add("balancing", {
	on_start: function(player) { with player {
		if ((image_xscale == 1  && sensor.is_collision_ground_left_edge()) || 
			(image_xscale == -1 && sensor.is_collision_ground_right_edge())
		)
			animator.set("balancing_a");
		else
			animator.set("balancing_b");
	}},
	
	on_step: function(player) { with player {
		if (gsp != 0 || !ground)
			state.change_to("normal");
	}},
});

state.add("peelout", {
	__timer: 0,
	
	on_start: function(player) { with player {
		audio_play_sound(sndPlrPeelCharge, 0, false);
		other.__timer = 0;
		allow_jump = false;	
		player.allow_movement = false;	
	}},
	
	on_exit: function(player) { with player {
		allow_jump = true;	
		allow_movement = true;	
	}},
	
	on_step: function(player) { 
		with player {
			if (!is_key_up) {
				if (other.__timer >= 30) {
					gsp = 12 * image_xscale;
			
					audio_stop_sound(sndPlrPeelCharge);
					audio_play_sound(sndPlrPeelRelease, 0, false);
			
					camera.set_lag_timer(15);
				} else {
					other.__timer = 0;		
				}
		
				state.change_to("normal");
			}
			
		}
		
		__timer++;
		if __timer > 30
			__timer = 30;
	},
	
	on_animate: function(player) { with player {
		animator.set_image_speed(0.25 + other.__timer / 25);
		
		if (other.__timer < 15)
			animator.set("walking");
		else if (other.__timer < 30)
			animator.set("running");
		else
			animator.set("dash");
	}},
});

state.add("spindash", {
	__spinrev: 0,
	
	on_start: function(player) {
		audio_sound_pitch(sndPlrSpindashCharge, 1);
		audio_play_sound(sndPlrSpindashCharge, 0, false);
		__spinrev = 0;
		
		with player {
			allow_jump = false;	
			allow_movement = false;	
			animator.set("spindash");	
		}
	},
	
	on_exit: function(player) { with player {
		allow_jump = true;	
		allow_movement = true;	
	}},
	
	on_step: function(player) {
		with player {
			if (!is_key_down) {
				gsp = (8 + (floor(other.__spinrev) / 2)) * sign(image_xscale);
		
				audio_stop_sound(sndPlrSpindashCharge);
				audio_play_sound(sndPlrSpindashRelease, 0, false);
			
				state.change_to("roll");
		
				camera.set_lag_timer(15);
			}
		}
	
		if (player.is_key_action_pressed) {
			__spinrev += (__spinrev < 8) ? 2 : 0;
		
			audio_stop_sound(sndPlrSpindashCharge);
		
			audio_sound_pitch(sndPlrSpindashCharge, 1 + __spinrev / 10);
			audio_play_sound(sndPlrSpindashCharge, 0, false);
		
		}
	
		__spinrev -= (((__spinrev * 1000) div 125) / 256000);
		
	},
});


#macro DROPDASH_SPEED			8
#macro DROPDASH_SPEED_SUPER		12
#macro DROPDASH_MAX				12
#macro DROPDASH_MAX_SUPER		13

state.add("dropdash", {
	__drop_timer:				0,
	
	on_start: function(player) {
		__drop_timer = 0;
		
		audio_play_sound(sndPlrDropDash, 0, false);
		
		with player {
			animator.set("dropdash");
			//animator.set_image_speed(0.5 + abs(gsp) / 8.0);
		}
	},
		
	on_landing: function(player) {with player {
		if (other.__drop_timer < 20) {
			state.change_to("normal");
			return;
		}
		
		state.change_to("roll");
		audio_play_sound(sndPlrSpindashRelease, 0, false);
		
		var _drpspd = physics.is_super() ? DROPDASH_SPEED_SUPER : DROPDASH_SPEED;
		var _drpmax = physics.is_super() ? DROPDASH_MAX_SUPER : DROPDASH_MAX;
		
		if (sign(image_xscale) == sign(xsp))
			gsp = (gsp / 4) + (_drpspd * sign(image_xscale));
		else 
			gsp = ((sensor.get_angle() == 0) ? 
				0 : 
				(gsp / 2)) + (_drpspd * sign(image_xscale));
				
		if (abs(gsp) > _drpmax) 
			gsp = _drpmax * sign(gsp);
				
		camera.set_lag_timer(15);
	}},
	
	on_step: function(player) {with player {
		if (!is_key_action)
			state.change_to("jump");
			
		other.__drop_timer++;
	}},
});

state.add("hurt", {
	on_start: function(player) {with (player) {
		allow_movement = false;		
		animator.set("hurt");
	}},
	
	on_exit: function(player) {with (player) {
		allow_movement = true;			
	}},
	
	on_landing: function(player) {with (player) {
		inv_timer = 120;
		
		state.change_to("normal");
		
		gsp = 0;
		xsp = 0;
	}},
});

state.add("die", {
	on_start: function(player) {with (player) {
		audio_play_sound(sndHurt, 0, false);	
		
		xsp = 0;
		ysp = -7;
		
		animator.set("die");
	}},
});

state.add("glid", {
	//dropdash->glid
	
	on_start: function(player) {with (player) {
		allow_jump = false;
		allow_movement = false;
	}},
	
	on_step: function(player) {with player {
		if (!is_key_action)
			state.change_to("drop");
	}},
	
	on_landing: function(player) {with player {
		state.change_to("land");
	}},
	
	on_exit: function(player) {with (player) {
		allow_jump = true;	
		allow_movement = true;			
	}},
});

state.add("drop", {
	
	on_start: function(player) { with player {
	}},
	
	
	on_landing: function(player) {with player {
		state.change_to("look_down");
	}},
	
	on_exit: function(player) { with player {
	}},
	
});

state.add("land", {
	
	on_start: function(player) { with player {
		allow_jump = false;
		allow_movement = false;
	}},
	
	on_step: function(player) {with player {
		if (abs(xsp)<3) state.change_to("normal");
	}},
	
	on_exit: function(player) { with player {
		gsp = 0;
		allow_jump = true;	
		allow_movement = true;	
	}},
});

state.add("breathe", {
	on_start: function(player) {
		__timer = 20;
		player.animator.set("breathe");
	},
	
	on_step: function(player) {
		if (__timer > 0)
			__timer--;
		else with player {
			state.change_to("normal");
		}
	},
});

state.add("spring", {
	on_start: function(player) {
		player.animator.set("spring");
	},
	
	on_animate: function(player) { with player {
		if (ysp <= 0)	{
			animator.set_image_speed(0.125 + abs(ysp) / 10);
			animator.set("spring");
		} else {
			animator.set_image_speed(0.25);
			animator.set("walking");
		}
	}},
});

state.add("transform", {
	on_start: function(player) {
		player.ground = false;
		player.animator.set("transform");
		player.allow_movement = false;
	},
	
	on_animate: function(player) { with player {
		ysp = 0;
		xsp = 0;
		
		if (animator.get_image_index() >= 12 && !physics.is_super()) {
			player_set_super_form();	
			audio_play_sound(sndPlrTransform, 0,0);
		}
		
		if (animator.is_animation_ended())
			state.change_to("normal");
	}},
	
	on_exit: function(player) {
		player.allow_movement = true;	
	}
});


state.change_to("normal");
return state;
}