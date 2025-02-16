fade_timer = 60;

timer = 120;

depth = -10000;

gui_center_x = display_get_gui_width()  / 2;
gui_center_y = display_get_gui_height() / 2;

padding_horizontal = 256;

rect = {
    x: gui_center_x - padding_horizontal, y: 0,
    w: 192,  h: 0,

    h_max: 600
};

text = {
    x: display_get_gui_width(),
    y: gui_center_y + 64,
    msg: room_get_name(room)
}

state_appear = function() {
    rect.h = lerp(rect.h, rect.h_max, 0.2);
    text.x = lerp(text.x, gui_center_x + padding_horizontal, 0.1);

    timer--;
    if (timer == 0) {
        state = state_move_away;
    }
}

state_move_away = function() {
    rect.h = lerp(rect.h, 0, 0.4);

    text.x = lerp(text.x, display_get_gui_width() * 2, 0.2);

    if (rect.h == 0) {
        instance_destroy();
    }
}

state = state_appear;