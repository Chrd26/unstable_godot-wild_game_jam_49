extends Node2D
#booleans
var isInstanciated = false;

#Preload
var preloadShapeSound = preload("res://Scenes/changeShape.tscn");
var preloadNoShapessound = preload("res://Scenes/outofshapes.tscn");

#Variables
var state;
var shapeInstance;
var shapeRotation;

#enumeration
enum{
	shape1,
	shape2,
	shape3,
	shape4,
}

func _physics_process(_delta):
	match state:
		#Instantiate Shape 1
		shape1:
			if !isInstanciated:
				if Global.materials > 0:
					var playSwitchSound = preloadShapeSound.instance();
					add_child(playSwitchSound);
					var loadShape1 = load("res://Scenes/Shape1.tscn")
					shapeInstance = loadShape1.instance();
					add_child(shapeInstance);
					isInstanciated = true;
				else:
					var playNoShapesSound = preloadNoShapessound.instance();
					add_child(playNoShapesSound)
		#Instantiate Shape 2
		shape2:
			if !isInstanciated:
				if Global.materials > 0:
					var playSwitchSound = preloadShapeSound.instance();
					add_child(playSwitchSound);
					var loadShape2 = load("res://Scenes/Shape2.tscn")
					shapeInstance = loadShape2.instance();
					add_child(shapeInstance);
					isInstanciated = true;
				else:
					var playNoShapesSound = preloadNoShapessound.instance();
					add_child(playNoShapesSound)
		#Instantiate Shape 3
		shape3:
			if !isInstanciated:
				if Global.materials > 0:
					var playSwitchSound = preloadShapeSound.instance();
					add_child(playSwitchSound);
					var loadShape3 = load("res://Scenes/Shape3.tscn")
					shapeInstance = loadShape3.instance();
					add_child(shapeInstance);
					isInstanciated = true;
				else:
					var playNoShapesSound = preloadNoShapessound.instance();
					add_child(playNoShapesSound)
		#Instantiate Shape 4
		shape4:
			if !isInstanciated:
				if Global.materials > 0:
					var playSwitchSound = preloadShapeSound.instance();
					add_child(playSwitchSound);
					var loadShape4 = load("res://Scenes/Shape4.tscn")
					shapeInstance = loadShape4.instance();
					add_child(shapeInstance);
					isInstanciated = true;
				else:
					var playNoShapesSound = preloadNoShapessound.instance();
					add_child(playNoShapesSound)

func _input(event):
	#Activate Input Events if Player is in building mode
	if Global.hasActivatedBuilding:
			if event.is_action_pressed("Material1"):
				if Global.materials > 0:
					state = shape1;
					isInstanciated = false;
				else:
					var playsound = preloadNoShapessound.instance();
					add_child(playsound);
			elif event.is_action_pressed("Material2"):
				if Global.materials > 0:
					state = shape2;
					isInstanciated = false;
				else:
					var playsound = preloadNoShapessound.instance();
					add_child(playsound);
			elif event.is_action_pressed("Material3"):
				if Global.materials > 0:
					state = shape3;
					isInstanciated = false;
				else:
					var playsound = preloadNoShapessound.instance();
					add_child(playsound);
			elif event.is_action_pressed("Material4"):
				if Global.materials > 0:
					state = shape4;
					isInstanciated = false;
				else:
					var playsound = preloadNoShapessound.instance();
					add_child(playsound);

