extends RigidBody2D
var hasStartedMoving;
var pos1 = Vector2(-67, -264);
var pos2 = Vector2(-67, 1672);
var pos3 = Vector2(1917, 1672);
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(_delta):
	Global.getPlatform3Velocity = linear_velocity;


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		if !hasStartedMoving:
			$platform3Tween.interpolate_property(self, "position", pos1, pos2, 10, Tween.TRANS_QUAD, Tween.EASE_IN_OUT);
			$platform3Tween.interpolate_property(self, "position", pos2, pos3, 8,Tween.TRANS_QUAD, Tween.EASE_IN_OUT, 10);
			$platform3Tween.start();
			hasStartedMoving = true;


func _on_platform3Tween_tween_all_completed():
	$platform3Timer.start();


func _on_platform3Timer_timeout():
	queue_free();
