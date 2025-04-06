

function PlayerStatePush() : BaseState() constructor {

	/// @param {Struct.Player} plr
	on_step = function(plr) { 

		var is_edge_left = plr.collider.check_expanded(
			1, 0, 
			plr.collider.is_collision_solid, 
			PlayerCollisionDetectorSensor.Left
		);
		var is_edge_right = plr.collider.check_expanded(
			1, 0, 
			plr.collider.is_collision_solid, 
			PlayerCollisionDetectorSensor.Right
		);

	    if ((is_edge_right && (!(plr.input_x() > 0) || plr.gsp < 0)) || 
		    (is_edge_left  && (!(plr.input_x() < 0) || plr.gsp > 0))
	    ) {
	    	plr.state_machine.change_to("normal");
	    }
    
		plr.xsp = 0;
		plr.gsp = 0;
    };
  
	/// @param {Struct.Player} plr
	on_animate = function(plr) {
		plr.animator.set("push");
	};
}