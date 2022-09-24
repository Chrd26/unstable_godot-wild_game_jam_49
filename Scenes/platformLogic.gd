extends RigidBody2D
var pos1 = Vector2(-3349,-184);
var pos2 = Vector2(-3349, -1250);
var pos3 = Vector2(2300, -1250);
var hasStarted = false;
var hasBallTimerStarted = false;
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(_delta):
	Global.getPlatformVelocity = linear_velocity;
	Global.getPlatformPosition = global_position;

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		if !hasStarted:
			$movingplatform2tween.interpolate_property(self, "position", pos1, pos2, 10, Tween.TRANS_QUAD, Tween.EASE_IN_OUT);
			$movingplatform2tween.interpolate_property(self, "position", pos2, pos3, 30, Tween.TRANS_QUAD, Tween.EASE_IN_OUT, 10);
			$movingplatform2tween.start();
			Global.hashand1Startedmoving = true;
			hasStarted = true;


func _on_movingplatform2tween_tween_all_completed():
	Global.hashand1Startedmoving = false;
	$deletePlatform.start();


func _on_deletePlatform_timeout():
	queue_free()
