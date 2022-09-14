extends Node2D
onready var lives = $CanvasLayer/AnimatedSprite;
onready var materialsLeft = $CanvasLayer/materials_left;


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	lives.play("3 Lives");


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	materialsLeft.text = str(Global.materials);
	if Input.is_action_just_pressed("jump"):
		if Global.lives > 0:
			Global.lives -= 1;
		if Global.lives == 0:
			Global.lives -= 0;
		if Global.lives == 2:
			lives.play("3 Lives to 2 Lives");
		if Global.lives == 1:
			lives.play("2 Lives to 1 life");
	if Input.is_action_just_pressed("stacking_mode_enable"):
		if Global.lives < 3:
			Global.lives += 1;
		if Global.lives == 3:
			Global.lives += 0; 
		if Global.lives == 2:
			lives.play("1 Life to 2 Lives");
		if Global.lives == 3:
			lives.play("2 Lives to 3 Lives");
	
	




func _on_AnimatedSprite_animation_finished():
	if Global.lives == 3:
		lives.stop();
		lives.play("3 Lives");
	if Global.lives == 2:
		lives.stop();
		lives.play("2 Lives");
	if Global.lives == 1:
		lives.stop();
		lives.play("1 Life");
