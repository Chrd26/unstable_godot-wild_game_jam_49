extends Node2D
var randomSound = RandomNumberGenerator.new()
var randomPitch = RandomNumberGenerator.new()


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomSound.randomize();
	randomPitch.randomize();
	var randomSoundIndex = randomSound.randi_range(0, 4);
	var randomPitchNumber = randomPitch.randf_range(0.9, 1);
	if randomSoundIndex == 0:
		$outofShapes1.pitch_scale = randomPitchNumber;
		$outofShapes1.play();
	elif randomSoundIndex == 1:
		$outofShapes2.pitch_scale = randomPitchNumber;
		$outofShapes2.play();
	elif randomSoundIndex == 2:
		$outofShapes3.pitch_scale = randomPitchNumber;
		$outofShapes3.play();
	elif randomSoundIndex == 3:
		$outofShapes4.pitch_scale = randomPitchNumber;
		$outofShapes4.play();
	else:
		$outofShapes5.pitch_scale = randomPitchNumber;
		$outofShapes5.play();


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_outofShapes1_finished():
	queue_free();


func _on_outofShapes2_finished():
	queue_free();


func _on_outofShapes3_finished():
	queue_free();


func _on_outofShapes4_finished():
	queue_free();


func _on_outofShapes5_finished():
	queue_free();
