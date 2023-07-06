
function is_player_sphere() {
	return array_contains([
		"jump",
		"roll",
		"dropdash",
		//"glid",
		"land",
	], state.current());
}

function create_basic_player_states() {
state = new State(id);

state.add("normal",		new PlayerStateNormal());
state.add("jump",		new PlayerStateJump());
state.add("look_up",	new PlayerStateLookUp());
state.add("look_down",	new PlayerStateLookDown());
state.add("push",		new PlayerStatePush());
state.add("roll",		new PlayerStateRoll());
state.add("skid",		new PlayerStateSkid());
state.add("balancing",  new PlayerStateBalancing());
state.add("spindash",	new PlayerStateSpindash());
state.add("hurt",		new PlayerStateHurt());
state.add("die",		new PlayerStateDie());
state.add("spring",		new PlayerStateSpring());
state.add("transform",	new PlayerStateTransform());

state.change_to("normal");
return state;
}