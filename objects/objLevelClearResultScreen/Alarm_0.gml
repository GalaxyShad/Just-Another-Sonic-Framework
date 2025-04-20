var v = 0;

if (ui_time_bonus_text.value > 0) {
    v = min(decrement_step, ui_time_bonus_text.value);

    ui_time_bonus_text.value -= v;

    ui_total_bonus_text.value += v;
    score += v;
}

if (ui_ring_bonus_text.value > 0) {
    v = min(decrement_step, ui_ring_bonus_text.value);

    ui_ring_bonus_text.value -= v;

    ui_total_bonus_text.value += v;
    score += v;
}

audio_stop_sound(sndCashregister);
audio_play_sound(sndCashregister, 0, 0);

if (ui_ring_bonus_text.value == 0 && ui_time_bonus_text.value == 0) {
    alarm[1] = go_to_next_level_delay;
} else {
    alarm[0] = counting_delay;
}