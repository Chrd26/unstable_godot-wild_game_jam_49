extends RigidBody2D
onready var playerAnim = $AnimatedSprite;
const gravity = 60;
const jumpForce = -550;
var isonfloor = false;
var speed = 400;
var movePos;
var playJumpRandom = RandomNumberGenerator.new();
var takeDamageRandom = RandomNumberGenerator.new();
var randomPitch = RandomNumberGenerator.new();

func _physics_process(_delta):
	var vertVel = get_linear_velocity().y;
	if Global.movementEnabled:
		self.mode = 2;
		if Input.is_action_pressed("move_right") || Input.is_action_pressed("movement_left") && Input.is_action_just_pressed("move_right"):
			set_linear_velocity(Vector2(speed, vertVel));
			if isonfloor || Global.isonMaterial:
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
			set_linear_velocity(Vector2(-speed, vertVel));
			if isonfloor || Global.isonMaterial:
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
			set_linear_velocity(Vector2(0, vertVel));
		if Input.is_action_just_pressed("jump") && Input.is_action_pressed("movement_left"):
			playerAnim.play("Idle");
			playerAnim.flip_h = 1;
		if Input.is_action_just_pressed("jump") && Input.is_action_pressed("move_right"):
			playerAnim.play("Idle");
			playerAnim.flip_h = 0;
	else:
		self.mode = 1;
	if Global.takeDamage:
		takeDamageRandom.randomize();
		var damagePlay = takeDamageRandom.randi_range(0, 4); 
		if damagePlay == 0:
			if !$Audio/takeDamage1.playing || !$Audio/takeDamage2.playing  || !$Audio/takeDamage3.playing || !$Audio/takeDamage4.playing || !$Audio/takeDamage5.playing:
				randomPitch.randomize();
				var randomPitchNumber = randomPitch.randf_range(0.95, 1);
				$Audio/takeDamage1.pitch_scale = randomPitchNumber;
				$Audio/takeDamage1.play()
		elif damagePlay == 1:
			if !$Audio/takeDamage1.playing || !$Audio/takeDamage2.playing  || !$Audio/takeDamage3.playing || !$Audio/takeDamage4.playing || !$Audio/takeDamage5.playing:
				randomPitch.randomize();
				var randomPitchNumber = randomPitch.randf_range(0.95, 1);
				$Audio/takeDamage2.pitch_scale = randomPitchNumber;
				$Audio/takeDamage2.play()
		elif damagePlay == 2:
			if !$Audio/takeDamage1.playing || !$Audio/takeDamage2.playing  || !$Audio/takeDamage3.playing || !$Audio/takeDamage4.playing || !$Audio/takeDamage5.playing:
				randomPitch.randomize();
				var randomPitchNumber = randomPitch.randf_range(0.95, 1);
				$Audio/takeDamage3.pitch_scale = randomPitchNumber;
				$Audio/takeDamage3.play()
		elif damagePlay == 3:
			if !$Audio/takeDamage1.playing || !$Audio/takeDamage2.playing  || !$Audio/takeDamage3.playing || !$Audio/takeDamage4.playing || !$Audio/takeDamage5.playing:
				randomPitch.randomize();
				var randomPitchNumber = randomPitch.randf_range(0.95, 1);
				$Audio/takeDamage4.pitch_scale = randomPitchNumber;
				$Audio/takeDamage4.play()
		else:
			if !$Audio/takeDamage1.playing || !$Audio/takeDamage2.playing  || !$Audio/takeDamage3.playing || !$Audio/takeDamage4.playing || !$Audio/takeDamage5.playing:
				randomPitch.randomize();
				var randomPitchNumber = randomPitch.randf_range(0.95, 1);
				$Audio/takeDamage5.pitch_scale = randomPitchNumber;
				$Audio/takeDamage5.play()
		movePos = get_linear_velocity().x
		if Global.enemyGetPOS < 0 && movePos > 0 || Global.enemyGetPOS < 0 && movePos < 0 || Global.enemyGetPOS < 0 && movePos == 0 || !Global.changeSide && Global.enemyGetPOS == 0 && movePos < 0 ||!Global.changeSide && Global.enemyGetPOS == 0 && movePos > 0:
			apply_impulse(Vector2(), Vector2(-10000, -jumpForce));
			Global.takeDamage = false;
		elif Global.enemyGetPOS > 0 && movePos < 0 || Global.enemyGetPOS > 0 && movePos > 0 || Global.enemyGetPOS > 0 && movePos == 0 || Global.changeSide && Global.enemyGetPOS == 0 && movePos < 0 || Global.changeSide && Global.enemyGetPOS == 0 && movePos > 0:
			apply_impulse(Vector2(), Vector2(10000, -jumpForce));
			Global.takeDamage = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	playerAnim.play("Idle");
	$noisebackground.play("noiseanimated");

func _on_playerArea_body_entered(body):
	if body.is_in_group("floor") || body.is_in_group("hand"):
		isonfloor = true;
		if !$Audio/landImpact.playing:
			$Audio/landImpact.play();


func _on_playerArea_body_exited(body):
	if body.is_in_group("floor") || body.is_in_group("hand"):
		isonfloor = false;
