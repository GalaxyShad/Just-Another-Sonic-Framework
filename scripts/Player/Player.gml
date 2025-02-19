
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

    pallete = {
        base_color_list: [],
        super_form_color_list: [],

        sfx_color: 		 #0F52BA,
        sfx_color_super: #FFCE57,
    }

    collider 		= _collider
    state_machine 	= _state_machine

    animator 		= _animator

    physics 		= _physics
};

