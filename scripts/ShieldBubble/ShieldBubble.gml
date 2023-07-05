
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
		with __player player_underwater_regain_air();
	}();
	
	play_pickup_sound = function() {
		audio_play_sound(sndBubbleShield, 0, 0);
	};
	
	use_ability = function(player) {
		audio_play_sound(sndBubbleBounce, 0, false);
					
		__scale.target_xscale = 0.5;
		__scale.target_yscale = 1.5;
					
		player.xsp = 0;
		player.ysp = 8;
		
		__used = true;
	};
	
	bounce = function(player) { 
		with player {
			var _angle = sensor.get_angle();
			
			while (sensor.is_collision_solid_bottom()) {
				x -= dsin(_angle);
				y -= dcos(_angle);
				
				sensor.set_position(x, y);
			}
			
			xsp -= BOUNCE_FORCE * dsin(_angle);
			ysp -= BOUNCE_FORCE * dcos(_angle);
			
			ground = false;
		}
			
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