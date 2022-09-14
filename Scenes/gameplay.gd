extends Node2D
var materialSpawn;

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(_delta):
	if Global.materials > 0:
		if Input.is_action_just_pressed("Material1") && Global.stackingMode:
			print("mat1");
			var material = load("res://Scenes/Material_1.tscn");
			materialSpawn = material.instance();
			add_child(materialSpawn);
		if Input.is_action_just_pressed("Material2") && Global.stackingMode:
			print("mat2");
			var material = load("res://Scenes/Material2.tscn");
			materialSpawn = material.instance();
			add_child(materialSpawn);
