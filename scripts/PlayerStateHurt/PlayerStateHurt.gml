


function PlayerStateHurt() : BaseState() constructor {
	on_start = function(player) {with (player) {
		allow_movement = false;		
		
		xsp = -2 * sign(image_xscale);
		ysp = -4;
		
		if (physics.is_underwater()) {
			xsp /= 2;
			ysp /= 2;
		}
		
		animator.set("hurt");
	}};
	
	on_exit = function(player) {with (player) {
		allow_movement = true;			
	}};
	
	on_landing = function(player) {with (player) {
		timer_invincibility.reset_and_start();
		
		state.change_to("normal");
		
		gsp = 0;
		xsp = 0;
	}};
}