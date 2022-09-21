extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("background");


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	Global.materials = 10;
	Global.lives = 3;
	Global.chapterNumber = 1;
	Global.hasgameStarted = true;
	Global.haspressedBegin = true;
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Chapter1.tscn");
	
