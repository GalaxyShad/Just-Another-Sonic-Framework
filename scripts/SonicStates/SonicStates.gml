
function SonicStateJump() : PlayerStateJump() constructor {
	__use_shield = function(player) { with player {
		if (!is_instanceof(shield, ShieldUseable)) return;
		
		if (shield.is_ability_used()) return;
		
		shield.use_ability(player);
	}};
	
	
	override_on_step = function(player) { super(); with (player) {
		if (!is_key_action_pressed)
			return;
		
		if (!is_instanceof(shield, ShieldUseable) || timer_powerup_invincibility.is_ticking()) {
			state.change_to("dropdash");
		} else if (!physics.is_super())  {
			other.__use_shield(self);
		}
	}};
	
	
	override_on_landing = function(player) {
		with player {		
			if (is_instanceof(shield, ShieldUseable)) {			
				if (is_instanceof(shield, ShieldBubble) && shield.is_ability_used()) {
					shield.bounce(self);
					shield.reset_ability();
					return;	
				}
			
				shield.reset_ability();
			}
		}
		
		super();
	};
}


function SonicStateLookUp() : PlayerStateLookUp() constructor {
	override_on_start = function(player) { super(); with player {
		allow_jump = false;	
	}};
	
	override_on_exit = function(player) { super(); with player {
		allow_jump = true;	
	}};
	
	override_on_step = function(player) { super(); with (player) {
		if (ground && is_key_action)
			state.change_to("peelout");
	}};
}


function SonicStateDropDash() : BaseState() constructor {
	#macro DROPDASH_SPEED			8
	#macro DROPDASH_SPEED_SUPER		12
	#macro DROPDASH_MAX				12
	#macro DROPDASH_MAX_SUPER		13
	
	__drop_timer = 0;
	
	on_start = function(player) {
		__drop_timer = 0;
		
		audio_play_sound(sndPlrDropDash, 0, false);
		
		with player {
			animator.set("dropdash");
			//animator.set_image_speed(0.5 + abs(gsp) / 8.0);
		}
	};
		
	on_landing = function(player) {with player {
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
		
		instance_create_depth(
			x, 
			y + sensor.get_floor_box().vradius, 
			depth-1, objSfxDropdashDust
		).image_xscale = image_xscale;
		
	}};
	
	on_step = function(player) {with player {
		if (!is_key_action)
			state.change_to("jump");
			
		other.__drop_timer++;
	}};
}

function SonicStatePeelout() : BaseState() constructor {
	__timer = 0;
	
	on_start = function(player) { with player {
		audio_play_sound(sndPlrPeelCharge, 0, false);
		other.__timer = 0;
		allow_jump = false;	
		player.allow_movement = false;	
	}};
	
	on_exit = function(player) { with player {
		allow_jump = true;	
		allow_movement = true;	
	}};
	
	on_step = function(player) { 
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
	};
	
	on_animate = function(player) { with player {
		animator.set_image_speed(0.25 + other.__timer / 25);
		
		if (other.__timer < 15)
			animator.set("walking");
		else if (other.__timer < 30)
			animator.set("running");
		else
			animator.set("dash");
	}};	
}