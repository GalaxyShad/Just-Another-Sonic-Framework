
function SonicStateJump() : PlayerStateJump() constructor {
	/// @param {Struct.Player} plr
	__use_shield = function(plr) { 
		if (!is_instanceof(plr.inst.shield, ShieldUseable)) return;
		
		if (plr.inst.shield.is_ability_used()) return;
		
		plr.inst.shield.use_ability(plr.inst);
	};
	
	/// @param {Struct.Player} plr
	override_on_step = function(plr) { 
		super(); 
		if (!plr.is_input_jump())
			return;
		
		if (!is_instanceof(plr.inst.shield, ShieldUseable) || plr.inst.timer_powerup_invincibility.is_ticking()) {
			plr.state_machine.change_to("dropdash");
		} else if (!plr.physics.is_super())  {
			other.__use_shield(self);
		}
	};
	
	/// @param {Struct.Player} plr
	override_on_landing = function(plr) {
		if (is_instanceof(plr.inst.shield, ShieldUseable)) {			
			if (is_instanceof(plr.inst.shield, ShieldBubble) && plr.inst.shield.is_ability_used()) {
				plr.inst.shield.bounce(self);
				plr.inst.shield.reset_ability();
				return;	
			}
		
			plr.inst.shield.reset_ability();
		}

		super();
	};
}


function SonicStateLookUp() : PlayerStateLookUp() constructor {
	/// @param {Struct.Player} plr
	override_on_start = function(plr) { 
		super(); 
		plr.behavior_loop.disable(player_behavior_jump);
	};
	
	/// @param {Struct.Player} plr
	override_on_exit = function(plr) { 
		super(); 
		plr.behavior_loop.enable(player_behavior_jump);
	};
	
	/// @param {Struct.Player} plr
	override_on_step = function(plr) { 
		super(); 
		
		if (plr.ground && plr.is_input_jump_pressed())
			plr.state_machine.change_to("peelout");
	};
}


function SonicStateDropDash() : BaseState() constructor {
	#macro DROPDASH_SPEED			8
	#macro DROPDASH_SPEED_SUPER		12
	#macro DROPDASH_MAX				12
	#macro DROPDASH_MAX_SUPER		13
	
	__drop_timer = 0;
	
	/// @param {Struct.Player} plr
	on_start = function(plr) {
		__drop_timer = 0;
		
		audio_play_sound(sndPlrDropDash, 0, false);
		
		plr.animator.set("dropdash");
	};
		
	/// @param {Struct.Player} plr
	on_landing = function(plr) {
		if (__drop_timer < 20) {
			plr.state_machine.change_to("normal");
			return;
		}
		
		plr.state_machine.change_to("roll");
		audio_play_sound(sndPlrSpindashRelease, 0, false);
		
		var _drpspd = plr.physics.is_super() ? DROPDASH_SPEED_SUPER : DROPDASH_SPEED;
		var _drpmax = plr.physics.is_super() ? DROPDASH_MAX_SUPER : DROPDASH_MAX;
		
		if (sign(plr.inst.image_xscale) == sign(plr.xsp))
			plr.gsp = (plr.gsp / 4) + (_drpspd * sign(plr.inst.image_xscale));
		else 
			plr.gsp = ((plr.collider.get_angle_data().degrees == 0) ? 
				0 : 
				(plr.gsp / 2)) + (_drpspd * sign(plr.inst.image_xscale));
				
		if (abs(plr.gsp) > _drpmax) 
			plr.gsp = _drpmax * sign(plr.gsp);
				
		plr.inst.camera.set_lag_timer(15);
		
		instance_create_depth(
			plr.inst.x, 
			plr.inst.y + plr.collider.get_radius().floor.height, 
			plr.inst.depth-1, objSfxDropdashDust
		).image_xscale = plr.inst.image_xscale;
	};
	
	/// @param {Struct.Player} plr
	on_step = function(plr) {
		if (!plr.is_input_jump())
			plr.state_machine.change_to("jump");
			
		__drop_timer++;
	};
}

function SonicStatePeelout() : BaseState() constructor {
	__timer = 0;

	/// @param {Struct.Player} plr
	on_start = function(plr) { 
		audio_play_sound(sndPlrPeelCharge, 0, false);
		__timer = 0;
	
		plr.behavior_loop.disable(player_behavior_jump);
		plr.behavior_loop.disable(player_behavior_ground_movement);
	};

	/// @param {Struct.Player} plr
	on_exit = function(plr) {
		plr.behavior_loop.enable(player_behavior_jump);
		plr.behavior_loop.enable(player_behavior_ground_movement);
	};

	/// @param {Struct.Player} plr
	on_step = function(plr) { 
		if (!(plr.input_y() < 0)) {
			if (__timer >= 30) {
				plr.gsp = 12 * plr.inst.image_xscale;
		
				audio_stop_sound(sndPlrPeelCharge);
				audio_play_sound(sndPlrPeelRelease, 0, false);
		
				plr.inst.camera.set_lag_timer(15);
			} else {
				__timer = 0;		
			}
	
			plr.state_machine.change_to("normal");
		}
			
		__timer++;
		if __timer > 30
			__timer = 30;
	};
	
	/// @param {Struct.Player} plr
	on_animate = function(plr) { 
		plr.animator.set_image_speed(0.25 + __timer / 25);
		
		if (__timer < 15)
			plr.animator.set("walking");
		else if (__timer < 30)
			plr.animator.set("running");
		else
			plr.animator.set("dash");
	};	
}