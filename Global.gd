extends Node2D
var movementEnabled = true;
var materialsLeft;
var stackingMode = false;
var buttonPresses = 0;
var lives = 3;
var isonfloor = false;
var isonMaterial = false;
var materials = 10;
var lostLife = false;
var getlife = true;
var takeDamage = false;
var enemyGetPOS;
var changeSide = false;




# Called when the node enters the scene tree for the first time.
func _ready():
	pass;

func _process(_delta):
	position = get_global_mouse_position();
	
	if Input.is_action_just_pressed("stacking_mode_enable"):
		Global.stackingMode = true;
		Global.movementEnabled = false;
		print("stacking mode");
	if Input.is_action_just_pressed("stacking_mode_enable") && stackingMode == true:
		Global.buttonPresses += 1;
	if buttonPresses == 2:
		Global.stackingMode = false;
		Global.movementEnabled = true;
		print("resume movement");
		Global.buttonPresses = 0;
