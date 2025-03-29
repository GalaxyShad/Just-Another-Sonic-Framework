
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

    input_x = function() {
        if (keyboard_check(vk_left) && keyboard_check(vk_right)) return 0;

        if (keyboard_check(vk_left)) return -1;
        else if (keyboard_check(vk_right)) return 1;
    }

    input_y = function() {
        if (keyboard_check(vk_up) && keyboard_check(vk_down)) return 0;

        if (keyboard_check(vk_up)) return -1;
        else if (keyboard_check(vk_down)) return 1;
    }

    is_input_jump = function() {
        return keyboard_check(ord("Z"));
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
};

function CharacterBuilder(_instance) constructor {
    __instance = _instance;
    
    __animator = new PlayerAnimator();
    __animator.set("normal");

    __state_machine = new State(__instance);
    add_basic_player_states(__state_machine);

    __collider = new PlayerCollisionDetector(__instance);
    __physics = new PlayerPhysics();

    __collider_radius = {
        base: {
            vertical: 20,
            horizontal: 8,
        },

        curling: {
            vertical: 15,
            horizontal: 7
        }
    };

    __palette = {
        base_color_list: [],
        super_form_color_list: [],

        vfx_color: 		 #AAAAAA,
        vfx_color_super: #FFFFFF,
    }

    ///////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////

    configure_animations = function(animator_func) {
        animator_func(__animator);
        return self;
    }

    configure_states = function(state_func) {
        state_func(__state_machine);
        return self;
    }

    on_jump_pressed_when_jump = function(on_enter) {

    }

    set_base_collision_radius = function(horizontal, vertical) {
        __collider_radius.base = {
            vertical: vertical,
            horizontal: horizontal
        };
        return self;
    }

    set_curling_collision_radius = function(horizontal, vertical) {
        __collider_radius.curling = {
            vertical: vertical,
            horizontal: horizontal
        };
        return self;
    }

    set_vfx_color = function(col) {
        __palette.vfx_color = col;
        return self;
    }

    set_vfx_super_color = function(col) {
        __palette.vfx_color_super = col;
        return self;
    }

    set_base_palette = function(pal) {
        array_copy(__palette.base_color_list, 0, pal, 0, array_length(pal));
        return self;
    }

    add_super_palette_fading_colors = function(color_row) {
        var _a = [];
        array_copy(_a, 0, color_row, 0, array_length(color_row));
        array_push(__palette.super_form_color_list, _a);
        return self
    }

    build = function() {
        var _p = new Player(
            __instance,
            __collider,
            __state_machine,
            __animator,
            __physics
        );

        _p.palette.sfx_color = __palette.vfx_color;
        _p.palette.sfx_color_super = __palette.vfx_color_super;

        _p.palette.base_color_list = __palette.base_color_list;
        _p.palette.super_form_color_list = __palette.super_form_color_list;

        _p.collider_radius.base = _p.collider_radius.base;
        _p.collider_radius.curling = _p.collider_radius.curling;
 
        return _p;
    }
    
}
