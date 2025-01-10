

function PlayerStateBalancing() : BaseState() constructor {
	on_start = function(player) { with player {
		if ((image_xscale == 1  && collision_detector.is_collision_solid(PlayerCollisionDetectorSensor.EdgeLeft)) || 
			(image_xscale == -1 && collision_detector.is_collision_solid(PlayerCollisionDetectorSensor.EdgeRight))
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