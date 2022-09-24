extends RigidBody2D
onready var playerAnim = $AnimatedSprite;
const jumpForce = -5000;
var isonfloor = true;
var speed = 400;
var movePos;
var playJumpRandom = RandomNumberGenerator.new();
var takeDamageRandom = RandomNumberGenerator.new();
var randomPitch = RandomNumberGenerator.new();
var isonPlatform = false;
var isonPlatform2 = false;
var isonPlatform3 = false;
var isonExitChapter = false;

func _integrate_forces(_state):
	if Global.stackingMode:
		$Light2D/AnimationPlayer.play("light");
		$Light2D.energy = 1;
	else:
		$Light2D/AnimationPlayer.stop();
		$Light2D.energy = 0;
	var vertVel = get_linear_velocity().y;
	if Global.movementEnabled:
		if Input.is_action_pressed("move_right") || Input.is_action_pressed("movement_left") && Input.is_action_just_pressed("move_right"):
			if isonPlatform:
				set_linear_velocity(Vector2(Global.getPlatformVelocity.x + speed, vertVel));
			elif isonPlatform2:
				set_linear_velocity(Vector2(Global.getPlatform2Velocity.x + speed, vertVel));
			elif isonPlatform3:
				set_linear_velocity(Vector2(Global.getPlatform3Velocity.x + speed, vertVel));
			elif isonExitChapter:
				set_linear_velocity(Vector2(Global.getExitChapterVelocity.x + speed, vertVel));
			else:
				set_linear_velocity(Vector2(speed, vertVel));
			if Input.is_action_just_pressed("jump") && isonfloor || Global.isonMaterial && Input.is_action_just_pressed("jump"):
				$Audio/Footsteps.stop();
				$Audio/Movement.stop();
				Global.isjumping = true;
				if isonPlatform:
					apply_impulse(Vector2(), Vector2(0, Global.getPlatformVelocity.y + jumpForce));
				elif isonPlatform2:
					apply_impulse(Vector2(), Vector2(0, Global.getPlatform2Velocity.y + jumpForce));
				elif isonPlatform3:
					apply_impulse(Vector2(), Vector2(0, Global.getPlatform3Velocity.y + jumpForce));
				elif isonExitChapter:
					apply_impulse(Vector2(), Vector2(0, Global.getExitChapterVelocity.y + jumpForce));
				else:
					apply_impulse(Vector2(), Vector2(0, jumpForce));
				playJumpRandom.randomize();
				var randomNumber = playJumpRandom.randi_range(0, 1);
				if randomNumber == 1:
					randomPitch.randomize();
					var randomPitchNumber = randomPitch.randf_range(0.95, 1);
					$Audio/JumpImpact1.pitch_scale = randomPitchNumber;
					$Audio/JumpMovement.pitch_scale = randomPitchNumber;
					$Audio/JumpImpact1.play();
					$Audio/JumpMovement.play();
				else:
					randomPitch.randomize();
					var randomPitchNumber = randomPitch.randf_range(0.95, 1);
					$Audio/JumpImpact2.pitch_scale = randomPitchNumber;
					$Audio/JumpMovement.pitch_scale = randomPitchNumber;
					$Audio/JumpImpact2.play();
					$Audio/JumpMovement.play();
			if isonfloor && !Global.isjumping || Global.isonMaterial && !Global.isjumping:
				playerAnim.play("Walk");
				playerAnim.flip_h = 0;
				if !$Audio/Footsteps.playing:
					randomPitch.randomize();
					var randomPitchNumber = randomPitch.randf_range(0.95, 1);
					$Audio/Footsteps.pitch_scale = randomPitchNumber;
					$Audio/Movement.pitch_scale = randomPitchNumber;
					$Audio/Footsteps.play();
					$Audio/Movement.play();
			if !isonfloor && !Global.isonMaterial:
				playerAnim.play("Idle");
				playerAnim.flip_h = 0;
		elif Input.is_action_pressed("movement_left") || Input.is_action_pressed("move_right") && Input.is_action_just_pressed("movement_left"):
			if isonPlatform:
				set_linear_velocity(Vector2(Global.getPlatformVelocity.x + speed * -1, vertVel));
			elif isonPlatform2:
				set_linear_velocity(Vector2(Global.getPlatform2Velocity.x + speed * -1, vertVel));
			elif isonPlatform3:
				set_linear_velocity(Vector2(Global.getPlatform3Velocity.x + speed * -1, vertVel));
			elif isonExitChapter:
				set_linear_velocity(Vector2(Global.getExitChapterVelocity.x + speed * -1, vertVel));
			else:
				set_linear_velocity(Vector2(-speed, vertVel));
			if Input.is_action_just_pressed("jump") && isonfloor || Global.isonMaterial && Input.is_action_just_pressed("jump"):
				$Audio/Footsteps.stop();
				$Audio/Movement.stop();
				Global.isjumping = true;
				if isonPlatform:
					apply_impulse(Vector2(), Vector2(0, Global.getPlatformVelocity.y + jumpForce));
				elif isonPlatform2:
					apply_impulse(Vector2(), Vector2(0, Global.getPlatform2Velocity.y + jumpForce));
				elif isonPlatform3:
					apply_impulse(Vector2(), Vector2(0, Global.getPlatform3Velocity.y + jumpForce));
				elif isonExitChapter:
					apply_impulse(Vector2(), Vector2(0, Global.getExitChapterVelocity.y + jumpForce));
				else:
					apply_impulse(Vector2(), Vector2(0, jumpForce));
					
				playJumpRandom.randomize();
				var randomNumber = playJumpRandom.randi_range(0, 1);
				if randomNumber == 1:
					randomPitch.randomize();
					var randomPitchNumber = randomPitch.randf_range(0.95, 1);
					$Audio/JumpImpact1.pitch_scale = randomPitchNumber;
					$Audio/JumpMovement.pitch_scale = randomPitchNumber;
					$Audio/JumpImpact1.play();
					$Audio/JumpMovement.play();
				else:
					randomPitch.randomize();
					var randomPitchNumber = randomPitch.randf_range(0.95, 1);
					$Audio/JumpImpact2.pitch_scale = randomPitchNumber;
					$Audio/JumpMovement.pitch_scale = randomPitchNumber;
					$Audio/JumpImpact2.play();
					$Audio/JumpMovement.play();
			if isonfloor && !Global.isjumping || Global.isonMaterial && !Global.isjumping:
				playerAnim.play("Walk");
				playerAnim.flip_h = 1;
				if !$Audio/Footsteps.playing:
					randomPitch.randomize();
					var randomPitchNumber = randomPitch.randf_range(0.95, 1);
					$Audio/Footsteps.pitch_scale = randomPitchNumber;
					$Audio/Movement.pitch_scale = randomPitchNumber;
					$Audio/Footsteps.play();
					$Audio/Movement.play();
			if !isonfloor && !Global.isonMaterial:
				playerAnim.play("Idle");
				playerAnim.flip_h = 1;
		elif Input.is_action_just_released("move_right") && !Input.is_action_pressed("movement_left"):
			playerAnim.stop();
			playerAnim.play("Idle");
			playerAnim.flip_h = 0;
			$Audio/Footsteps.stop();
			$Audio/Movement.stop();
		elif Input.is_action_just_released("movement_left") && !Input.is_action_pressed("move_right"):
			playerAnim.stop();
			playerAnim.play("Idle");
			playerAnim.flip_h = 1;
			$Audio/Footsteps.stop();
			$Audio/Movement.stop();
		elif Input.is_action_just_pressed("jump") && isonfloor || Global.isonMaterial && Input.is_action_just_pressed("jump") :
			$Audio/Footsteps.stop();
			$Audio/Movement.stop();
			Global.isjumping = true;
			if isonPlatform:
				apply_impulse(Vector2(), Vector2(0, Global.getPlatformVelocity.y + jumpForce));
			elif isonPlatform2:
				apply_impulse(Vector2(), Vector2(0, Global.getPlatform2Velocity.y + jumpForce));
			elif isonPlatform3:
				apply_impulse(Vector2(), Vector2(0, Global.getPlatform3Velocity.y + jumpForce));
			elif isonExitChapter:
				apply_impulse(Vector2(), Vector2(0, Global.getExitChapterVelocity.y + jumpForce));
			else:
				apply_impulse(Vector2(), Vector2(0, jumpForce));
			playJumpRandom.randomize();
			var randomNumber = playJumpRandom.randi_range(0, 1);
			if randomNumber == 1:
				randomPitch.randomize();
				var randomPitchNumber = randomPitch.randf_range(0.95, 1);
				$Audio/JumpImpact1.pitch_scale = randomPitchNumber;
				$Audio/JumpMovement.pitch_scale = randomPitchNumber;
				$Audio/JumpImpact1.play();
				$Audio/JumpMovement.play();
			else:
				randomPitch.randomize();
				var randomPitchNumber = randomPitch.randf_range(0.95, 1);
				$Audio/JumpImpact2.pitch_scale = randomPitchNumber;
				$Audio/JumpMovement.pitch_scale = randomPitchNumber;
				$Audio/JumpImpact2.play();
				$Audio/JumpMovement.play();
		else:
			if isonPlatform:
				if Global.isjumping || !isonfloor:
					set_linear_velocity(Vector2(0, Global.getPlatformVelocity.y + vertVel));
				elif isonPlatform2:
					if Global.isjumping || !isonfloor:
						set_linear_velocity(Vector2(0, Global.getPlatform2Velocity.y + vertVel));
				elif isonPlatform3 || !isonfloor:
					if Global.isjumping || !isonfloor:
						set_linear_velocity(Vector2(0, Global.getPlatform3Velocity.y + vertVel));
				elif isonExitChapter:
					if Global.isjumping || !isonExitChapter:
						set_linear_velocity(Vector2(0, Global.getExitChapterVelocity.y + vertVel));
			else:
				if Global.isjumping || !isonfloor:
					set_linear_velocity(Vector2(0, vertVel));
		if Input.is_action_just_pressed("jump") && Input.is_action_pressed("movement_left"):
			playerAnim.play("Idle");
			playerAnim.flip_h = 1;
		if Input.is_action_just_pressed("jump") && Input.is_action_pressed("move_right"):
			playerAnim.play("Idle");
			playerAnim.flip_h = 0;
	else:
		#self.mode = 3;
		if $AnimatedSprite.playing:
			playerAnim.stop();
			$Audio/Footsteps.stop();
			$Audio/Movement.stop();
	if Global.takeDamage:
		takeDamageRandom.randomize();
		var damagePlay = takeDamageRandom.randi_range(0, 4); 
		if damagePlay == 0:
			if !$Audio/takeDamage1.playing || !$Audio/takeDamage2.playing  || !$Audio/takeDamage3.playing || !$Audio/takeDamage4.playing || !$Audio/takeDamage5.playing:
				randomPitch.randomize();
				var randomPitchNumber = randomPitch.randf_range(0.95, 1);
				$Audio/takeDamage1.pitch_scale = randomPitchNumber;
				$Audio/takeDamage1.play()
				Global.takeDamage = false;
		elif damagePlay == 1:
			if !$Audio/takeDamage1.playing || !$Audio/takeDamage2.playing  || !$Audio/takeDamage3.playing || !$Audio/takeDamage4.playing || !$Audio/takeDamage5.playing:
				randomPitch.randomize();
				var randomPitchNumber = randomPitch.randf_range(0.95, 1);
				$Audio/takeDamage2.pitch_scale = randomPitchNumber;
				$Audio/takeDamage2.play()
				Global.takeDamage = false;
		elif damagePlay == 2:
			if !$Audio/takeDamage1.playing || !$Audio/takeDamage2.playing  || !$Audio/takeDamage3.playing || !$Audio/takeDamage4.playing || !$Audio/takeDamage5.playing:
				randomPitch.randomize();
				var randomPitchNumber = randomPitch.randf_range(0.95, 1);
				$Audio/takeDamage3.pitch_scale = randomPitchNumber;
				$Audio/takeDamage3.play()
				Global.takeDamage = false;
		elif damagePlay == 3:
			if !$Audio/takeDamage1.playing || !$Audio/takeDamage2.playing  || !$Audio/takeDamage3.playing || !$Audio/takeDamage4.playing || !$Audio/takeDamage5.playing:
				randomPitch.randomize();
				var randomPitchNumber = randomPitch.randf_range(0.95, 1);
				$Audio/takeDamage4.pitch_scale = randomPitchNumber;
				$Audio/takeDamage4.play()
				Global.takeDamage = false;
		else:
			if !$Audio/takeDamage1.playing || !$Audio/takeDamage2.playing  || !$Audio/takeDamage3.playing || !$Audio/takeDamage4.playing || !$Audio/takeDamage5.playing:
				randomPitch.randomize();
				var randomPitchNumber = randomPitch.randf_range(0.95, 1);
				$Audio/takeDamage5.pitch_scale = randomPitchNumber;
				$Audio/takeDamage5.play()
				Global.takeDamage = false;

func _physics_process(_delta):
	if Global.movementEnabled:
		self.mode = 2;
	else:
		self.mode = 3;


# Called when the node enters the scene tree for the first time.
func _ready():
	playerAnim.play("Idle");

func _on_playerArea_body_entered(body):
	if Global.isjumping:
		Global.isjumping = false;
	if body.is_in_group("platform"):
		isonPlatform = true;
		isonfloor = true;
		if !$Audio/landImpact.playing && Global.isjumping:
			$Audio/landImpact.play();
	elif body.is_in_group("platform2"):
		isonPlatform2 = true;
		isonfloor = true;
		if !$Audio/landImpact.playing && Global.isjumping:
			$Audio/landImpact.play();
	elif body.is_in_group("platform3"):
		isonPlatform3 = true;
		isonfloor = true;
		if !$Audio/landImpact.playing && Global.isjumping:
			$Audio/landImpact.play();
	elif body.is_in_group("floor"):
		isonfloor = true;
		if !$Audio/landImpact.playing && Global.isjumping:
			$Audio/landImpact.play();
			Global.isjumping = false;
	elif body.is_in_group("material"):
		Global.isonMaterial = true;
		if !$Audio/landImpact.playing && Global.isjumping:
			$Audio/landImpact.play();
	elif body.is_in_group("exitChapter"):
		isonExitChapter = true;
		isonfloor = true;
		if !$Audio/landImpact.playing && Global.isjumping:
			$Audio/landImpact.play();
			Global.isjumping = false;
		if !$Audio/landImpact.playing && Global.isjumping:
			$Audio/landImpact.play();
			Global.isjumping = false;
	elif body.is_in_group("enemy"):
		if !$Audio/landImpact.playing && Global.isjumping:
			$Audio/landImpact.play();
			Global.isjumping = false;


func _on_playerArea_body_exited(body):
	if body.is_in_group("platform"):
		$Audio/Footsteps.stop();
		$Audio/Movement.stop();
		isonPlatform = false;
		isonfloor = false;
	elif body.is_in_group("platform2"):
		$Audio/Footsteps.stop();
		$Audio/Movement.stop();
		isonPlatform2 = false;
		isonfloor = false;
		if !Global.isjumping:
			gravity_scale = 40;
		else:
			gravity_scale = 20;
	elif body.is_in_group("platform3"):
		$Audio/Footsteps.stop();
		$Audio/Movement.stop();
		isonPlatform3 = false;
		isonfloor = false;
	elif body.is_in_group("exitChapter"):
		$Audio/Footsteps.stop();
		$Audio/Movement.stop();
		isonExitChapter = false;
		isonfloor = false;
	elif  body.is_in_group("material"):
		$Audio/Footsteps.stop();
		$Audio/Movement.stop();
		Global.isonMaterial = false;
	elif body.is_in_group("floor"):
		$Audio/Footsteps.stop();
		$Audio/Movement.stop();
		isonfloor = false;
	elif body.is_in_group("enemy"):
		$Audio/Footsteps.stop();
		$Audio/Movement.stop();
		isonfloor = false;
