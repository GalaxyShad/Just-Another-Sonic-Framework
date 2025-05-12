
obj = 1;

characters = [objCharacterSonic, objCharacterTails, objCharacterKnuckles];
current = 0;
count = 0;

count = array_length(characters);

change = function(instance) {
	current++;
	if (current >= count)
		current = 0;
	
	instance_create_depth(
		instance.x, instance.y, instance.depth, characters[current]);
	
	with instance instance_destroy();
};

get_current = function() {
	return object_get_name(characters[current]);	
}


