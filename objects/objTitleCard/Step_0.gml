
state();

if (fade_timer == 1) 
    instance_create_depth(x, y, depth, objFade);

if (fade_timer > 0) 
    fade_timer--;

    
