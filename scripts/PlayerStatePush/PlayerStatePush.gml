

function PlayerStatePush() : BaseState() constructor {
	on_step = function(player) { with player {

		var is_edge_left = collision_detector.check_expanded(
			1, 0, 
			collision_detector.is_collision_solid, 
			PlayerCollisionDetectorSensor.Left
		);
		var is_edge_right = collision_detector.check_expanded(
			1, 0, 
			collision_detector.is_collision_solid, 
			PlayerCollisionDetectorSensor.Right
		);

	    if ((is_edge_right && (!is_key_right || plr.gsp < 0)) || 
		    (is_edge_left  && (!is_key_left  || plr.gsp > 0))
	    ) {
	    	state.change_to("normal");
	    }
    
		plr.xsp = 0;
		plr.gsp = 0;
    }};
  
	on_animate = function(player) { with player {
	animator.set("push");
	}};
}