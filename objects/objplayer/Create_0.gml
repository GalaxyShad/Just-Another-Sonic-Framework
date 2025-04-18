var num = audio_get_listener_count();
for( var i = 0; i < num; i++)
{
    var info = audio_get_listener_info(i);
    audio_set_master_gain(info[? "index"], 0.1);
    ds_map_destroy(info);
}

if (!variable_instance_exists(id, "character_builder")) {
	show_error(
		"[CHARACTER INITIALISATION ERROR]\n" +
		$"character_builder not exists.\n" +
		"You need to initialize this variable to create your character.\n",
		true
	)
}

if (!instance_exists(objSolidTIlemapFinder))
	instance_create_depth(x, y, depth, objSolidTIlemapFinder);

plr = character_builder.build();
plr.state_machine.change_to("normal");

draw_player = function() {
	if (plr.draw_behind != undefined)
		plr.draw_behind(plr);	
	draw_self();
}

// camera = !instance_exists(objCamera) ? 
// 	instance_create_layer(x, y, layer, objCamera) :
// 	instance_find(objCamera, 0);
