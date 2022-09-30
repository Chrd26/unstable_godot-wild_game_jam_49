extends RigidBody2D

#booleans
var isJumping = false;
var isonFloor = false;

#Variables
var gravity = 100;
var walkingSpeed = 500;
var stoppingSpeed = 500;
var jumpForce = -1000;
var stateMachine;

#enumeration
enum{
	IDLE,
	WALK_L,
	WALK_R,
	JUMP
}


func _ready():
	stateMachine = IDLE;

func _process(_delta):
	if Global.movementEnabled:
		mode = 2;
	if !Global.movementEnabled:
		mode = 3;

func _input(event):
	if Global.movementEnabled:
		if event.is_action_pressed("move_left"):
			stateMachine = WALK_L;
		if event.is_action_pressed("move_right"):
			stateMachine = WALK_R;
		if event.is_action_pressed("jump"):
			stateMachine =  JUMP;

func _integrate_forces(_state):
	match stateMachine:
		IDLE:
			pass;
		WALK_L:
			pass;
		WALK_R:
			pass;
		JUMP:
			pass;
