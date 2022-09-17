extends Node2D
var randomPlay = RandomNumberGenerator.new();
var randomPitch = RandomNumberGenerator.new();


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomPlay.randomize();
	randomPitch.randomize();
	var randomPlaySound = randomPlay.randi_range(0, 1);
	var randomPitchNumber = randomPitch.randf_range(0.9, 1);
	if Global.hasActivatedBuilding:
		if randomPlaySound ==1:
			$EnableBuildMode1.pitch_scale = randomPitchNumber;
			$EnableBuildMode1.play();
		else:
			$EnableBuildMode2.pitch_scale = randomPitchNumber;
			$EnableBuildMode2.play();
	if !Global.hasActivatedBuilding:
		$EnableBuildMode1.pitch_scale = randomPitchNumber;
		$DisableBuildMode.play();

func _on_EnableBuildMode1_finished():
	queue_free();


func _on_EnableBuildMode2_finished():
	queue_free();


func _on_DisableBuildMode_finished():
	queue_free();
