extends RigidBody2D
onready var tween = get_node("Tween");
var startPos = Vector2(0, -108);
var endPos = Vector2(0, 880);
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _physics_process(_delta):
	Global.getPlatform2Velocity = linear_velocity;
	if Global.checkpointIndex == 5:
		queue_free();


# Called when the node enters the scene tree for the first time.
func _ready():
	tween.interpolate_property(self, "position", startPos,  endPos, 4, Tween.TRANS_QUAD, Tween.EASE_IN_OUT);
	tween.interpolate_property(self, "position", endPos,  startPos, 4, Tween.TRANS_QUAD, Tween.EASE_IN_OUT, 4);
	tween.start();


func _on_Area2D_area_entered(_area):
	Global.hasPlatform2Started = true;


func _on_Area2D_area_exited(_area):
	Global.hasPlatform2Started = false;
