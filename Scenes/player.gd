extends RigidBody2D
onready var playerAnim = $AnimatedSprite;
const gravity = 60;
const jumpForce = -1200;
var isonfloor = true;
var speed = 400;
var movePos;
var playJumpRandom = RandomNumberGenerator.new();
var takeDamageRandom = RandomNumberGenerator.new();
var randomPitch = RandomNumberGenerator.new();
var isonPlatform = false;

func _physics_process(_delta):
	if Global.stackingMode:
		$Light2D/AnimationPlayer.play("light");
	else:
		$Light2D/AnimationPlayer.stop();
		$Light2D.energy = 0;
	var vertVel = get_linear_velocity().y;
	if Global.movementEnabled:
		self.mode = 2;
		if Input.is_action_pressed("move_right") || Input.is_action_pressed("movement_left") && Input.is_action_just_pressed("move_right"):
			if !isonPlatform:
				set_linear_velocity(Vector2(speed, vertVel));
			else:
				set_linear_velocity(Vector2(Global.getPlatformVelocity.x + speed, vertVel));
			if Input.is_action_just_pressed("jump") && isonfloor || Global.isonMaterial && Input.is_action_just_pressed("jump") :
				$Audio/Footsteps.stop();
				$Audio/Movement.stop();
				Global.isjumping = true;
				if !isonPlatform:
					apply_impulse(Vector2(), Vector2(0, jumpForce));
				else:
					apply_impulse(Vector2(), Vector2(0, Global.getPlatformVelocity.y + jumpForce))
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
			if !isonPlatform:
				set_linear_velocity(Vector2(-speed, vertVel));
			else:
				set_linear_velocity(Vector2(Global.getPlatformVelocity.x + speed * -1, vertVel));
			if Input.is_action_just_pressed("jump") && isonfloor || Global.isonMaterial && Input.is_action_just_pressed("jump"):
				$Audio/Footsteps.stop();
				$Audio/Movement.stop();
				Global.isjumping = true;
				if !isonPlatform:
					apply_impulse(Vector2(), Vector2(0, jumpForce));
				else:
					apply_impulse(Vector2(), Vector2(0, Global.getPlatformVelocity.y + jumpForce));
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
			if !isonPlatform:
				apply_impulse(Vector2(), Vector2(0, jumpForce));
			else:
				apply_impulse(Vector2(), Vector2(0, Global.getPlatformVelocity.y + jumpForce));
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
			if !isonPlatform:
				if Global.isjumping || !isonfloor:
					set_linear_velocity(Vector2(0, vertVel));
			else:
				if Global.isjumping || !isonfloor:
					set_linear_velocity(Vector2(0, Global.getPlatformVelocity.y + vertVel));
		if Input.is_action_just_pressed("jump") && Input.is_action_pressed("movement_left"):
			playerAnim.play("Idle");
			playerAnim.flip_h = 1;
		if Input.is_action_just_pressed("jump") && Input.is_action_pressed("move_right"):
			playerAnim.play("Idle");
			playerAnim.flip_h = 0;
	else:
		self.mode = 3;
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
		movePos = get_linear_velocity().x
		if Global.enemyGetPOS < 0 && movePos > 0 || Global.enemyGetPOS < 0 && movePos < 0 || Global.enemyGetPOS < 0 && movePos == 0:
			apply_impulse(Vector2(), Vector2(-10000, -jumpForce));
			Global.takeDamage = false;
		elif Global.enemyGetPOS > 0 && movePos < 0 || Global.enemyGetPOS > 0 && movePos > 0 || Global.enemyGetPOS > 0 && movePos == 0:
			apply_impulse(Vector2(), Vector2(10000, -jumpForce));
			Global.takeDamage = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	playerAnim.play("Idle");

func _on_playerArea_body_entered(body):
	if Global.movementEnabled:
		if body.is_in_group("platform"):
			print("platform");
			isonPlatform = true;
			isonfloor = true;
			if !$Audio/landImpact.playing && Global.isjumping:
				$Audio/landImpact.play();
				Global.isjumping = false;
		if body.is_in_group("floor") || body.is_in_group("hand"):
			isonfloor = true;
			gravity_scale = 20;
			if !$Audio/landImpact.playing && Global.isjumping:
				$Audio/landImpact.play();
				Global.isjumping = false;
		if body.is_in_group("wall"):
			physics_material_override.friction = 0;


func _on_playerArea_body_exited(body):
	if Global.movementEnabled:
		if body.is_in_group("platform"):
			print("exitplatform");
			isonPlatform = false;
			isonfloor = false;
			if !Global.isjumping:
				gravity_scale = 40;
			else:
				gravity_scale = 20;
		if body.is_in_group("floor") || body.is_in_group("hand") || body.is_in_group("material"):
			print("exitfloor")
			isonfloor = false;
			if !Global.isjumping:
				gravity_scale = 40;
			else:
				gravity_scale = 20;
		if body.is_in_group("wall"):
			physics_material_override.friction = 0.3;
