

function ShieldLightning() : ShieldUseable() constructor {
	__used = false;
	
	play_pickup_sound = function() {
		audio_play_sound(sndLightningShield, 0, 0);
	};
	
	use_ability = function(player) {
		audio_play_sound(sndLightningJump, 0, false);
					
		with player {
			plr.ysp = -5.5;
					
			var _particle = part_system_create(ParticleSystem1);
			part_system_depth(_particle, -1000);
			part_system_position(_particle, x, y);
		}
		
		__used = true;
	};
	
	is_ability_used = function() {
		return __used;
	};
	
	reset_ability = function() {
		__used = false;
	};
	
	draw = function(x, y) {
		draw_sprite(sprElectricShield, global.tick / 3, x, y);
	};
};
