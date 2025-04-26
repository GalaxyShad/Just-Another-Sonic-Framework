
function CharacterBuilder(_instance) constructor {
    __instance = _instance;
    
    __animator = new PlayerAnimator();
    __animator.set("normal");

    __state_machine = new State(__instance);
    add_basic_player_states(__state_machine);

    __collider = new PlayerCollisionDetector(__instance);

    __custom_physics_props = undefined;
    __custom_super_physics_props = undefined;

    __draw_behind_function = undefined;

    __name = "no name";
    __name_color = c_gray;

    __sign_post_sprite = sprSignPostUnknown;

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

    __behavior_loop = new PlayerLoop();
	__behavior_loop
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

	__handle_loop = new PlayerLoop();
	__handle_loop
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

	__visual_loop = new PlayerLoop();
	__visual_loop
		.add(player_behavior_visual_angle)
		.add(player_behavior_visual_flip)
		.add(player_behavior_visual_create_afterimage)
	;

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

    configure_physics = function(_phys) {
        __custom_physics_props = _phys;
        return self;
    }

    configure_physics_super = function(_phys) {
        __custom_super_physics_props = _phys;
        return self;
    }

    configure_behavior_loop = function(_loop_cfg_func) {
        _loop_cfg_func(__behavior_loop);
        return self;
    }

    configure_handle_loop = function(_loop_cfg_func) {
        _loop_cfg_func(__handle_loop);
        return self;
    }

    configure_visual_loop = function(_loop_cfg_func) {
        _loop_cfg_func(__visual_loop);
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

    on_draw_behind = function(draw_behind_function) {
        __draw_behind_function = draw_behind_function;
        return self;
    }

    set_name = function(name) {
        __name = name;
        return self;
    }

    set_name_color = function(color) {
        __name_color = color;
        return self;
    }

    set_sign_post_sprite = function(sprite) {
        __sign_post_sprite = sprite;
        return self;
    }

    build = function() {
        var _physics = new PlayerPhysics(__custom_physics_props, __custom_super_physics_props);

        var _p = new Player(
            __instance,
            __collider,
            __state_machine,
            __animator,
            _physics,
            __behavior_loop,
            __handle_loop,
            __visual_loop
        );

        _p.draw_behind = __draw_behind_function;

        _p.palette.sfx_color = __palette.vfx_color;
        _p.palette.sfx_color_super = __palette.vfx_color_super;

        _p.palette.base_color_list = __palette.base_color_list;
        _p.palette.super_form_color_list = __palette.super_form_color_list;

        _p.collider_radius.base = __collider_radius.base;
        _p.collider_radius.curling = __collider_radius.curling;

        _p.name = __name;
        _p.name_color = __name_color;

        _p.sign_post_sprite = __sign_post_sprite;
 
        return _p;
    }
    
}
