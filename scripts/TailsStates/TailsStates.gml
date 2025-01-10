
function TailsStateJump() : PlayerStateJump() constructor {	
	override_on_step = function(player) { super(); with (player) {
		if (is_key_action_pressed) {
			state.change_to("fly");
		}
	}};
}

function TailsStateFly() : BaseState() constructor {
	#macro FLY_GRAVITY_FORCE	0.03125
	#macro FLY_FLYING_FORCE		0.125
	
	on_start = function(player) {with (player) {
		behavior_loop.disable(player_behavior_apply_gravity);
		__tired			= false;
		__time_fly		= 0;
		__fly_action	= false;
	}};
	
	on_step = function(player) {with player {
		if(__fly_action && !collision_detector.is_collision_solid(PlayerCollisionDetectorSensor.Top)) 
			ysp -= FLY_FLYING_FORCE;
		else 
			ysp += FLY_GRAVITY_FORCE;
			
		if (__time_fly > 480) 
			__tired = true;
			
		if(!__tired) {
			if (is_key_action_pressed && ysp != 1) 
				__fly_action = true;
		}
		
		if (ysp < -1 || __tired) 
			__fly_action = false;
		
		__time_fly++;
	}};
	
	on_animate = function(player) {with player {
		if (__tired) {
			if (!physics.is_underwater()) animator.set("fly_tired");
			else						  animator.set("swim_tired");
		} else {
			if (!physics.is_underwater()) animator.set("fly");
			else						  animator.set("swim");
		}
	}};
	
	on_landing = function(player) {with player {
		state.change_to("normal");
	}};
	
	on_exit = function(player) {with (player) {
		behavior_loop.enable(player_behavior_apply_gravity);
	}};
}
