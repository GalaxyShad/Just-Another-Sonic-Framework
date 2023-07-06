

function PlayerStateBalancing() : BaseState() constructor {
	on_start = function(player) { with player {
		if ((image_xscale == 1  && sensor.is_collision_ground_left_edge()) || 
			(image_xscale == -1 && sensor.is_collision_ground_right_edge())
		)
			animator.set("balancing_a");
		else
			animator.set("balancing_b");
	}};
	
	on_step = function(player) { with player {
		if (gsp != 0 || !ground)
			state.change_to("normal");
	}};
}