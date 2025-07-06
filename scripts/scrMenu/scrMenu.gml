function Menu(owner_id, items) constructor {
    __cursor = 0;

    __items = items;
    __owner = owner_id;

    go_side_front = function() {
        if (__items[__cursor][$ "on_side_front"] != undefined)
            __items[__cursor].on_side_front(__owner);
    }

    go_side_back = function() {
        if (__items[__cursor][$ "on_side_back"] != undefined)
            __items[__cursor].on_side_back(__owner);
    }

    go_front = function() {
        __cursor--;
        if (__cursor < 0) {
            __cursor = array_length(__items) - 1;
        }
    }

    go_back = function() {
        __cursor++;
        if (__cursor >= array_length(__items)) {
            __cursor = 0;
        }
    }

    select = function() {
        if (__items[__cursor][$ "on_select"] != undefined)
            __items[__cursor].on_select(__owner);
    }

    change_items = function(_items) {
        __cursor = 0;
        __items = _items;
    }

    get_items = function() {
        return __items;
    }

    get_item = function(index) {
        var _item = __items[index];
        
        return {
            item: _item,
            selected: __cursor == index
        }
    }

    
}