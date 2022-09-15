extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.changeside:
		apply_impulse(Vector2(), Vector2(-100, 0));


func _physics_process(delta):
	pass;
	

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		Global.takeDamage = true;
		queue_free();

func _on_Timer_timeout():
	queue_free();
