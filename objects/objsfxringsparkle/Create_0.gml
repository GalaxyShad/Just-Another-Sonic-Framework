/// @description Вставьте описание здесь
// Вы можете записать свой код в этом редакторе
image_speed = 0.5;

//ParticleSystem5
 _ps = part_system_create();
part_system_draw_order(_ps, true);

//Emitter
var _ptype1 = part_type_create();
part_type_shape(_ptype1, pt_shape_spark);
part_type_size(_ptype1, 0.125, 0.25, 0, 0.1);
part_type_scale(_ptype1, 1, 1);
part_type_speed(_ptype1, 0, 1, 0, 0);
part_type_direction(_ptype1, 0, 360, 0, 0);
part_type_gravity(_ptype1, 0, 270);
part_type_orientation(_ptype1, 0, 0, 0, 0, false);
part_type_colour3(_ptype1, $07EEFF, $0F53FF, $89F7FF);
part_type_alpha3(_ptype1, 1, 1, 1);
part_type_blend(_ptype1, true);
part_type_life(_ptype1, 3, 6);

var _pemit1 = part_emitter_create(_ps);
part_emitter_region(_ps, _pemit1, -8, 8, -8, 8, ps_shape_ellipse, ps_distr_linear);
part_emitter_stream(_ps, _pemit1, _ptype1, 1);

part_system_position(_ps, x, y);












