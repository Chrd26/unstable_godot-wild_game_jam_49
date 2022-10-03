extends RigidBody2D

#Declare Booleans
var isJumping = false;
var isOnFloor = true;
var isonPlatform = false;
var isonPlatform2 = false;
var isonExit = false;

#Declare Variables
onready var stateMachine;
const walkingSpeed = 250;
const stopForce = 300;
const jumpForce = - 10000;
onready var animations = $AnimatedSprite;

#Declare Enum
enum{
	IDLE,
	JUMPING,
	WALKING,
	ONPLATFORM,
	ONPLATFORM2,
	ONEXITCHAPTER
}

func _ready():
	stateMachine = IDLE

func _process(_delta):
	if Global.movementEnabled:
		$Light2D/AnimationPlayer.stop();
		$Light2D.energy = 0;
		mode = 2;
		if Input.is_action_pressed("move_right") || Input.is_action_pressed("move_left"):
			stateMachine = WALKING;
			if Input.is_action_just_pressed("jump"):
				stateMachine = JUMPING;
	else:
		$Light2D/AnimationPlayer.play("light");
		mode = 1;

func _physics_process(_delta):
	pass;

func _integrate_forces(state):
	var vertvel = get_linear_velocity().y;
	var horVel = get_linear_velocity().x;
	match stateMachine:
		IDLE:
			#IDLE State Logic
			if isOnFloor:
				animations.play("Idle");
			else:
				animations.play("In the Air");
			if Input.is_action_just_pressed("jump"):
				stateMachine = JUMPING;
			if horVel > 0:
					state.apply_central_impulse(Vector2(horVel - stopForce , vertvel));
			elif horVel < 0:
					state.apply_central_impulse(Vector2(horVel + stopForce, vertvel));
			else: 
					state.apply_central_impulse(Vector2(horVel, vertvel));
		JUMPING:
			#JUMPING State Logic and Platform Logic
			if isOnFloor:
				if !isJumping:
					state.apply_central_impulse(Vector2(horVel, jumpForce));
					isJumping = true;
					animations.play("In the Air");
					stateMachine = IDLE;
					if isonPlatform:
						state.apply_central_impulse(Vector2(Global.getPlatformVelocity.x, Global.getPlatformVelocity.y + jumpForce))
						isJumping = true;
						stateMachine = ONPLATFORM;
					elif isonPlatform2:
						state.apply_central_impulse(Vector2(Global.getPlatform2Velocity.x, Global.getPlatform2Velocity.y + jumpForce))
						isJumping = true;
						stateMachine = ONPLATFORM2;
					elif isonExit:
						state.apply_central_impulse(Vector2(Global.getPlatform3Velocity.x, Global.getPlatform3Velocity.y + jumpForce))
						isJumping = true;
						stateMachine = ONEXITCHAPTER;
		WALKING:
			#WALKING State logic while the player is in the air or on the floor
			if isOnFloor:
				animations.play("Walk")
			else:
				animations.play("In the Air")
			if Input.is_action_pressed("move_left") && !Input.is_action_pressed("move_right"):
				animations.flip_h = 1;
				if !isJumping || isOnFloor:
					state.set_linear_velocity(Vector2(-1 * walkingSpeed, vertvel));
				else:
					#While on air, change from setting the linear velocity to applying central impulse
					state.apply_central_impulse(Vector2(-1 * walkingSpeed, vertvel));
			elif Input.is_action_pressed("move_right") && !Input.is_action_pressed("move_left"):
				animations.flip_h = 0;
				if !isJumping || isOnFloor:
					state.set_linear_velocity(Vector2(walkingSpeed, vertvel));
				else:
					#While on air, change from setting the linear velocity to applying central impulse
					state.apply_central_impulse(Vector2(walkingSpeed, vertvel));
			elif Input.is_action_just_released("move_left") || Input.is_action_just_released("move_right"):
				stateMachine = IDLE;
		ONPLATFORM:
			animations.play("Walk")
			if Input.is_action_pressed("move_left") && !Input.is_action_pressed("move_right"):
				animations.flip_h = 1;
				if !isJumping:
					state.set_linear_velocity(Vector2(Global.getPlatformVelocity + -1 * walkingSpeed, vertvel));
				else:
					#While on air, change from setting the linear velocity to applying central impulse
					state.apply_central_impulse(Vector2(Global.getPlatformVelocity + -1 * walkingSpeed, vertvel));
			elif Input.is_action_pressed("move_right") && !Input.is_action_pressed("move_left"):
				animations.flip_h = 0;
				if !isJumping:
					state.set_linear_velocity(Vector2(Global.getPlatformVelocity.x + walkingSpeed, Global.getPlatformVelocity.y));
				else:
					#While on air, change from setting the linear velocity to applying central impulse
					state.apply_central_impulse(Vector2(Global.getPlatformVelocity.x + walkingSpeed, Global.getPlatformVelocity + vertvel));
			elif Input.is_action_just_released("move_left") || Input.is_action_just_released("move_right"):
				state.set_linear_velocity(Global.getPlatformVelocity.x, Global.getPlatformVelocity.y)
		ONPLATFORM2:
			animations.play("Walk")
			if Input.is_action_pressed("move_left") && !Input.is_action_pressed("move_right"):
				animations.flip_h = 1;
				if !isJumping:
					state.set_linear_velocity(Vector2(Global.getPlatform2Velocity + -1 * walkingSpeed, vertvel));
				else:
					#While on air, change from setting the linear velocity to applying central impulse
					state.apply_central_impulse(Vector2(Global.getPlatform2Velocity + -1 * walkingSpeed, vertvel));
			elif Input.is_action_pressed("move_right") && !Input.is_action_pressed("move_left"):
				animations.flip_h = 0;
				if !isJumping:
					state.set_linear_velocity(Vector2(Global.getPlatform2Velocity.x + walkingSpeed, Global.getPlatformVelocity.y));
				else:
					#While on air, change from setting the linear velocity to applying central impulse
					state.apply_central_impulse(Vector2(Global.getPlatformV2elocity.x + walkingSpeed, Global.getPlatformVelocity + vertvel));
			elif Input.is_action_just_released("move_left") || Input.is_action_just_released("move_right"):
				state.set_linear_velocity(Global.getPlatform2Velocity.x, Global.getPlatform2Velocity.y)
		ONEXITCHAPTER:
			animations.play("Walk")
			if Input.is_action_pressed("move_left") && !Input.is_action_pressed("move_right"):
				animations.flip_h = 1;
				if !isJumping:
					state.set_linear_velocity(Vector2(Global.getPlatform3Velocity + -1 * walkingSpeed, vertvel));
				else:
					#While on air, change from setting the linear velocity to applying central impulse
					state.apply_central_impulse(Vector2(Global.getPlatform3Velocity + -1 * walkingSpeed, vertvel));
			elif Input.is_action_pressed("move_right") && !Input.is_action_pressed("move_left"):
				animations.flip_h = 0;
				if !isJumping:
					state.set_linear_velocity(Vector2(Global.getPlatform3Velocity.x + walkingSpeed, Global.getPlatform3Velocity.y));
				else:
					#While on air, change from setting the linear velocity to applying central impulse
					state.apply_central_impulse(Vector2(Global.getPlatform3Velocity.x + walkingSpeed, Global.getPlatform3Velocity + vertvel));
			elif Input.is_action_just_released("move_left") || Input.is_action_just_released("move_right"):
				state.set_linear_velocity(Global.getPlatform3Velocity.x, Global.getPlatform3Velocity.y)


func _on_RigidBody2D_body_entered(body):
	isJumping = false;
	isOnFloor = true;
	if body.is_in_group("platform"):
		stateMachine = ONPLATFORM;
		isonPlatform = true;
		isOnFloor = true;
	elif body.is_in_group("platform2"):
		stateMachine = ONPLATFORM2;
		isonPlatform2 = true;
		isOnFloor = true;
	elif body.is_in_group("exitChapter"):
		stateMachine = ONEXITCHAPTER;
		isonExit = true;
		isOnFloor = true;


func _on_RigidBody2D_body_exited(body):
	isOnFloor = false;
	if body.is_in_group("platform"):
		isonPlatform = false;
	elif body.is_in_group("platform2"):
		isonPlatform2 = false;
	elif body.is_in_group("exitChapter"):
		isonExit = false;
