
enum States {
	Idle,
	Producing
};

state = States.Idle;

amount			= 0;
current_set		= 0;
was_big_bubble	= false;

image_speed = 0.25;

SIZES_SET = [
	[Sizes.Small,  Sizes.Small,  Sizes.Small,  Sizes.Small,  Sizes.Medium,  Sizes.Small],
	[Sizes.Small,  Sizes.Small,  Sizes.Small,  Sizes.Medium, Sizes.Small,   Sizes.Small],
	[Sizes.Medium, Sizes.Small,  Sizes.Medium, Sizes.Small,  Sizes.Small,   Sizes.Small],
	[Sizes.Small,  Sizes.Medium, Sizes.Small,  Sizes.Small,  Sizes.Medium,  Sizes.Small],
];

alarm[0] = irandom_range(128, 255);