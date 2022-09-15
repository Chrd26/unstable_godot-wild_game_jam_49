extends RigidBody2D
onready var playerAnim = $AnimatedSprite;
const gravity = 60;
const jumpForce = -550;
var isonfloor = false;
var speed = 400;
var movePos;


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _physics_process(_delta):
	var vertVel = get_linear_velocity().y;
	if Global.movementEnabled:
		self.mode = 2;
		if Input.is_action_pressed("move_right") || Input.is_action_pressed("movement_left") && Input.is_action_just_pressed("move_right"):
			set_linear_velocity(Vector2(speed, vertVel));
			if isonfloor || Global.isonMaterial:
				playerAnim.play("Walk");
				playerAnim.flip_h = 0;
				if !isonfloor && !Global.isonMaterial:
					playerAnim.play("Idle");
					playerAnim.flip_h = 0;
		elif Input.is_action_pressed("movement_left") || Input.is_action_pressed("move_right") && Input.is_action_just_pressed("movement_left"):
			set_linear_velocity(Vector2(-speed, vertVel));
			if isonfloor || Global.isonMaterial:
				playerAnim.play("Walk");
				playerAnim.flip_h = 1;
			if !isonfloor && !Global.isonMaterial:
				playerAnim.play("Idle");
				playerAnim.flip_h = 1;
		elif Input.is_action_just_released("move_right") && !Input.is_action_pressed("movement_left"):
			playerAnim.stop();
			playerAnim.play("Idle");
			playerAnim.flip_h = 0;
		elif Input.is_action_just_released("movement_left") && !Input.is_action_pressed("move_right"):
			playerAnim.stop();
			playerAnim.play("Idle");
			playerAnim.flip_h = 1;
		elif Input.is_action_just_pressed("jump") && isonfloor || Global.isonMaterial && Input.is_action_just_pressed("jump") :
			apply_impulse(Vector2(), Vector2(0, jumpForce));
		else:
			set_linear_velocity(Vector2(0, vertVel));
		if Input.is_action_just_pressed("jump") && Input.is_action_pressed("movement_left"):
			playerAnim.play("Idle");
			playerAnim.flip_h = 1;
		if Input.is_action_just_pressed("jump") && Input.is_action_pressed("move_right"):
			playerAnim.play("Idle");
			playerAnim.flip_h = 0;
	else:
		self.mode = 1;
	if Global.takeDamage:
		movePos = get_linear_velocity().x
		if Global.enemyGetPOS < 0 && movePos > 0 || Global.enemyGetPOS < 0 && movePos < 0 || Global.enemyGetPOS < 0 && movePos == 0:
			apply_impulse(Vector2(), Vector2(-10000, -jumpForce));
			Global.takeDamage = false;
		elif Global.enemyGetPOS > 0 && movePos < 0 || Global.enemyGetPOS > 0 && movePos > 0 ||  Global.enemyGetPOS > 0 && movePos == 0:
			apply_impulse(Vector2(), Vector2(10000, -jumpForce));
			Global.takeDamage = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	playerAnim.play("Idle");

func _on_playerArea_body_entered(body):
	if body.is_in_group("floor"):
		isonfloor = true;


func _on_playerArea_body_exited(body):
	if body.is_in_group("floor"):
		isonfloor = false;
