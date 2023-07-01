// Ресурсы скриптов были изменены для версии 2.3.0, подробности см. по адресу
// https://help.yoyogames.com/hc/en-us/articles/360005277377
function is_player_sphere() {
	return array_contains([
		"jump",
		"roll",
		"dropdash",
		"land",
	], state.current());
}

function PlayerStates() {

state.add("normal", {
	on_start: function() {
		
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
			audio_play_sound(sndPlrRoll, 0, false, global.sound_volume);
		}
		
		// Skid
		if (ground && abs(gsp) >= 4 && 
			((gsp < 0 && is_key_right) || (gsp > 0 && is_key_left))
		) {
			state.change_to("skid");
			audio_play_sound(sndPlrBraking, 0, false, global.sound_volume);
		}
		
		// Balancing
		if (ground && gsp == 0 && state.current()!="climbeEx" && state.current()!="climbe" && 
			(!sensor.is_collision_ground_left_edge() || !sensor.is_collision_ground_right_edge())
		) {
			state.change_to("balancing");
		}
		
		
	}},
	
	on_exit: function() {
		
	},
});

state.add("jump", {
	__bounce_force: 7.5,
	
	on_start: function(player) {
		
	},
	
	on_step: function(player) { with (player) {
		if (!is_key_action && ysp < physics.jump_release)
			ysp = physics.jump_release;
			
		if (is_key_action_pressed && 
			(shield == SHIELD_NONE || shield == SHIELD_CLASSIC)
		) {
			if(object_index==objPlayer){
				audio_play_sound(sndPlrDropDash, 0, false, global.sound_volume);
				state.change_to("dropdash");
			}
			else if(object_index==objPlayerKnuckles){
				ysp = 0;
				xsp = (3+abs(xsp)/2) * sign(image_xscale);
				state.change_to("glide");
			}
			//show_debug_message($"This is player -> {object_get_name(object_index)}");
		}
		
		
		if (!ground && is_key_action_pressed && !using_shield_abbility)  {
			using_shield_abbility = true;
			
			if (shield == SHIELD_BUBBLE) {
				audio_play_sound(sndBubbleBounce, 0, false, global.sound_volume);
				water_shield_scale.xscale = 0.5;
				water_shield_scale.yscale = 1.5;
				xsp = 0;
				ysp = 8;
			} else if (shield == SHIELD_FIRE) {
				audio_play_sound(sndFireDash, 0, false, global.sound_volume);
				ysp = 0;
				xsp = 8 * sign(image_xscale);
				camera.lagTimer = 15;
			} else if (shield == SHIELD_ELECTRIC) {
				audio_play_sound(sndLightningJump, 0, false, global.sound_volume);
				ysp = -5.5;
				var _particle = part_system_create(ParticleSystem1);
				part_system_depth(_particle, -1000);
				part_system_position(_particle, x, y);
				//part_particles_create(ParticleSystem1, x, y, , 5);
			}
		}
	}},
	
	on_landing: function(player) {with (player) {
		if (using_shield_abbility && shield == SHIELD_BUBBLE) {
			var _angle = sensor.get_angle();
			
			while (sensor.is_collision_solid_bottom()) {
				x -= dsin(_angle);
				y -= dcos(_angle);
				
				sensor.set_position(x, y);
			}
			
			water_shield_scale.__xscale = 2.0;
			water_shield_scale.__yscale = 0.25;
			
			water_shield_scale.xscale = 1;
			water_shield_scale.yscale = 1;
			
			xsp -= other.__bounce_force * dsin(_angle);
			ysp -= other.__bounce_force * dcos(_angle);
			
			show_debug_message($"{_angle} {other.__bounce_force} {xsp} {ysp}");
			
			ground = false;
			
			using_shield_abbility = false;
		} else {
			state.change_to("normal");	
		}
			
	}},
	
	on_exit: function(player) {
		player.using_shield_abbility = false;
	},
});

state.add("look_up", {
	on_start: function(player) { with player {
		allow_jump = false;	
		allow_movement = false;	
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
});

state.add("roll", {
	on_step: function(player) { with player {
		var _agsp = abs(gsp);
		
		if (_agsp < 0.5)
			state.change_to("normal");
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
});

state.add("balancing", {
	on_step: function(player) { with player {
		if (gsp != 0 || !ground)
			state.change_to("normal");
	}},
});

state.add("peelout", {
	__timer: 0,
	
	on_start: function(player) { with player {
		audio_play_sound(sndPlrPeelCharge, 0, false, global.sound_volume);
		other.__timer = 0;
		allow_jump = false;	
		player.allow_movement = false;	
		
		player.peelout_animation_spd = 0;
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
					audio_play_sound(sndPlrPeelRelease, 0, false, global.sound_volume);
			
					camera.lagTimer = 15;
				} else {
					other.__timer = 0;		
				}
		
				state.change_to("normal");
			}
			
		}
		
		__timer++;
		if __timer > 30
			__timer = 30;
			
		player.peelout_animation_spd = __timer;
	},
});

state.add("spindash", {
	__spinrev: 0,
	
	on_start: function(player) {
		audio_sound_pitch(sndPlrSpindashCharge, 1);
		audio_play_sound(sndPlrSpindashCharge, 0, false, global.sound_volume);
		__spinrev = 0;
		player.allow_jump = false;	
		player.allow_movement = false;	
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
				audio_play_sound(sndPlrSpindashRelease, 0, false, global.sound_volume);
			
				state.change_to("roll");
		
				camera.lagTimer = 15;
			}
		}
	
		if (player.is_key_action_pressed) {
			__spinrev += (__spinrev < 8) ? 2 : 0;
		
			audio_stop_sound(sndPlrSpindashCharge);
		
			audio_sound_pitch(sndPlrSpindashCharge, 1 + __spinrev / 10);
			audio_play_sound(sndPlrSpindashCharge, 0, false, global.sound_volume);
		
		}
	
		__spinrev -= (((__spinrev * 1000) div 125) / 256000);
		
	},
});

state.add("dropdash", {
	__drop_timer: 0,
	
	on_start: function(player) {
		__drop_timer = 0;
		audio_play_sound(sndPlrDropDash, 0, false, global.sound_volume);
	},
		
	on_landing: function(player) {with player {
		if (other.__drop_timer < 20) {
			state.change_to("normal");
			return;
		}
		
		state.change_to("roll");
		audio_play_sound(sndPlrSpindashRelease, 0, false, global.sound_volume);
		
		if (sign(image_xscale) == sign(xsp))
			gsp = (gsp / 4) + (drpspd * sign(image_xscale));
		else 
			gsp = ((sensor.get_angle() == 0) ? 0 : (gsp / 2)) + (drpspd * sign(image_xscale));
				
		camera.lagTimer = 15;
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
		audio_play_sound(sndHurt, 0, false, global.sound_volume);	
		
		xsp = 0;
		ysp = -7;
	}},
});

state.add("glide", {
	on_start: function(player) {with (player) {
		allow_jump = false;
		allow_movement = false;
	}},
	
	on_step: function(player) {with player {
		if (!is_key_action) state.change_to("drop");
		
		if(!is_key_left && !is_key_right && abs(xsp) < glide_top){
			xsp += physics.air_acceleration_speed * sign(image_xscale);
		}
		else if (is_key_left && xsp > -glide_top){ xsp -= physics.air_acceleration_speed; }
		else if (is_key_right && xsp < glide_top){ xsp += physics.air_acceleration_speed; }
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
		if (abs(xsp)<3 || ysp!=0) state.change_to("normal");
	}},
	
	on_exit: function(player) { with player {
		gsp = 0;
		allow_jump = true;	
		allow_movement = true;	
	}},
});

state.add("climbe", {
	on_start: function(player) { with player {
		allow_movement = false;
		climbe = true;
	}},
	
	on_step: function(player) {with player {
		
		if(sensor.check_expanded(1, 0, sensor.is_collision_solid_right)) image_xscale=1;
		if(sensor.check_expanded(1, 0, sensor.is_collision_solid_left)) image_xscale=-1;
		if((image_xscale==1 && !sensor.check_expanded(1, 0, sensor.is_collision_solid_right)) ||
		(image_xscale==-1 && !sensor.check_expanded(1, 0, sensor.is_collision_solid_left))){
			state.change_to("climbeEx");
		}
		
		if (is_key_action_pressed){
			image_xscale *= -1;
			xsp = (3+abs(xsp)/2) * sign(image_xscale);
			state.change_to("jump"); //? == objPlayer->Step->60
		}
		ysp = 0.0;
		if (is_key_up && !sensor.is_collision_solid_top()) ysp -= climbe_spid;
		if (is_key_down && !ground) ysp += climbe_spid;
		if (ground) state.change_to("normal");
		show_debug_message("climbe");
	}},
	
	on_exit: function(player) { with player {
		allow_movement = true;
	}},
});

state.add("climbeEx", {
	on_start: function(player) { with player {
		allow_jump = false;
		allow_movement = false;
		time_climbeEx=40;
		y-=17;
		x+=19*sign(image_xscale);
	}},
	
	on_step: function(player) {with player {
		if(time_climbeEx<0)	state.change_to("normal");
		else time_climbeEx--;
	}},
	
	on_exit: function(player) { with player {
		allow_jump = true;
		allow_movement = true;
		climbe=false;
	}},
});

state.add("breathe", {
	on_start: function() {
		__timer = 20;
	},
	
	on_step: function(player) {
		if (__timer > 0)
			__timer--;
		else with player {
			state.change_to("normal");
		}
	},
});

}