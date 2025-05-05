var _cam = camera_get_active();

var _SPR = sprEhzBgFlowerFields;
var _W = sprite_get_width(_SPR);

x = camera_get_view_x(_cam);
y = camera_get_view_y(_cam);

var _top_shift = 0;

var _FILEDS_Y = 22+58+21+11+16+16;

var _paralax_x = 0.790;
var _PARALAX_X_FACTOR = 0.005;

var _SLICE_HEIGHTS  = [15, 18, 45];
var _SLICE_SIZE     = [1, 2, 3];

var _view_width = camera_get_view_width(_cam);

for (var s = 0; s < 3; s++) {
    for (var i = 0; i < _SLICE_HEIGHTS[s] / _SLICE_SIZE[s]; i++) {

        // Вычисляем позицию с учетом параллакса
        var _x_pos = x * _paralax_x;
        
        // Находим первую позицию спрайта слева от камеры
        var _first_tile_x = floor((-_x_pos) / _W) * _W + _x_pos;
        
        // Рисуем достаточно копий спрайта, чтобы покрыть экран
        for (var tx = _first_tile_x; tx < _first_tile_x + _view_width + _W; tx += _W) {
            draw_sprite_part(
                _SPR, 0, 
                0, _top_shift + i * _SLICE_SIZE[s], 
                _W, _top_shift + i * _SLICE_SIZE[s] + _SLICE_SIZE[s], 
                tx, _FILEDS_Y + _top_shift + y + i * _SLICE_SIZE[s]
            );
        }


        _paralax_x -= _PARALAX_X_FACTOR;
    }

    _top_shift += _SLICE_HEIGHTS[s];
}