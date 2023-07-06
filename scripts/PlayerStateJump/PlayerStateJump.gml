function PlayerStateJump() : BaseState() constructor {
	__use_shield = function(player) { with player {
		if (!is_instanceof(shield, ShieldUseable)) return;
		
		if (shield.is_ability_used()) return;
		
		shield.use_ability(player);
	}};
	
	
	on_start = function(player) { with player {
		animator.set("curling");
	}};
	
	
	on_step = function(player) { with (player) {
		if (!is_key_action && ysp < physics.jump_release)
			ysp = physics.jump_release;
			
		if (is_key_action_pressed && !is_instanceof(shield, ShieldUseable)) {
			state.change_to("dropdash");
		}
		
		if (!ground && is_key_action_pressed)  {
			other.__use_shield(self);
		}
	}};
	
	
	on_landing = function(player) { with (player) {
		if (is_instanceof(shield, ShieldUseable)) {			
			if (is_instanceof(shield, ShieldBubble) && shield.is_ability_used()) {
				shield.bounce(self);
				shield.reset_ability();
				return;	
			}
			
			shield.reset_ability();
		}
			
		state.change_to("normal");	
	}};

	
	on_animate = function(player) { with player {
		animator.set_image_speed(0.5 + abs(gsp) / 8.0);
	}};
}