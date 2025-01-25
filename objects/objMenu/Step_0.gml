var selected_item = items_list[pos];

if (keyboard_check_pressed(vk_up)) {
    pos--
    if (pos >= 0 && items_list[pos] == undefined) pos--;
    // audio_play_sound(sndMmMove, 0, false);
}
else if (keyboard_check_pressed(vk_down)) {
    pos++;
    if (pos < array_length_1d(items_list) && items_list[pos] == undefined) pos++;
    // audio_play_sound(sndMmMove, 0, false);
}

if (pos) < 0 pos = array_length_1d(items_list)-1;
if (pos >= array_length_1d(items_list)) pos = 0;


if (selected_item[$ "action_left"] != undefined && keyboard_check_pressed(vk_left) && !selected_item[$ "disabled"]) {
    selected_item.action_left(self);
}

if (selected_item[$ "action_right"] != undefined && keyboard_check_pressed(vk_right) && !selected_item[$ "disabled"]) {
    selected_item.action_right(self);
}

if (selected_item[$ "action"] != undefined && keyboard_check_pressed(vk_enter) && !selected_item[$ "disabled"]) {
    // audio_play_sound(sndMmSelect, 0, false);
    selected_item.action(self);
}




