// Ресурсы скриптов были изменены для версии 2.3.0, подробности см. по адресу
// https://help.yoyogames.com/hc/en-us/articles/360005277377
function PlayerAirMovement(){
	if (ground)
		return;
		
	if (action == ACT_HURT) {
		ysp += 0.1875;
		return;	
	}
	
	// Gravity
	ysp += grv;
	if(state.current() == "glid" && ysp > 2) ysp=2;
	else if (ysp > 16) ysp = 16;
		
	// Movement
	if (allow_movement) {
		if (is_key_left && xsp > -top) 
			xsp -= airacc;
		else if (is_key_right && xsp < top) 
			xsp += airacc;
	}
	if(state.current() == "glid"){		
		if(!is_key_left && !is_key_right && abs(xsp) < glid_top){
			xsp += airacc * sign(image_xscale);
		}
		else if (is_key_left && xsp > -glid_top){
			xsp -= airacc;
		}
		else if (is_key_right && xsp < glid_top){
			xsp += airacc;
		}
	}
	
		
	// Air Drag
	if (!ground && ysp < 0 && ysp > -4) {
	    xsp -= (((xsp * 1000) div 125) / 256000);
	}
}