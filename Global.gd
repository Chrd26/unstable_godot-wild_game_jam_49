extends Node2D
var movementEnabled = true;
var materialsLeft;
var stackingMode = false;
var buttonPresses = 0;
var lives = 3;
var isonfloor = true;
var isonMaterial = false;
var materials = 10;
var lostLife = false;
var getlife = false;
var takeDamage = false;
var enemyGetPOS;
var hasActivatedBuilding = false;
var haspickedUpShape = false;
var chapterNumber = 0;
var checkpointIndex= 0;
var hasgameStarted = false;
var isjumping = false;
var haspressedBegin = false;


# Called when the node enters the scene tree for the first time.
func _ready():
	pass;

func _process(_delta):
	position = get_global_mouse_position();
	
	if Input.is_action_just_pressed("stacking_mode_enable"):
		Global.hasActivatedBuilding = true;
		var buildSound = load("res://Scenes/EnableDisableBuildMode.tscn");
		var playbuildSound = buildSound.instance();
		add_child(playbuildSound);
		Global.stackingMode = true;
		Global.movementEnabled = false;
		print("stacking mode");
	if Input.is_action_just_pressed("stacking_mode_enable") && stackingMode == true:
		Global.buttonPresses += 1;
	if buttonPresses == 2:
		Global.hasActivatedBuilding = false;
		var buildSound = load("res://Scenes/EnableDisableBuildMode.tscn");
		var playbuildSound = buildSound.instance();
		add_child(playbuildSound);
		Global.stackingMode = false;
		Global.movementEnabled = true;
		print("resume movement");
		Global.buttonPresses = 0;
