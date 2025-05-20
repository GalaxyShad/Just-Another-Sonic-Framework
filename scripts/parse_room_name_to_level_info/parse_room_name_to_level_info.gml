
function parse_room_name_to_level_info(rm_index) {
    var _room_name = room_get_name(rm_index);

    var _INVALID = {
        zone_name: "INVALID ZONE NAME",
        act_number: undefined
    }

    if (!string_starts_with(_room_name, "rm_")) {
        // show_error("invalid zone name. Zone Name should start with <rm_>.", false);
        show_message("invalid zone name. Zone Name should start with <rm_>.");
        return _INVALID;
    }

    var _str_arr = string_split(_room_name, "_");
    var _str_arr_len = array_length(_str_arr);

    if (_str_arr_len < 2) {
        // show_error("invalid zone name. No zone name after <rm_> prefix.", false);
        show_message("invalid zone name. No zone name after <rm_> prefix.");
        return _INVALID;
    }

    var zone_name = "";
    for (var i = 1; i < _str_arr_len; i++) {
        if (_str_arr[i] == "act") {
            if (i == _str_arr_len-1) {
                show_message("invalid zone name. No zone act specified after <_act_> keyword.");
                // show_error("invalid zone name. No zone act specified after <_act_> keyword.", false)
                return _INVALID;
            }

            return {
                zone_name: zone_name,
                act_number: real(_str_arr[i + 1])
            }
        }

        if (i != 1) {
            zone_name += " ";
        }
        
        zone_name += _str_arr[i];

        if (i == _str_arr_len-1) {
            return {
                zone_name: zone_name,
                act_number: undefined
            };
        }
    }
}