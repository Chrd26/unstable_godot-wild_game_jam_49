extends RigidBody2D

#Declare Booleans
var isonFloor = false;
var isonPlatform = false;
var isonPlatform2 = false;
var isonexitChapter = false;
var isonWall = false;
var isJumping = false;
var isWalkingComplete = true;

#Declare variables
const gravity = 100;
const walkingspeed = 10000000;
const jumpingForce = -100;
const surfaceFriciton = 0;
const airFriction = 0;
const stopWalingForce = - 100;
onready var animations = $AnimatedSprite;
var randomPitch = RandomNumberGenerator.new();
var randomSound = RandomNumberGenerator.new();
var states;

#Declare States
enum{
	IDLE,
	JUMPING_L,
	JUMPING_R,
	LANDING,
	WALKING_L,
	WALKING_R,
	ISONWALL,
	ISONPLATFORM1,
	ISONPLATFORM2,
	ISONEXITCHAPTER
}

func _ready():
	states = IDLE

func _process(delta):
	print(isWalkingComplete);
	if Input.is_action_pressed("move_left"):
		states = WALKING_L;
	elif Input.is_action_pressed("move_right"):
		states = WALKING_R;
	elif Input.is_action_just_released("move_left"):
		isWalkingComplete = true;
	elif Input.is_action_just_released("move_right"):
		isWalkingComplete = true;

func _integrate_forces(state):
	match states:
		IDLE:
			animations.play("Idle");
		JUMPING_L:
			pass;
		JUMPING_R:
			pass;
		LANDING:
			pass;
		WALKING_L:
			isWalkingComplete = false;
			state.add_central_force(Vector2(walkingspeed - surfaceFriciton, gravity + airFriction));
		WALKING_R:
			isWalkingComplete = false;
			state.add_central_force(Vector2(-1 * walkingspeed + surfaceFriciton, gravity + airFriction));
		ISONWALL:
			pass;
		ISONPLATFORM1:
			pass;
		ISONPLATFORM2:
			pass;
		ISONEXITCHAPTER:
			pass;

func _on_AnimatedSprite_animation_finished():
	if !isWalkingComplete:
		animations.play("Walk");
	else:
		states = IDLE;


func _on_RigidBody2D_body_entered(body):
	isonFloor = true;
	isJumping = false;
	if body.is_in_group("platform"):
		isonPlatform = true;
	if body.is_in_group("platform2"):
		isonPlatform2 = true;
	if body.is_in_group("exitChapter"):
		isonexitChapter = true;
	if body.is_in_group("wall"):
		isonWall = true;



func _on_RigidBody2D_body_exited(body):
	isonFloor = false;
	if body.is_in_group("platform"):
		isonPlatform = false;
	if body.is_in_group("platform2"):
		isonPlatform2 = false;
	if body.is_in_group("exitChapter"):
		isonexitChapter = false;
	if body.is_in_group("wall"):
		isonWall = false;

