
/// @param {Id.Instance} 					_inst 
/// @param {Struct.PlayerCollisionDetector} _collider 
/// @param {Struct.State} 					_state_machine 
/// @param {Struct.PlayerAnimator} 			_animator 
/// @param {Struct.PlayerPhysics} 			_physics 
function Player(
    _inst,
    _collider, 
    _state_machine,
    _animator,
    _physics
) constructor {
    inst = _inst;

    xsp = 0;
    ysp = 0;
    gsp = 0;

    ground = false;

    animation_angle = 0;

    bounced_chain_count = 0;

    collider_radius = {
        base: {
            vertical: 20,
            horizontal: 8,
        },

        curling: {
            vertical: 15,
            horizontal: 7
        }
    };

    palette = {
        base_color_list: [],
        super_form_color_list: [],

        sfx_color: 		 #0F52BA,
        sfx_color_super: #FFCE57,
    }

    collider 		= _collider
    state_machine 	= _state_machine

    animator 		= _animator

    physics 		= _physics

    draw_behind = undefined;

    input_x = function() {
        if (keyboard_check(vk_left) && keyboard_check(vk_right)) return 0;

        if      (keyboard_check(vk_left))   return -1;
        else if (keyboard_check(vk_right))  return 1;

        return 0;
    }

    input_y = function() {
        if (keyboard_check(vk_up) && keyboard_check(vk_down)) return 0;

        if      (keyboard_check(vk_up))     return -1;
        else if (keyboard_check(vk_down))   return 1;

        return 0;
    }

    is_input_jump = function() {
        return keyboard_check(ord("Z"));
    }

    is_input_jump_pressed = function() {
        return keyboard_check_pressed(ord("Z"));
    }

    is_can_break_monitor = function() {
        return state_machine.is_one_of([
            "jump",
            "roll",
            "dropdash",
            "glide",
            "glideRotation",
            "land"
        ]);
    }

    is_can_destroy_enemy = function() {
        return state_machine.is_one_of([
            "jump",
            "roll",
            "dropdash",
            "glide",
            "glideRotation",
            "land"
        ]) 
        || inst.timer_invincibility.is_ticking()
        || physics.is_super()
    }
	
	
	behavior_loop = new PlayerLoop();
	behavior_loop
		.add(player_switch_sensor_radius)

		.add(player_behavior_apply_speed)

		// Handle monitors before solid collision
		.add(player_handle_monitors)
	
		// Collisions
		.add(player_behavior_collisions_solid)
	
		// Air 
		.add(player_behavior_apply_gravity)
		.add(player_behavior_air_movement)
		.add(player_behavior_air_drag)
		.add(player_behavior_jump)

		// Ground
		.add(player_behavior_slope_decceleration)
		.add(player_behavior_ground_movement)
		.add(player_behavior_ground_friction)
		.add(player_behavior_fall_off_slopes)
	;

	handle_loop = new PlayerLoop();
	handle_loop
		.add(player_handle_layers)
		.add(player_handle_rings)
		.add(player_handle_springs)
		.add(player_handle_spikes)
	
		.add(player_handle_moving_platforms)
		.add(player_handle_water)
		.add(player_handle_bubbles)
		.add(player_handle_enemy)
		.add(player_handle_corksew)
		.add(player_handle_projectile)
	;

	visual_loop = new PlayerLoop();
	visual_loop
		.add(player_behavior_visual_angle)
		.add(player_behavior_visual_flip)
		.add(player_behavior_visual_create_afterimage)
	;
};
