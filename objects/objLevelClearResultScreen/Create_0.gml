depth = -100000;

audio_play_sound(sndLevelClear, 0, false);

x = camera_get_view_x(camera_get_active());
y = camera_get_view_y(camera_get_active());

act_sprite_index = 0;

outof_scr_width = 400;

next_scene = NextRoom;

calculate_time_bonus = function() {
    var _seconds = global.tick / 100;

    // Sonic 2 method

    if (_seconds < 30) {
        return 50000;
    } else if (_seconds < 45) {
        return 10000;
    } else if (_seconds < 60) {
        return 5000;
    } else if (_seconds < 90) {
        return 4000;
    } else if (_seconds < 120) {
        return 3000;
    } else if (_seconds < 180) {
        return 2000;
    } else if (_seconds < 240) {
        return 1000;
    } else if (_seconds < 300) {
        return 500;
    } else {
        return 0;
    }
}

ui_plr_got = {
    x: -outof_scr_width,
    y: -64,
    dst_x: -100,
    text_plr: string_upper(player.name),
    text_plr_color: player.name_color,
    text: " GOT",
}

ui_through = {
    x: +outof_scr_width,
    y: -64 + 20,
    dst_x: -80,
    text: "THROUGH",
}


ui_time_bonus_text = {
    x: -outof_scr_width-200*0,
    y: 0,
    dst_x: -100,
    text: "TIME BONUS",
    value: calculate_time_bonus(),
};

ui_ring_bonus_text = {
    x: -outof_scr_width-200*1,
    y: 16,
    dst_x: -100,
    text: "RING BONUS",
    value: global.rings * 100
};

ui_total_bonus_text = {
    x: -outof_scr_width-200*2,
    y: 48,
    dst_x: -80,
    text: "TOTAL",
    value: 0
};

ui_arr_texts = [ui_time_bonus_text, ui_ring_bonus_text, ui_total_bonus_text];

decrement_step          = 100;
time_to_start_counting  = 180;
counting_delay          = 6;
go_to_next_level_delay  = 180

alarm[0] = time_to_start_counting; // time to start counting