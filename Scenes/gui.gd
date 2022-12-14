extends Node2D
onready var lives = $CanvasLayer/Energy/AnimatedSprite;
onready var materialsLeft = $CanvasLayer/materials_left;


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	lives.play("3 Lives");


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Global.checkpointIndex == 0:
		$CanvasLayer/materials_left.add_color_override("font_color", Color(0, 0, 0, 1));
		$CanvasLayer/X.add_color_override("font_color", Color(0, 0, 0, 1));
	if Global.checkpointIndex > 0:
		$CanvasLayer/materials_left.add_color_override("font_color", Color(1, 1, 1, 1));
		$CanvasLayer/X.add_color_override("font_color", Color(1, 1, 1, 1));
	materialsLeft.text = str(Global.materials);
	if Global.lostLife:
		if Global.lives == 2:
			lives.play("3 Lives to 2 Lives");
			Global.lostLife = false;
		if Global.lives == 1:
			lives.play("2 Lives to 1 life");
			Global.lostLife = false;
	if Global.getlife:
		if Global.lives == 2:
			var loadGather = load("res://Scenes/GlobalGather.tscn");
			var playSound = loadGather.instance();
			add_child(playSound);
			lives.play("1 Life to 2 Lives");
			Global.getlife = false;
		if Global.lives == 3:
			var loadGather = load("res://Scenes/GlobalGather.tscn");
			var playSound = loadGather.instance();
			add_child(playSound);
			lives.play("2 Lives to 3 Lives");
			Global.getlife = false;
	
	




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
