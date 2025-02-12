
throw_delays = [32, 24, 16, 40, 32, 16]

timer = 0;
target_delay = 0;
throw_id = 0;
target_distance = 0;

image_speed = 0;

image_index = 0;
hand_animation_timer = 0;

hand_angle = 0;

ysp = 0;

state_await_player = function() {
    var _plr = instance_nearest(x, y, objPlayer);
    
    target_distance = 0x7F;

    if (_plr != noone) {
        var _distance_to_plr = _plr.x - x;
        var _facing_direction;
    
        if (_distance_to_plr != 0)
            _facing_direction = sign(_distance_to_plr);
    
        if (_distance_to_plr < target_distance) {
            target_distance = _distance_to_plr;
            image_xscale = -_facing_direction;
        }
    }

    var _is_target_found = false;
    if (target_delay == 0) {
        if (target_distance > -0x60 && target_distance < 0x60) {
            timer = 8;
            target_delay = 32;
            hand_angle = 90;
            state = state_throw;
            _temp0 = true;
        }
    } else {
        target_delay--;
    }

    if (_is_target_found == false) {
        timer--;

        if (timer < 0) {
            var _should_move_up = throw_id & 1;
        
            ysp = _should_move_up ? -1 : 1;

            timer = throw_delays[throw_id];
    
            throw_id++;
            if (throw_id > 5) {
                throw_id = 0;
            } 
    
            state = state_moving;
        }
    } 
}

state_moving = function() {
    hand_animation_timer++;

    if (hand_animation_timer == 6) {
        image_index = 1;
    } 

    if (hand_animation_timer == 12) {
        image_index = 0;
        hand_animation_timer = 0;
    }

    self.y += ysp;
    
    timer--;

    if (timer < 0) {
        timer = 16;
        state = state_await_player;
    }
}

state_throw = function() {
    timer--;

    if (timer < 0) {
        var _coconut = instance_create_depth(
            x + 0xB * sign(image_xscale), 
            y - 0xD, 
            depth - 1, 
            objCoconutProjectile, 
        {
            vspeed: -1,
            hspeed: 1 * -sign(image_xscale)
        });

        timer = 8;
        state = state_hasthrown;
    }
}

state_hasthrown = function() {
    timer--;

    if (timer < 0) {
        var _should_move_up = throw_id & 1;
        
        ysp = _should_move_up ? -1 : 1;

        timer = throw_delays[throw_id];

        throw_id++;
        if (throw_id > 5) {
            throw_id = 0;
        } 

        state = state_moving;
    }
}

state = state_await_player;