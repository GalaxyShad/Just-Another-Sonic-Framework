

function PlayerStatePush() : BaseState() constructor {
	on_step = function(player) { with player {
    if ((sensor.check_expanded(1, 0, sensor.is_collision_solid_right) && (!is_key_right || gsp < 0)) || 
		(sensor.check_expanded(1, 0, sensor.is_collision_solid_left)  && (!is_key_left  || gsp > 0))
		) {
			state.change_to("normal");
		}
    
		xsp = 0;
		gsp = 0;
	  }};
	
	on_animate = function(player) { with player {
		animator.set("push");
	}};
}