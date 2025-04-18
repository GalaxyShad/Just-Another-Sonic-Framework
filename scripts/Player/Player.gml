
/// @param {Id.Instance} 					_inst 
/// @param {Struct.PlayerCollisionDetector} _collider 
/// @param {Struct.State} 					_state_machine 
/// @param {Struct.PlayerAnimator} 			_animator 
/// @param {Struct.PlayerPhysics} 			_physics 
/// @param {Struct.PlayerLoop} 			    _behavior_loop 
/// @param {Struct.PlayerLoop} 			    _handle_loop 
/// @param {Struct.PlayerLoop} 			    _visual_loop 
function Player(
    _inst,
    _collider, 
    _state_machine,
    _animator,
    _physics,

    _behavior_loop,
    _handle_loop,
    _visual_loop
) constructor {
    inst = _inst;

    xsp = 0;
    ysp = 0;
    gsp = 0;

    ground = false;

    animation_angle = 0;

    bounced_chain_count = 0;

    behavior_loop = _behavior_loop;
    handle_loop = _handle_loop;
    visual_loop = _visual_loop;

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
        return keyboard_check(ord("Z")) || keyboard_check(vk_numpad1);
    }

    is_input_jump_pressed = function() {
        return keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_numpad1);
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
        || timer_invincibility.is_ticking()
        || physics.is_super()
    }
	
    show_debug_info = true;
    
    o_dj = !instance_exists(objDJ) ?
    	instance_create_layer(inst.x, inst.y, inst.layer, objDJ) :
    	instance_find(objDJ, 0);
    	
    camera = !instance_exists(objCameraSonicWorlds) ?
    	instance_create_layer(inst.x, inst.y, inst.layer, objCameraSonicWorlds) :
    	instance_find(objCameraSonicWorlds, 0);
        
    remaining_air = 30;
    camera.FollowingObject = inst;
    shield = undefined;
    animation_angle = 0;
    
    delay_underwater_event		= 60
    duration_super_fast_shoes	= 21*60
    duration_control_lock		= 30
    duration_invincibility		= 120
    
    timer_invincibility = new Timer2(duration_invincibility, false);
    timer_powerup_invincibility = new Timer2(31 * 60, false);
    
    timer_underwater  = new Timer2(
    	delay_underwater_event, 
    	true, 
    	function() {  player_underwater_event(self); }
    );
    
    timer_speed_shoes = new Timer2(
    	duration_super_fast_shoes, 
    	false, 
    	function() { with self physics.cancel_super_fast_shoes(); }
    );
    
    timer_control_lock = new Timer2(
    	duration_control_lock,
    	false,
    	function() { }
    );
};
