extends RigidBody2D
var istouchingwall = false;
var istouchingFloor = false;
var speed = 300;
var hasShot = false;
var stopMoving = false;

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("EnemyIdle");


func _physics_process(_delta):
	var getVertVel = get_linear_velocity().y;
	var getColliderGroup = $RayCast2D.get_collider();
	Global.enemyGetPOS = get_linear_velocity().x;
	if !istouchingwall && istouchingFloor && !Global.changeSide && !stopMoving:
		$AnimatedSprite.play("enemyWalk");
		$AnimatedSprite.flip_h = 1;
		set_linear_velocity(Vector2(1 * speed, getVertVel));
		$RayCast2D.rotation_degrees = -90;
		
	if !istouchingwall && istouchingFloor && Global.changeSide && !stopMoving:
		$AnimatedSprite.play("enemyWalk");
		$AnimatedSprite.flip_h = 0;
		set_linear_velocity(Vector2(-1 * speed, getVertVel));
		$RayCast2D.rotation_degrees = 90;
	if $RayCast2D.is_colliding():
		if getColliderGroup.is_in_group("player"):
			stopMoving = true;
			$AnimatedSprite.play("EnemyIdle");
		if !hasShot && getColliderGroup.is_in_group("player"):
			var getCannonBall = load("res://Scenes/cannonball.tscn");
			var getCannonBallInstance = getCannonBall.instance();
			add_child(getCannonBallInstance);
			hasShot = true;
			print("shoot");
			$Timer.start();
	else:
		stopMoving = false;


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		Global.takeDamage = true;
		if Global.lives > 0:
			Global.lives -= 1;
			Global.lostLife = true;
	if body.is_in_group("floor"):
		istouchingFloor = true;
	if body.is_in_group("wall") || body.is_in_group("material"):
		istouchingwall = true;
		istouchingwall = false;
		if Global.changeSide:
			Global.changeSide = false;
		else:
			Global.changeSide = true;
	


func _on_Area2D_body_exited(body):
	if body.is_in_group("wall") || body.is_in_group("material"):
		istouchingwall = false;


func _on_Timer_timeout():
	hasShot = false;
	#print("hashotfalse");
