extends RigidBody2D

#Declare Booleans
var isonFloor = false;
var isonPlatform = false;
var isonPlatform2 = false;
var isonexitChapter = false;
var isonWall = false;
var isJumping = false;
var isWalkingComplete = true;
var isWalkingLeft = false;
var isWalkingRight = false;
var isonShape = false;

#Declare variables
const gravity = 100;
const walkingspeed = 400;
const airMovingSpeed = 80;
const jumpingForce = -800;
const surfaceFriction = 50;
const airFriction = 50;
const stopWalkingForce = 100;
onready var animations = $AnimatedSprite;
var randomPitch = RandomNumberGenerator.new();
var randomSound = RandomNumberGenerator.new();
var states;

#Declare States
enum{
	IDLE,
	JUMPING,
	WALKING_L,
	WALKING_R,
	ISONWALL,
	ISONPLATFORM1,
	ISONPLATFORM2,
	ISONEXITCHAPTER
}

func _ready():
	#Defaults
	states = IDLE
	animations.play("Idle");

func _physics_process(_delta):
	if Global.movementEnabled:
		mode = 2
		#Input Detection
		if Input.is_action_pressed("move_left"):
			if !isJumping:
				states = WALKING_L;
			if Input.is_action_just_pressed("jump"):
				states = JUMPING;
		elif Input.is_action_pressed("move_right"):
			if !isJumping:
				states = WALKING_R;
			if Input.is_action_just_pressed("jump"):
				states = JUMPING;
		elif Input.is_action_just_released("move_left") || Input.is_action_just_released("move_right"):
			states = IDLE;
		elif Input.is_action_just_pressed("jump"):
			if !isJumping:
				states = JUMPING;
	else:
		mode = 1;

func _integrate_forces(state):
	#State Machine
	print(linear_velocity.x);
	print(states);
	match states:
		IDLE:
			isWalkingComplete = true;
			if linear_velocity.x > 0:
				if !isonShape:
					state.apply_central_impulse(Vector2(-1 * stopWalkingForce, gravity - airFriction));
				else:
					state.apply_central_impulse(Vector2(0 , gravity - airFriction));
			elif linear_velocity.x < 0:
				if !isonShape:
					state.apply_central_impulse(Vector2(stopWalkingForce, gravity - airFriction));
				else:
					state.apply_central_impulse(Vector2(0, gravity - airFriction));
			elif  linear_velocity.x == 0:
				state.apply_central_impulse(Vector2(linear_velocity.x , gravity - airFriction));
			if isJumping:
				if Input.is_action_pressed("move_left"):
					states = WALKING_L
				elif Input.is_action_pressed("move_right"):
					states = WALKING_R
		JUMPING:
			if !isJumping:
					state.apply_central_impulse(Vector2(linear_velocity.x, jumpingForce + airFriction));
					isJumping = true;
			if isJumping:
					states = IDLE;
		WALKING_L:
			#For Walking Animation
			isWalkingComplete = false;
			#Apply different types of force depending on the state of the Character
			if !isJumping:
				state.set_linear_velocity(Vector2(-1 * walkingspeed + surfaceFriction, gravity - airFriction));
			elif isJumping || !isonFloor:
				if Input.is_action_pressed("move_left"):
					# warning-ignore:integer_division
					state.apply_central_impulse(Vector2(-1 * airMovingSpeed + airFriction, gravity - airFriction));
				else:
					# warning-ignore:integer_division
					state = IDLE;
		WALKING_R:
			#for Walking Animation
			isWalkingComplete = false;
			#Apply different types of force depending on the state of the Character
			if !isJumping:
				state.set_linear_velocity(Vector2(walkingspeed - surfaceFriction, gravity - airFriction));
			elif isJumping || !isonFloor:
				if Input.is_action_pressed("move_right"):
					# warning-ignore:integer_division
					state.apply_central_impulse(Vector2(airMovingSpeed - airFriction, gravity - airFriction));
				else:
					# warning-ignore:integer_division
					state = IDLE
		ISONWALL:
			pass;
		ISONPLATFORM1:
			pass;
		ISONPLATFORM2:
			pass;
		ISONEXITCHAPTER:
			pass;

func _on_AnimatedSprite_animation_finished():
	#Animation System
	if !isWalkingComplete:
		animations.play("Walk");
	elif isWalkingComplete:
		animations.play("Idle");

func _on_RigidBody2D_body_entered(body):
	#collission logic on enter
	isonFloor = true;
	isJumping = false;
	if !body.is_in_group("wall"):
		if Input.is_action_pressed("move_left"):
			states = WALKING_L;
		elif Input.is_action_pressed("move_right"):
			states = WALKING_R;
	elif body.is_in_group("platform"):
		isonPlatform = true;
	elif body.is_in_group("platform2"):
		isonPlatform2 = true;
	elif body.is_in_group("exitChapter"):
		isonexitChapter = true;
	elif body.is_in_group("wall"):
		isonWall = true;
	elif body.is_in_group("shape"):
		isonShape = true;

func _on_RigidBody2D_body_exited(body):
	#collision logic on exit
	isonFloor = false;
	if body.is_in_group("platform"):
		isonPlatform = false;
	if body.is_in_group("platform2"):
		isonPlatform2 = false;
	if body.is_in_group("exitChapter"):
		isonexitChapter = false;
	if body.is_in_group("wall"):
		isonWall = false;
	elif body.is_in_group("shape"):
		isonShape = true;


