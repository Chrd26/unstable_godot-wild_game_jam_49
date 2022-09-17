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
	var randomSoundIndex = randomSound.randi_range(0, 3);
	var randomPitchNumber = randomPitch.randf_range(0.9, 1);
	if randomSoundIndex == 0:
		$shapeSelect1.pitch_scale = randomPitchNumber;
		$shapeSelect1.play();
	elif randomSoundIndex == 1:
		$shapeSelect2.pitch_scale = randomPitchNumber;
		$shapeSelect2.play();
	elif randomSoundIndex == 2:
		$shapeSelect3.pitch_scale = randomPitchNumber;
		$shapeSelect3.play();
	else:
		$shapeSelect4.pitch_scale = randomPitchNumber;
		$shapeSelect4.play();



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_shapeSelect1_finished():
	queue_free();


func _on_shapeSelect2_finished():
	queue_free();


func _on_shapeSelect3_finished():
	queue_free();


func _on_shapeSelect4_finished():
	queue_free();
