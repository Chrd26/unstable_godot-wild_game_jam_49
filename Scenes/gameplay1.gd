extends Node2D
var materialSpawn;

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.chapterNumber = 1;
	if Global.checkpointIndex == 0:
		var playerload = load("res://Scenes/player.tscn");
		var addPlayer = playerload.instance();
		addPlayer.position = Vector2(-192, 1543);
		add_child(addPlayer);
	elif Global.checkpointIndex == 1:
		var playerload = load("res://Scenes/player.tscn");
		var addPlayer = playerload.instance();
		addPlayer.position = Vector2(1000, 1087);
		add_child(addPlayer);
	elif Global.checkpointIndex == 2:
		var playerload = load("res://Scenes/player.tscn");
		var addPlayer = playerload.instance();
		addPlayer.position = Vector2(3129, 1343);
		add_child(addPlayer);
	elif Global.checkpointIndex == 3:
		var playerload = load("res://Scenes/player.tscn");
		var addPlayer = playerload.instance();
		addPlayer.position = Vector2(4838, 389.064);
		add_child(addPlayer);
	elif Global.checkpointIndex == 4:
		var playerload = load("res://Scenes/player.tscn");
		var addPlayer = playerload.instance();
		addPlayer.position = Vector2(4288, -735);
		add_child(addPlayer);

func _process(_delta):
	if Input.is_action_just_pressed("Reset"):
		Global.lives = 3;
		Global.materials = 10;
		queue_free(); 
		# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Scenes/Chapter1.tscn");
	if Global.haspickedUpShape:
		Global.materials += 5;
		var GatherSound = load("res://Scenes/GlobalGather.tscn");
		var playSoundGather = GatherSound.instance();
		add_child(playSoundGather);
		Global.haspickedUpShape = false;
	if Input.is_action_just_pressed("Material1") && Global.stackingMode:
		if Global.materials > 0:
			var selection = load("res://Scenes/changeShape.tscn");
			var playSelectionSound = selection.instance();
			add_child(playSelectionSound);
			var material = load("res://Scenes/Material_1.tscn");
			materialSpawn = material.instance();
			add_child(materialSpawn);
		else:
			var selection = load("res://Scenes/outofshapes.tscn");
			var playSelectionSound = selection.instance();
			add_child(playSelectionSound);
	elif Input.is_action_just_pressed("Material2") && Global.stackingMode:
		if Global.materials > 0:
			var selection = load("res://Scenes/changeShape.tscn");
			var playSelectionSound = selection.instance();
			add_child(playSelectionSound);
			var material = load("res://Scenes/Material2.tscn");
			materialSpawn = material.instance();
			add_child(materialSpawn);
		else:
			var selection = load("res://Scenes/outofshapes.tscn");
			var playSelectionSound = selection.instance();
			add_child(playSelectionSound);
	elif Input.is_action_just_pressed("Material4") && Global.stackingMode:
		if Global.materials > 0:
			var selection = load("res://Scenes/changeShape.tscn");
			var playSelectionSound = selection.instance();
			add_child(playSelectionSound);
			var material = load("res://Scenes/Material3.tscn");
			materialSpawn = material.instance();
			add_child(materialSpawn);
		else:
			var selection = load("res://Scenes/outofshapes.tscn");
			var playSelectionSound = selection.instance();
			add_child(playSelectionSound);
	elif Input.is_action_just_pressed("Material3") && Global.stackingMode:
		if Global.materials > 0:
			var selection = load("res://Scenes/changeShape.tscn");
			var playSelectionSound = selection.instance();
			add_child(playSelectionSound);
			var material = load("res://Scenes/Material4.tscn");
			materialSpawn = material.instance();
			add_child(materialSpawn);
		else:
			var selection = load("res://Scenes/outofshapes.tscn");
			var playSelectionSound = selection.instance();
			add_child(playSelectionSound);
	if Global.lives == 0:
		Global.lives = 3;
		Global.materials = 10;
		queue_free(); 
		# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Scenes/Chapter1.tscn");



func _on_out_of_bounds_body_entered(body):
	if body.is_in_group("player"):
		Global.lives = 0;


func _on_finishtutorial_body_entered(body):
	if body.is_in_group("player"):
		Global.checkpointIndex = 1;


func _on_checkpoint2_body_entered(body):
	if body.is_in_group("player"):
		Global.checkpointIndex = 2;


func _on_checkpoint3_body_entered(body):
	if body.is_in_group("player"):
		Global.checkpointIndex = 3;



func _on_checkpoint4_body_entered(body):
	if body.is_in_group("player"):
		Global.checkpointIndex = 4;
