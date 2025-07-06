if (keyboard_check_pressed(vk_up)) {
    menu.go_front();
}

if (keyboard_check_pressed(vk_down)) {
    menu.go_back();
}

if (keyboard_check_pressed(vk_left)) {
    menu.go_side_back();
}

if (keyboard_check_pressed(vk_right)) {
    menu.go_side_front();
}

if (keyboard_check_pressed(vk_enter)) {
    menu.select();
}