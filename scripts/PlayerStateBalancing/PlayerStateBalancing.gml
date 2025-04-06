

function PlayerStateBalancing() : BaseState() constructor {
	/// @param {Struct.Player} plr
	on_start = function(plr) { 
		if ((plr.inst.image_xscale == 1  && plr.collider.is_collision_solid(PlayerCollisionDetectorSensor.EdgeLeft)) || 
			(plr.inst.image_xscale == -1 && plr.collider.is_collision_solid(PlayerCollisionDetectorSensor.EdgeRight))
		)
			plr.animator.set("balancing_a");
		else
			plr.animator.set("balancing_b");
	};
	
	/// @param {Struct.Player} plr
	on_step = function(plr) {
		if (plr.gsp != 0 || !plr.ground)
			plr.state_machine.change_to("normal");
	};
}