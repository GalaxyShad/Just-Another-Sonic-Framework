var _pos = ((-cos(global.tick / (1/spd * distance) ) + 1) / 2)  * distance;

platform.x = x + lengthdir_x(_pos, image_angle);
platform.y = y + lengthdir_y(_pos, image_angle);
