function add_basic_player_states(_state) {
	_state
		.add("normal",		new PlayerStateNormal())
		.add("jump",		new PlayerStateJump())
		.add("look_up",		new PlayerStateLookUp())
		.add("look_down",	new PlayerStateLookDown())
		.add("push",		new PlayerStatePush())
		.add("roll",		new PlayerStateRoll())
		.add("skid",		new PlayerStateSkid())
		.add("balancing",	new PlayerStateBalancing())
		.add("spindash",	new PlayerStateSpindash())
		.add("hurt",		new PlayerStateHurt())
		.add("die",			new PlayerStateDie())
		.add("spring",		new PlayerStateSpring())
		.add("breathe",		new PlayerStateBreathe())
		.add("corksew",		new PlayerStateCorksew())

		.add("noclip",		new PlayerStateNoclip())
	;
}