extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Tween.interpolate_property($Sprite,"modulate", Color(1, 1, 1, 0), Color(1, 1, 1, 1), 1.5, Tween.TRANS_QUAD, Tween.EASE_IN_OUT);
	$Tween.interpolate_property($Sprite,"modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 1.5, Tween.TRANS_QUAD, Tween.EASE_IN_OUT, 1.5);
	$Tween.interpolate_property($Sprite2,"modulate", Color(1, 1, 1, 0), Color(1, 1, 1, 1), 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 3);
	$Tween.interpolate_property($Sprite2,"modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 4.5);
	$Tween.interpolate_property($Sprite3,"modulate", Color(1, 1, 1, 0), Color(1, 1, 1, 1), 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 6);
	$Tween.interpolate_property($Sprite3,"modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 7.4);
	$Tween.start();
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Tween_tween_all_completed():
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/startGame.tscn");
