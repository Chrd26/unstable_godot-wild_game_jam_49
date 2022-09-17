extends Node2D
var randomPlay = RandomNumberGenerator.new();
var randomPitch = RandomNumberGenerator.new();


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomPitch.randomize();
	randomPlay.randomize();
	var randomPitchNumber = randomPitch.randf_range(0.9, 1);
	var randomPlaySound = randomPlay.randi_range(0, 3);
	if randomPlaySound == 0:
		$BuffGather1.pitch_scale = randomPitchNumber;
		$BuffGather1.play();
	elif randomPlaySound == 1:
		$BuffGather2.pitch_scale = randomPitchNumber;
		$BuffGather2.play();
	elif randomPlaySound == 2:
		$BuffGather3.pitch_scale = randomPitchNumber;
		$BuffGather3.play();
	else:
		$BuffGather4.pitch_scale = randomPitchNumber;
		$BuffGather4.play();


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BuffGather1_finished():
	queue_free();


func _on_BuffGather2_finished():
	queue_free();


func _on_BuffGather3_finished():
	queue_free();


func _on_BuffGather4_finished():
	queue_free();
