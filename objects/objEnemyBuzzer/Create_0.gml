timer = 0;
shoot_timer = 0;

xsp = -1 * sign(image_xscale);

is_facing_right = sign(image_xscale) == -1;
has_shot = false;

fire_anim_frame = 0;
fire_anim_timer = 0;

image_speed = 0;

state_flying = function() {
    if timer < 256 {
        timer++;
        x += xsp;
    } else {
        timer = 0;
        state = state_stopped;
        is_facing_right = !is_facing_right;
        xsp = -xsp;
    }

    var _plr = instance_nearest(x, y, objPlayer);
    if (!has_shot) {
        var _is_plr_detected = collision_rectangle(
            x + 28 * -sign(image_xscale), y - 256,
            x + 30 * -sign(image_xscale), y + 256,
            objPlayer, false, true
        );

        if (_is_plr_detected) {
            state = state_shooting;
            image_index = 1;
        }
    }
}

state_stopped = function() {
    if (shoot_timer < 30) {
        shoot_timer++;
    } else {
        shoot_timer = 0;
        state = state_flying;
        has_shot = false;
        image_index = 0;
    }
}

state_shooting = function() {
    if (shoot_timer < 50) {
        shoot_timer++;

        if (shoot_timer == 30) {

            var _PROJECTILE_SPD = 1.8;

            instance_create_depth(
                x + 0xD * sign(image_xscale), 
                y + 0x18, 
                depth-1, 
                objBuzzerProjectile
            , {
                hspeed: _PROJECTILE_SPD * -sign(image_xscale),
                vspeed: _PROJECTILE_SPD,
                image_xscale: image_xscale
            })
        }
    } else {
        shoot_timer = 0;
        state = state_flying;
        image_index = 0;
        has_shot = true;
    }
}

state = state_flying;