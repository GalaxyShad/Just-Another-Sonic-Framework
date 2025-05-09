// Sonic 2 EHZ like parallax

var _cam = camera_get_active();

var _SPR = sprEhzBgFlowerFields;
var _W = sprite_get_width(_SPR);

x = camera_get_view_x(_cam);
y = camera_get_view_y(_cam);

var _top_shift = 0;

var _SKY_HEIGHT                 = 22;
var _CLOUDS_HEIGHT              = 58;
var _WATER_TOP_HEIGHT           = 21;
var _WATER_HEIGHT               = 11;
var _TOP_MOUNTAINS_HEIGHT       = 16;
var _BOTTOM_MOUNTAINS_HEIGHT    = 16;

var _FILEDS_Y = _SKY_HEIGHT
    +_CLOUDS_HEIGHT
    +_WATER_TOP_HEIGHT
    +_WATER_HEIGHT
    +_TOP_MOUNTAINS_HEIGHT
    +_BOTTOM_MOUNTAINS_HEIGHT;

var _paralax_x = 0.790;
var _PARALAX_X_FACTOR = 0.005;

var _SLICE_HEIGHTS  = [15, 18, 45];
var _SLICE_SIZE     = [1, 2, 3];

var _view_width = camera_get_view_width(_cam);

for (var s = 0; s < 3; s++) {
    for (var i = 0; i < _SLICE_HEIGHTS[s] / _SLICE_SIZE[s]; i++) {
        var _x_pos = x  * _paralax_x;

        // draw until end of level
        for (var j = 0; j < ceil(room_width / (_W * _paralax_x)); j++) {
            draw_sprite_part(
                _SPR, 0, 
                0, _top_shift + i * _SLICE_SIZE[s], 
                _W, _top_shift + i * _SLICE_SIZE[s] + _SLICE_SIZE[s], 
                j * _W + _x_pos, _FILEDS_Y + _top_shift + y + i * _SLICE_SIZE[s]
            );
        }

        _paralax_x -= _PARALAX_X_FACTOR;
    }

    _top_shift += _SLICE_HEIGHTS[s];
}