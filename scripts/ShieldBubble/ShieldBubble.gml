
function ShieldBubble(_player) : ShieldUseable() constructor {
	#macro BOUNCE_FORCE 7.5
	
	__player	= _player;
	__used		= false;
	
	__scale = {
		target_xscale: 1,
		target_yscale: 1,
	
		xscale: 1,
		yscale: 1
	};
	
	__init__ = function() {
		with __player player_underwater_regain_air(plr);
	}();
	
	play_pickup_sound = function() {
		audio_play_sound(sndBubbleShield, 0, 0);
	};
	
	use_ability = function(player) {
		audio_play_sound(sndBubbleBounce, 0, false);
					
		__scale.target_xscale = 0.5;
		__scale.target_yscale = 1.5;
					
		player.plr.xsp = 0;
		player.plr.ysp = 8;
		
		__used = true;
	};
	
	/// @param {Struct.Player} plr
	bounce = function(plr) {
		while (plr.collider.is_collision_solid(PlayerCollisionDetectorSensor.Bottom)) {
			x -= plr.collider.get_angle_data().sin;
			y -= plr.collider.get_angle_data().cos;
		}
			
		plr.xsp -= BOUNCE_FORCE * plr.collider.get_angle_data().sin;
		plr.ysp -= BOUNCE_FORCE * plr.collider.get_angle_data().cos;
			
		plr.ground = false;
			
		__scale.xscale = 2.0;
		__scale.yscale = 0.25;
			
		__scale.target_xscale = 1;
		__scale.target_yscale = 1;
		
		reset_ability();				
	};
	
	is_ability_used = function() {
		return __used;
	};
	
	reset_ability = function() {
		__used = false;
	};
	
	draw = function(x, y) {
		__scale.xscale = 
			lerp(__scale.xscale, __scale.target_xscale, 0.25);
		
		__scale.yscale = 
			lerp(__scale.yscale, __scale.target_yscale, 0.25);
	
		draw_sprite_ext(
			sprWaterShield, global.tick, 
			x, y, 
			__scale.xscale, __scale.yscale, 
			0, c_white, 1 
		);
	};
};