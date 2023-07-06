
obj = 0;

characters = [];
current = 0;
count = 0;


while (true) {
	if (!object_exists(obj)) break;
	
	if (object_get_parent(obj) == objPlayer)
		array_push(characters, obj);
		
	obj++;	
}

count = array_length(characters);

change = function(instance) {
	current++;
	if (current >= count)
		current = 0;
	
	show_debug_message($"{current} {characters}")
	
	instance_create_depth(
		instance.x, instance.y, instance.depth, characters[current]);
	
	with instance instance_destroy();
};

get_current = function() {
	return object_get_name(characters[current]);	
}


