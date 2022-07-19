// Ресурсы скриптов были изменены для версии 2.3.0, подробности см. по адресу
// https://help.yoyogames.com/hc/en-us/articles/360005277377
function RingLoss(_x, _y) {
	var ring_counter = 0;
	var ring_angle = 101.25;  
	var ring_flip = false;
	var ring_speed = 4;
 
	// perform loop while the ring counter is less than number of lost rings
	while (ring_counter < min(global.rings, 32)) {
	    // create the ring
	    var oRing = instance_create_depth(_x, _y, -1, objRing);
		
		oRing.mode = 1;
		
	    oRing.xsp = dcos(ring_angle) * ring_speed;
	    oRing.ysp = -dsin(ring_angle) * ring_speed;
    
	    // ever ring created will moving be at the same angle as the other in the current pair, but flipped the other side of the circle
	    if ring_flip {
	        oRing.xsp *= -1;  // reverse ring's x speed
	        ring_angle += 22.5;  // we increment angle on every other ring which makes 2 even rings either side
	    }
    
	    // toggle flip
	    ring_flip = !ring_flip;  // if flip is false, flip becomes true and vice versa
    
	    // increment counter
	    ring_counter += 1;
    
	    // if we are halfway, start second "circle" of rings with lower speed
	    if (ring_counter == 16) {
	        ring_speed = 2;
	        ring_angle = 101.25;  // reset the angle
	    }
	}
}