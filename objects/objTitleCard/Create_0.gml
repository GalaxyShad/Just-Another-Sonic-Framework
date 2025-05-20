fade_timer = 60;

timer = 120;

depth = -10000000000000000000;

scr_x = 0;
scr_y = 0;
scr_w = 428;
scr_h = 240;

zone_info = parse_room_name_to_level_info(room);

act_number = zone_info.act_number;

zonename_text = {
    START_X: scr_x - 200,
    MAIN_X:  scr_x + 96,
    END_X:   scr_x + scr_w + 200,

    MAIN_Y: scr_y + 64,
    
    TEXT: string_upper(zone_info.zone_name),

    x: 0,
    y: 0,
}

zone_text = {
    START_X:    zonename_text.END_X,
    MAIN_X:     scr_x + 128,
    END_X:      zonename_text.START_X,

    MAIN_Y: zonename_text.MAIN_Y + 24,

    TEXT: "ZONE",

    x: 0,
    y: 0,
}

framework_text = {
    START_Y:    scr_y + scr_h + 16,
    MAIN_Y:     scr_y + scr_h - 24,
    END_Y:      scr_y + scr_h + 16,

    TEXT: "JUST ANOTHER SONIC FRAMEWORK",

    x: scr_w / 2,
    y: 0,
}

zonename_text.x = zonename_text.START_X;
zonename_text.y = zonename_text.MAIN_Y;

zone_text.x = zone_text.START_X;
zone_text.y = zone_text.MAIN_Y;

framework_text.y = framework_text.START_Y;

state_appear = function() {
    zonename_text.x = lerp(zonename_text.x, zonename_text.MAIN_X, 0.1);
    zone_text.x = lerp(zone_text.x, zone_text.MAIN_X, 0.1);
    framework_text.y = lerp(framework_text.y, framework_text.MAIN_Y, 0.1);

    line_offset_x = lerp(line_offset_x, 152, 0.2);

    timer--;
    if (timer == 0) {
        state = state_move_away;
    }
}

state_move_away = function() {
    zonename_text.x = lerp(zonename_text.x, zonename_text.END_X, 0.1);
    zone_text.x = lerp(zone_text.x, zone_text.END_X, 0.1);
    framework_text.y = lerp(framework_text.y, framework_text.END_Y, 0.1);

    line_offset_x = lerp(line_offset_x, 250, 0.1);

    if (round(framework_text.y) == round(framework_text.END_Y)) {
         instance_destroy();
    }
}

state = state_appear;

line_y = 0;
line_offset_x = 1000;

title_card_surface = -1;