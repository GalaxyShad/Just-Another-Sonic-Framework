
function ring_loss(_x, _y) {
	var _ring_counter = 0;
	var _ring_angle = 101.25;  
	var _ring_flip = false;
	var _ring_speed = 4;
 
	// perform loop while the ring counter is less than number of lost rings
	while (_ring_counter < min(global.rings, 32)) {
	    // create the ring
	    var _o_ring = instance_create_depth(_x, _y, -1, objRing);
		
		_o_ring.mode = 1;
		
	    _o_ring.xsp = dcos(_ring_angle) * _ring_speed;
	    _o_ring.ysp = -dsin(_ring_angle) * _ring_speed;
    
	    // ever ring created will moving be at the same angle as the other in the current pair, but flipped the other side of the circle
	    if _ring_flip {
	        _o_ring.xsp *= -1;  // reverse ring's x speed
	        _ring_angle += 22.5;  // we increment angle on every other ring which makes 2 even rings either side
	    }
    
	    // toggle flip
	    _ring_flip = !_ring_flip;  // if flip is false, flip becomes true and vice versa
    
	    // increment counter
	    _ring_counter += 1;
    
	    // if we are halfway, start second "circle" of rings with lower speed
	    if (_ring_counter == 16) {
	        _ring_speed = 2;
	        _ring_angle = 101.25;  // reset the angle
	    }
	}
}