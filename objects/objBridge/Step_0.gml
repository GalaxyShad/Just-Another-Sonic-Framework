if (player_instance == noone) {
   player_instance = instance_find(objPlayer, 0);
   exit;
}

var _current_log = -1;


for (var i = 0; i < array_length(segment_list); i++) {
   var _log = segment_list[i];

   if (collision_line(_log.x, _log.y, _log.x, _log.y - 24, objPlayer, false, true) != noone) {
      _current_log = i;
   }
}


var _maximum_dip = undefined;
// Get the current maximum dip for the bridge via current_log
// Note: It would be better to get the max dip for all segments and placing them in an array for later use rather than calculating each frame
if (_current_log <= segment_count / 2)
   // Log is to the left of the player
   _maximum_dip = _current_log * 2; // Working from the left side in
else 
   // Log is to the right of the player (or the log being stood on)
   _maximum_dip = ((segment_count - _current_log) + 1) * 2; // Working from the right side in

  
// Loop through all logs, and set their Y Positions
for (var i = 0; i < segment_count; i ++)
{
   // Get difference in position of this log to current log stood on
   var difference = abs((i + 1) - _current_log);
   var log_distance;

   // Get distance from current log to the closest side, depending if before or after current_log
   if (i < _current_log) 
      // Log is to the left of the player
      log_distance = 1 - (difference / _current_log); //working from the left side in
   else 
      // Log is to the right of the player (or the log being stood on)
      log_distance = 1 - (difference / ((segment_count - _current_log) + 1));  // working from the right side in

   // Get y of current log using max dip and log distance. This is the final Y Position for the log
   var _log = segment_list[i];
   
   _log.y = y + _maximum_dip * dsin(90 * log_distance);
}

