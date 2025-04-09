// 
function place_meeting_platform(_x, _y) {
    return (
        place_meeting(_x, _y, parSolid) 
	    || (global.solid_tilemap_main != -1 && place_meeting(_x, _y, global.solid_tilemap_main))
	    || (place_meeting(_x, _y, parPlatform) 
	    || (global.solid_tilemap_platform != -1 && place_meeting(_x, _y, global.solid_tilemap_platform)))
    );
}

function collision_line_platform(_x1, _y1, _x2, _y2) {
    return (
        collision_line(_x1, _y1, _x2, _y2, parSolid, true, true) 
	    || (global.solid_tilemap_main != -1 && collision_line(_x1, _y1, _x2, _y2, global.solid_tilemap_main, true, true) )
	    || collision_line(_x1, _y1, _x2, _y2, parPlatform, true, true) 
	    || (global.solid_tilemap_platform != -1 && collision_line(_x1, _y1, _x2, _y2, global.solid_tilemap_platform, true, true) )
    );
}