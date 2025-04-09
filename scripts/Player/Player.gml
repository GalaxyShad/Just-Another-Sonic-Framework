
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
};
