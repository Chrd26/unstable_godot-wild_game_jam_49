extends Node2D
var pos1 = Vector2(14667, 712);
var pos2 = Vector2(14667, -2559);
var pos3 = Vector2(18696, -2559);

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	pass;


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		$RigidBody2D/handtween.interpolate_property(self, "position", pos1, pos2, 10, Tween.TRANS_QUAD, Tween.EASE_IN_OUT);
		$RigidBody2D/handtween.interpolate_property(self, "position", pos2, pos3, 10, Tween.TRANS_QUAD, Tween.EASE_IN_OUT, 10)
		$RigidBody2D/handtween.start();
