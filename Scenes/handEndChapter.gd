extends RigidBody2D

var pos1 = Vector2(14561, 422);
var pos2 = Vector2(14667, -2244);
var pos3 = Vector2(20047, -2559);
var hasStarted = false;

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(_delta):
	Global.getExitChapterVelocity = linear_velocity;



func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		if !hasStarted:
			$handtween.interpolate_property(self, "position", pos1, pos2, 10, Tween.TRANS_QUAD, Tween.EASE_IN_OUT);
			$handtween.interpolate_property(self, "position", pos2, pos3, 10, Tween.TRANS_QUAD, Tween.EASE_IN_OUT, 10)
			$handtween.start();
			Global.hasexitChapterStarted = true;
			hasStarted = true;



func _on_handtween_tween_all_completed():
	$Timer.start();
	Global.hasOutroStarted = true;


func _on_Timer_timeout():
	Global.isChapter1Finished = true;
