
platform = instance_place(x, y, objMovingPlatform);

if (platform == noone) {
    instance_destroy();
    exit;
}

platform.x = x;
platform.y = y;

distance = sprite_width;

spd = 1;