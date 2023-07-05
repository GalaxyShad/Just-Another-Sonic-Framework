
function ShieldFlame(_player) : ShieldUseable() constructor {
	__used		= false;
	__player	= _player;
	__use_animation_timer = 0;
	
	play_pickup_sound = function() {
		audio_play_sound(sndFireShield, 0, 0);
	};
	
	
	use_ability = function() {
		audio_play_sound(sndFireDash, 0, false);
					
		with __player {
			ysp = 0;
			xsp = 8 * sign(image_xscale);
				
			camera.set_lag_timer(15);
		}
		
		__used = true;
		
		__use_animation_timer = 20;
	};
	
	
	is_ability_used = function() {
		return __used;
	};
	
	
	reset_ability = function() {
		__used = false;
	};
	
	
	draw = function(x, y) {
		if (__use_animation_timer > 0)
			__use_animation_timer--;
		
		draw_sprite_ext(
			(__used && __player.xsp != 0 && __use_animation_timer) ? sprFireShieldActive : sprFireShield, 
			global.tick, 
			x, y, 
			(__used && __player.xsp != 0) ? sign(__player.xsp) : 1, 1,
			0, c_white, 1
		);
	};
};