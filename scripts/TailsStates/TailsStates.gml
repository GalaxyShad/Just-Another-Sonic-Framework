
function TailsStateJump() : PlayerStateJump() constructor {	
	override_on_step = function(player) { super(); with (player) {
		if (is_key_action_pressed) {
			state.change_to("fly");
		}
	}};
}

function TailsStateFly() : BaseState() constructor {
	#macro FLY_GRAVITY_FORCE 0.03125
	on_start = function(player) {with (player) {
		behavior_loop.disable(player_behavior_apply_gravity);
		__time_fly=0;
		__fly_action=false;
	}};
	
	on_step = function(player) {with player {
		
		if(__fly_action) ysp-=0.125;
		else ysp+=FLY_GRAVITY_FORCE;
		
		
		if (ysp > 4) ysp = 4;
		if (__time_fly < 480){
			if(is_key_action_pressed) __fly_action=true;
		}
		else state.change_to("fly_tired");
		if(ysp<-1) __fly_action=false;
		__time_fly++;
	}};
	
	on_animate = function(player) {with player {
		if (!physics.is_underwater()) animator.set("fly");
		else animator.set("swim");
	}};
	
	on_landing = function(player) {with player {
		state.change_to("normal");
	}};
	
	on_exit = function(player) {with (player) {
		behavior_loop.enable(player_behavior_apply_gravity);
	}};
}

function TailsStateFlyTired() : BaseState() constructor {
	on_start = function(player) {with (player) {
		behavior_loop.disable(player_behavior_apply_gravity);
	}};
	
	on_step = function(player) {with player {
		ysp+=0.125;
		if (ysp > 4) ysp = 4;
	}};
	
	on_animate = function(player) {with player {
		if (!physics.is_underwater()) animator.set("fly_tired");
		else animator.set("swim_tired");
	}};
	
	on_landing = function(player) {with player {
		state.change_to("normal");
	}};
	
	on_exit = function(player) {with (player) {
		behavior_loop.enable(player_behavior_apply_gravity);
	}};
}

