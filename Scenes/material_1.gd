extends RigidBody2D
var isPlaced = false;
var matPos;





# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass;

func _physics_process(_delta):
	if !isPlaced:
		if Input.is_action_pressed("move_right"):
			self.rotation += 0.05;
		elif Input.is_action_pressed("movement_left"):
			self.rotation -= 0.05;
		self.mode = 3;
		global_position = get_global_mouse_position();
		matPos = global_position;
	if !Global.stackingMode && !isPlaced || Input.is_action_just_pressed("Material1") && !isPlaced || Input.is_action_just_pressed("Material2") && !isPlaced || Input.is_action_just_pressed("Material3") && !isPlaced:
		queue_free();
	if Input.is_action_just_pressed("placeMaterial") && !isPlaced:
		isPlaced = true;
		self.mode = 0;
		global_position = matPos;
		Global.materials -= 1;




func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		Global.isonMaterial = true;
		#print("isonMaterial");


func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		Global.isonMaterial = false;
		#print("isnotonmaterial");
