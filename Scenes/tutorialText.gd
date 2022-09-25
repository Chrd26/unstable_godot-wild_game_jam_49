extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	#label1
	$tutorial.interpolate_property($Label1, "percent_visible", 0,   1, 4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT);
	$tutorial.interpolate_property($Label1, "percent_visible", 1, 0, 2 , Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 5);
	#label2
	$tutorial.interpolate_property($Label2, "percent_visible", 0,   1, 4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT,7);
	$tutorial.interpolate_property($Label2, "percent_visible", 1, 0, 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 12);
	#label3
	$tutorial.interpolate_property($Label3, "percent_visible", 0,   1, 4,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT,14);
	$tutorial.interpolate_property($Label3, "percent_visible", 1, 0, 2,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 19);
	#label4
	$tutorial.interpolate_property($Label4, "percent_visible", 0,   1, 4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 21);
	$tutorial.interpolate_property($Label4, "percent_visible", 1, 0, 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 26);
	#label5
	$tutorial.interpolate_property($Label5, "percent_visible", 0,   1, 4, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT,28);
	$tutorial.interpolate_property($Label5, "percent_visible", 1, 0, 2,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 33);
	#label6
	$tutorial.interpolate_property($Label6, "percent_visible", 0,   1, 4,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT,35);
	$tutorial.interpolate_property($Label6, "percent_visible", 1,   0, 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT,40);
	$tutorial.start();



func _on_tutorial_tween_completed(_object, _key):
	pass;
