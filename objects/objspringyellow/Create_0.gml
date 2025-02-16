image_speed = 0;

xsp = (xsp == undefined) ? lengthdir_x(spd, image_angle - 90) : xsp * sign(dsin(image_angle));
ysp = (ysp == undefined) ? lengthdir_y(spd, image_angle - 90) : ysp * sign(dcos(image_angle));