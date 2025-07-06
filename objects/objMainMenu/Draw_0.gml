
var _items = menu.get_items();
for (var i = 0; i < array_length(_items); i++) {
    var _item = menu.get_item(i);
    
    draw_set_color(c_white);
    if (_item.selected) {
        draw_set_color(c_yellow);
    }

    var _text_to_draw;

    if (_item.item[$ "computed_name"] == undefined) {
        _text_to_draw = _item.item.name;    
    } else {
        _text_to_draw = _item.item.computed_name();
    }

    draw_set_halign(fa_center);
    draw_text(x, y + i * 16, _text_to_draw);
}