
function PlayerStateSpring() : BaseState() constructor {
	on_start = function(player) {
		player.animator.set("spring");
	};
	
	on_animate = function(player) { with player {
		if (ysp <= 0)	{
			animator.set_image_speed(0.125 + abs(ysp) / 10);
			animator.set("spring");
		} else {
			animator.set_image_speed(0.25);
			animator.set("walking");
		}
	}};
}