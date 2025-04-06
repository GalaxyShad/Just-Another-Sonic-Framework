
var _plr = instance_nearest(x, y, objPlayer);

if (_plr != noone) {
    if (!is_activated) {
        if (_plr.x > x) {
            is_activated = true;
            rotation *= max(floor(_plr.plr.xsp / 2), 2);
        }
    }

    if (abs(_plr.x - x) < 200) {
        _plr.camera.offset_y = -48;
        _plr.camera.offset_x = 0;
        _plr.camera.FollowingObject = self;
        
    } else if (_plr.camera.FollowingObject != _plr){
        _plr.camera.FollowingObject = _plr;
        _plr.camera.offset_y = 0;
        _plr.camera.offset_x = 0;
    }
}


if (is_activated) {
    rotation = lerp(rotation, 180, 0.025);
}

draw_sprite(sprSignPostPipe, 0, x, y);

var _icon = (dcos(rotation) >= 0) ? sprSignPostEggman : sprSonicSignPost;

draw_sprite_ext(_icon, 0, 
    x, y - 40, 
    abs(dcos(rotation)), 1,
    0, c_white, 1
);

draw_sprite_ext(
    sprSignPostIconSide, 0,
    x + (sprite_get_width(sprSignPostEggman) / 2) * dcos(rotation % 180), y-40,
    dsin(rotation), 1, 
    0, c_white, 1
);

draw_text(x, y, _plr.camera.offset_y);