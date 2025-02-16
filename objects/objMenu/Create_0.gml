pos = 0;

instance_deactivate_all(true);

room_id = real(room);

main_menu_list = [
    {
        label: "Room",
        display_label: function(inst) {
            return "Goto room: " + room_get_name(inst.room_id); 
        },
        action_left: function(inst) {
            inst.room_id--;
            
            if (!room_exists(inst.room_id)) inst.room_id++;
        },
        action_right: function(inst) {
            inst.room_id++;
            
            if (!room_exists(inst.room_id)) inst.room_id--;
        },
        action: function(inst) { 
            instance_create_depth(0, 0, -1000, objFadeIn, {
                speed: 0.25,
                is_fade_in: false,
                on_finish: [inst, function(ctx) { room_goto(ctx.room_id) }]
            })
        }
    },
    {
        label: "Volume",
        display_label: function() {
            return "Volume " + string(floor(audio_get_master_gain(0) * 100)) + "%"; 
        },
        action_left: function() {
            var v = audio_get_master_gain(0) - 0.05;
            if (v < 0) v = 0;
            audio_set_master_gain(0, v);
        },
        action_right: function() {
            var v = audio_get_master_gain(0) + 0.05;
            if (v > 1) v = 1;
            audio_set_master_gain(0, v);
        }
    },
    {
        label: "Resolution",
        display_label: function() {
            var is_full_scr = window_get_fullscreen();
            
            return is_full_scr 
                ? "Full Screen" 
                : "Windowed";
        },
        action_left: function() {
            window_set_fullscreen(!window_get_fullscreen());
        },
        action_right: function() {
            window_set_fullscreen(!window_get_fullscreen());
        }
    },
    undefined,
    {
        label: "Close",
        action: function(inst) { 
            instance_activate_all();
            instance_destroy(inst);  
        }
    }
];

items_list = main_menu_list;

