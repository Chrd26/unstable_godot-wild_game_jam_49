extends RigidBody2D
var randomizeX = RandomNumberGenerator.new();
var randomSpawn = RandomNumberGenerator.new();
var randomPitch = RandomNumberGenerator.new();
var pos1 = Vector2(-340, -1589);
var pos2 = Vector2(452, -1532);
var pos3 = Vector2(1217, -1532);
var pos4 = Vector2(2039, -1532);
var pos5 = Vector2(2880, -1532);
var pos6 = Vector2(3706, -1532);
var pos7 = Vector2(4544, -1532);

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomSpawn.randomize();
	var randomspawmNumber = randomSpawn.randi_range(0, 6);
	match randomspawmNumber:
		0:
			position = pos1;
		1:
			position = pos2;
		2:
			position = pos3;
		3:
			position = pos4;
		4:
			position = pos5;
		5: 
			position = pos6;
		6:
			position = pos7;
	randomPitch.randomize();
	var randomPitchNumber = randomPitch.randf_range(0.9, 1);
	$cannonShoot.pitch_scale = randomPitchNumber;
	randomizeX.randomize();
	var randomizeXNumber = randomizeX.randf_range(-50, 50);
	apply_impulse(Vector2(), Vector2(randomizeXNumber, 500));
	

func _on_Area2D_body_entered(body):
	if !$BallImpact.playing:
		randomPitch.randomize();
		var randomPitchNumber = randomPitch.randf_range(0.9, 1.0);
		$BallImpact.pitch_scale = randomPitchNumber;
		$BallImpact.play();
	if body.is_in_group("player"):
		queue_free();
		Global.lives -= 1;
	if body.is_in_group("material"):
		pass;




func _on_Timer_timeout():
	queue_free();
