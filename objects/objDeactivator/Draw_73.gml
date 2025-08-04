
instance_deactivate_all(true);

var _cam, _cam_x, _cam_y, _cam_h, _cam_w;

_cam = camera_get_active();

_cam_x = camera_get_view_x(_cam);
_cam_y = camera_get_view_y(_cam);
_cam_w = camera_get_view_width(_cam);
_cam_h = camera_get_view_height(_cam);


instance_activate_region(
    _cam_x - CAMERA_PADDING.x, _cam_y - CAMERA_PADDING.y, 
    _cam_w + CAMERA_PADDING.x, _cam_h + CAMERA_PADDING.y,
    true
);



if (InstPlayer != noone) {
    instance_activate_object(InstPlayer);
    
    instance_activate_region(
        InstPlayer.x - CAMERA_PADDING.x, InstPlayer.y - CAMERA_PADDING.y, 
        InstPlayer.x + CAMERA_PADDING.x, InstPlayer.y + CAMERA_PADDING.y,
        true
    );
}


for (var i = 0; i < array_length(do_not_deactivate_list); i++) {
    instance_activate_object(do_not_deactivate_list[i]);
}





