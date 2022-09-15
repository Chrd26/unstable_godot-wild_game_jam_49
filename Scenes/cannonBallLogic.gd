extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.changeSide:
		apply_impulse(Vector2(), Vector2(-2000, 0));
	else:
		apply_impulse(Vector2(), Vector2(2000, 0)); 

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		Global.takeDamage = true;
		Global.lostLife = true;
		queue_free();
		Global.lives -= 1;
	if body.is_in_group("material"):
		pass;




func _on_Timer_timeout():
	queue_free();
