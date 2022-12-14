extends RigidBody2D

#Booleans
var isPlaced = false;
var canbeDestroyed = false;

#Variables
var mousePos;
var currentRotation;
var presses = 0;

func _physics_process(_delta):
	#Change to Kinematic or Rigid Mode
	if !Global.movementEnabled:
		mode = 1;
	else:
		mode = 0;
	#Shape Movement, Rotation and Placement
	if !isPlaced:
		global_position = get_global_mouse_position();
		mousePos = get_global_mouse_position();
		currentRotation = rotation;
		if Input.is_action_pressed("move_left"):
			rotation -= 0.05;
		if Input.is_action_pressed("move_right"):
			rotation += 0.105;
		if Input.is_action_just_pressed("placeMaterial"):
			global_position = mousePos;
			rotation = currentRotation;
			if Global.checkpointIndex > 0:
				Global.materials -= 1;
			isPlaced = true;

func _input(event):
	#Destroy if not placed5
	if event.is_action_pressed("Material1") || event.is_action_pressed("Material2") || event.is_action_pressed("Material3") || event.is_action_pressed("Material4") || event.is_action_pressed("stacking_mode_enable"):
		if !isPlaced:
			queue_free();
