
function ShieldClassic() : BaseShield() constructor {
	play_pickup_sound = function() {
		audio_play_sound(sndBlueShield, 0, 0);
	};
	
	draw = function(x, y) {
		draw_sprite(sprShield, global.tick / 2, x, y);
	};
};
