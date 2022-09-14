extends RigidBody2D
onready var playerAnim = $AnimatedSprite;
var velocity = Vector2(0,0);
const gravity = 60;
const jumpForce = -550;
var isonfloor = false;
var speed = 400;


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _physics_process(_delta):
	var vertVel = get_linear_velocity().y;
	if Global.movementEnabled:
		self.mode = 2;
		if Input.is_action_pressed("move_right") || Input.is_action_pressed("movement_left") && Input.is_action_just_pressed("move_right"):
			set_linear_velocity(Vector2(speed, vertVel));
			playerAnim.play("Walk R");
		elif Input.is_action_pressed("movement_left") || Input.is_action_pressed("move_right") && Input.is_action_just_pressed("movement_left"):
			set_linear_velocity(Vector2(-speed, vertVel));
			playerAnim.play("Walk L");
		elif Input.is_action_just_released("move_right") && !Input.is_action_pressed("movement_left"):
			playerAnim.stop();
			playerAnim.play("Idle R")
		elif Input.is_action_just_released("movement_left") && !Input.is_action_pressed("move_right"):
			playerAnim.stop();
			playerAnim.play("Idle L");
		elif Input.is_action_just_pressed("jump") && isonfloor || Global.isonMaterial && Input.is_action_just_pressed("jump") :
			apply_impulse(Vector2(), Vector2(0, jumpForce));
		else:
			set_linear_velocity(Vector2(0, vertVel));
		if Input.is_action_just_pressed("jump") && Input.is_action_pressed("movement_left"):
			playerAnim.play("Jump L");
		if Input.is_action_just_pressed("jump") && Input.is_action_pressed("move_right"):
			playerAnim.play("Jump R");
	else:
		self.mode = 1;
	

# Called when the node enters the scene tree for the first time.
func _ready():
	playerAnim.play("Idle R");


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body.is_in_group("floor"):
		isonfloor = true;
		print("touchfloor");




func _on_Area2D_body_exited(body):
	if body.is_in_group("floor"):
		isonfloor = false;
		print("leave floor")
