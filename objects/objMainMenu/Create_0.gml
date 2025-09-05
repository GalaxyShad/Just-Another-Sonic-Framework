main_menu = [
    {
        name: "play",
        on_select: function(inst) {
            inst.menu.change_items(inst.character_select);
        },
    },
    {
        name: "options",
        on_select: function(inst) {
            inst.menu.change_items(inst.options);
        }
    },
    {
        name: "quit",
        on_select: function() {
            game_end();
        }
    }
];

options = [
    {
        computed_name: function() {
            return "< Volume " + string(audio_get_master_gain(0)) + " >";
        },
        on_side_front: function() {
            var _v = audio_get_master_gain(0) + 0.05;
            if (_v > 1.00) _v = 1.00;
            audio_set_master_gain(0, _v);
        },
        on_side_back: function() {
            var _v = audio_get_master_gain(0) - 0.05;
            if (_v < 0.00) _v = 0.00;
            audio_set_master_gain(0, _v);
        }
    },
    {
        name: "back",
        on_select: function(inst) {
            inst.menu.change_items(inst.main_menu);
        }
    }
];

character_select = [
    {
        name: "Sonic",
        on_select: function() {
            global.player = objCharacterSonic;
            room_goto(rm_test);
        }
    }, 
    {
        name: "Tails",
        on_select: function() {
            global.player = objCharacterTails;
            room_goto(rm_test);
        }
    }, 
    {
        name: "Kunckles",
        on_select: function() {
            global.player = objCharacterKnuckles;
            room_goto(rm_test);
        }
    }, 
    {
        name: "back",
        on_select: function(inst) {
            inst.menu.change_items(inst.main_menu);
        }
    }, 
]

menu = new Menu(self, main_menu);

