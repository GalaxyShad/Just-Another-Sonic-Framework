

state.step();

array_foreach(behavior_loop.get_loop(), function(_value, _index) {
	if (behavior_loop.is_function_available(_value)) _value();
});

array_foreach(handle_loop.get_loop(), function(_value, _index) {
	if (handle_loop.is_function_available(_value)) _value();
});
