extends RigidBody2D

#Declare Booleans
var isJumping = false;
var isOnFloor = true;
var isonPlatform = false;
var isonPlatform2 = false;
var isonPlatform3 = false;
var isonExit = false;

#Declare Audio Variables
onready var jumpImpact = [$Audio/JumpImpact1, $Audio/JumpImpact2];
onready var jumpMovement = $Audio/JumpMovement;
onready var footsteps = $Audio/Footsteps;
onready var walkingMovement = $Audio/Movement;
onready var landImpact = $Audio/landImpact;
onready var takeDamage = [$Audio/takeDamage1, $Audio/takeDamage2, $Audio/takeDamage3, $Audio/takeDamage4, $Audio/takeDamage5];
var randomPitch = RandomNumberGenerator.new();
var randomSound = RandomNumberGenerator.new();

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
	ONPLATFORM3,
	ONEXITCHAPTER
}

func playTakeDamageSound():
	randomPitch.randomize();
	randomSound.randomize();
	var randomPitchNumber = randomPitch.randf_range(0.95, 1);
	var randomSoundPlay= randomSound.randi_range(0, 4);
	var takeDamageSound = takeDamage[randomSoundPlay]
	if !takeDamageSound.playing:
		takeDamageSound.pitch_scale = randomPitchNumber;
		takeDamageSound.play();


#Declare Functions
func stopWalkSound():
	randomPitch.randomize();
	var randomPitchNumber = randomPitch.randf_range(0.95, 1);
	footsteps.pitch_scale = randomPitchNumber
	walkingMovement.pitch_scale = randomPitchNumber
	footsteps.stop();
	walkingMovement.stop();

func playLandSound(velocityImpact, addedPitch):
	randomPitch.randomize();
	var randomPitchNumber = randomPitch.randf_range(0.95, 1);
	landImpact.volume_db = velocityImpact;
	landImpact.pitch_scale = randomPitchNumber + addedPitch;
	landImpact.play();

func playWalkSound():
	randomPitch.randomize();
	var randomPitchNumber = randomPitch.randf_range(0.95, 1);
	footsteps.pitch_scale = randomPitchNumber
	walkingMovement.pitch_scale = randomPitchNumber
	if !footsteps.playing && !walkingMovement.playing:
		footsteps.play();
		walkingMovement.play();

func playJumpSound():
	randomPitch.randomize();
	randomSound.randomize();
	var randomPitchNumber = randomPitch.randf_range(0.95, 1);
	var randomSoundPlay= randomSound.randi_range(0, 1);
	var jumpImpactSound = jumpImpact[randomSoundPlay]
	jumpImpactSound.pitch_scale = randomPitchNumber
	jumpMovement.pitch_scale = randomPitchNumber
	jumpImpactSound.play();
	jumpMovement.play();

func _ready():
	stateMachine = IDLE

func _process(_delta):
	if Global.movementEnabled:
		$Light2D/AnimationPlayer.stop();
		$Light2D.energy = 0;
		mode = 2;
		if Input.is_action_pressed("move_right") || Input.is_action_pressed("move_left"):
			if !isonPlatform && !isonPlatform2 && !isonPlatform3 && !isonExit:
				stateMachine = WALKING;
			if Input.is_action_just_pressed("jump"):
				stateMachine = JUMPING;
		if !Input.is_action_pressed("move_right") || !Input.is_action_pressed("move_left"):
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
				stopWalkSound();
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
					playJumpSound();
					state.apply_central_impulse(Vector2(horVel, jumpForce));
					isJumping = true;
					animations.play("In the Air");
					if isonPlatform:
						stateMachine = ONPLATFORM;
					elif isonPlatform2:
						stateMachine = ONPLATFORM2;
					elif isonExit:
						stateMachine = ONEXITCHAPTER;
					else:
						stateMachine = IDLE;
		WALKING:
			#WALKING State logic while the player is in the air or on the floor
			if isOnFloor:
				animations.play("Walk")
				playWalkSound();
			else:
				animations.play("In the Air")
				stopWalkSound();
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
						#While on Platform change apply platform velocity to the main character
			if Input.is_action_pressed("move_left") && !Input.is_action_pressed("move_right"):
				#While moving left
				animations.flip_h = 1;
				# if the player is not jumping logic
				if !isJumping:
					playWalkSound();
					animations.play("Walk")
					state.set_linear_velocity(Vector2(Global.getPlatformVelocity.x + - 1 * walkingSpeed, vertvel));
				else:
				#if the playr is jumping logic 
					animations.play("Idle");
					stopWalkSound();
					#While on air, change from setting the linear velocity to applying central impulse
					state.set_linear_velocity(Vector2(Global.getPlatformVelocity.x + - 1 * walkingSpeed, vertvel));
			elif Input.is_action_pressed("move_right") && !Input.is_action_pressed("move_left"):
				#While moving right
				animations.flip_h = 0;
				if !isJumping:
					# if the player is not jumping logic
					playWalkSound();
					animations.play("Walk")
					state.set_linear_velocity(Vector2(Global.getPlatformVelocity.x + walkingSpeed,vertvel));
				else:
					#if the playr is jumping logic 
					animations.play("Idle");
					stopWalkSound();
					#While on air, change from setting the linear velocity to applying central impulse
					state.set_linear_velocity(Vector2(Global.getPlatformVelocity.x + walkingSpeed, vertvel));
			elif Input.is_action_just_released("move_left") || Input.is_action_just_released("move_right"):
				#If the player is not pressing any buttons
				animations.play("Idle");
				stopWalkSound();
				state.set_linear_velocity(Vector2(Global.getPlatformVelocity.x, vertvel));
		ONPLATFORM2:
			#While on Platform change apply platform velocity to the main character
			if Input.is_action_pressed("move_left") && !Input.is_action_pressed("move_right"):
				#While moving left
				animations.flip_h = 1;
				# if the player is not jumping logic
				if !isJumping:
					animations.play("Walk")
					playWalkSound();
					state.set_linear_velocity(Vector2(Global.getPlatform2Velocity.x + - 1 * walkingSpeed, vertvel));
				else:
				#if the playr is jumping logic 
					animations.play("Idle");
					stopWalkSound();
					#While on air, change from setting the linear velocity to applying central impulse
					state.set_linear_velocity(Vector2(Global.getPlatform2Velocity.x + - 1 * walkingSpeed, vertvel));
			elif Input.is_action_pressed("move_right") && !Input.is_action_pressed("move_left"):
				#While moving right
				animations.flip_h = 0;
				if !isJumping:
					# if the player is not jumping logic
					animations.play("Walk")
					playWalkSound();
					state.set_linear_velocity(Vector2(Global.getPlatform2Velocity.x + walkingSpeed,vertvel));
				else:
					#if the playr is jumping logic 
					animations.play("Idle");
					stopWalkSound();
					#While on air, change from setting the linear velocity to applying central impulse
					state.set_linear_velocity(Vector2(Global.getPlatform2Velocity.x + walkingSpeed, vertvel));
			elif Input.is_action_just_released("move_left") || Input.is_action_just_released("move_right"):
				#If the player is not pressing any buttons
				animations.play("Idle");
				stopWalkSound()
				state.set_linear_velocity(Vector2(Global.getPlatform2Velocity.x, vertvel));
		ONPLATFORM3:
			#While on Platform change apply platform velocity to the main character
			if Input.is_action_pressed("move_left") && !Input.is_action_pressed("move_right"):
				#While moving left
				animations.flip_h = 1;
				# if the player is not jumping logic
				if !isJumping:
					animations.play("Walk")
					playWalkSound()
					state.set_linear_velocity(Vector2(Global.getPlatform3Velocity.x + - 1 * walkingSpeed, vertvel));
				else:
				#if the playr is jumping logic 
					animations.play("Idle");
					stopWalkSound();
					#While on air, change from setting the linear velocity to applying central impulse
					state.set_linear_velocity(Vector2(Global.getPlatform3Velocity.x + - 1 * walkingSpeed, vertvel));
			elif Input.is_action_pressed("move_right") && !Input.is_action_pressed("move_left"):
				#While moving right
				animations.flip_h = 0;
				if !isJumping:
					# if the player is not jumping logic
					animations.play("Walk")
					playWalkSound();
					state.set_linear_velocity(Vector2(Global.getPlatform3Velocity.x + walkingSpeed,vertvel));
				else:
					#if the playr is jumping logic 
					animations.play("Idle");
					stopWalkSound();
					#While on air, change from setting the linear velocity to applying central impulse
					state.set_linear_velocity(Vector2(Global.getPlatform3Velocity.x + walkingSpeed, vertvel));
			elif Input.is_action_just_released("move_left") || Input.is_action_just_released("move_right"):
				#If the player is not pressing any buttons
				animations.play("Idle");
				stopWalkSound()
				state.set_linear_velocity(Vector2(Global.getPlatform3Velocity.x, vertvel));
		ONEXITCHAPTER:
			#While on Platform change apply platform velocity to the main character
			if Input.is_action_pressed("move_left") && !Input.is_action_pressed("move_right"):
				#While moving left
				animations.flip_h = 1;
				# if the player is not jumping logic
				if !isJumping:
					animations.play("Walk")
					playWalkSound();
					state.set_linear_velocity(Vector2(Global.getExitChapterVelocity.x + - 1 * walkingSpeed, vertvel));
				else:
				#if the playr is jumping logic 
					animations.play("Idle");
					stopWalkSound();
					#While on air, change from setting the linear velocity to applying central impulse
					state.set_linear_velocity(Vector2(Global.getExitChapterVelocity.x + - 1 * walkingSpeed, vertvel));
			elif Input.is_action_pressed("move_right") && !Input.is_action_pressed("move_left"):
				#While moving right
				animations.flip_h = 0;
				if !isJumping:
					# if the player is not jumping logic
					animations.play("Walk")
					playWalkSound();
					state.set_linear_velocity(Vector2(Global.getExitChapterVelocity.x + walkingSpeed,vertvel));
				else:
					#if the playr is jumping logic 
					animations.play("Idle");
					stopWalkSound();
					#While on air, change from setting the linear velocity to applying central impulse
					state.set_linear_velocity(Vector2(Global.getExitChapterVelocity.x + walkingSpeed, vertvel));
			elif Input.is_action_just_released("move_left") || Input.is_action_just_released("move_right"):
				#If the player is not pressing any buttons
				animations.play("Idle");
				stopWalkSound();
				state.set_linear_velocity(Vector2(Global.getExitChapterVelocity.x, vertvel));
	
func _on_RigidBody2D_body_entered(body):
	isJumping = false;
	isOnFloor = true;
	playLandSound(0, 0.05);
	if body.is_in_group("platform"):
		stateMachine = ONPLATFORM;
		isonPlatform = true;
		isOnFloor = true;
	elif body.is_in_group("platform2"):
		stateMachine = ONPLATFORM2;
		isonPlatform2 = true;
		isOnFloor = true;
	elif body.is_in_group("platform3"):
		stateMachine = ONPLATFORM3;
		isonPlatform3 = true;
		isOnFloor = true;
	elif body.is_in_group("exitChapter"):
		isonExit = true;
		stateMachine = ONEXITCHAPTER;
		isOnFloor = true;
	elif body.is_in_group("cannonball"):
		playTakeDamageSound();


func _on_RigidBody2D_body_exited(body):
	if !body.is_in_group("wall"):
		isOnFloor = false;
	if body.is_in_group("platform"):
		isonPlatform = false;
	elif body.is_in_group("platform2"):
		isonPlatform2 = false;
	elif body.is_in_group("platform3"):
		isonPlatform3 = false;
	elif body.is_in_group("exitChapter"):
		isonExit = false;
