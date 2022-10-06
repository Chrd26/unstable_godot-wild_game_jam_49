extends Node2D

# Global Variables for Gameplay Elements

var movementEnabled = true;
var materialsLeft;
var stackingMode = false;
var buttonPresses = 0;
var lives = 3;
var isonfloor = true;
var materials = 10;
var lostLife = false;
var getlife = false;
var takeDamage = false;
var enemyGetPOS;
var hasActivatedBuilding = false;
var haspickedUpShape = false;
var chapterNumber = 0;
var checkpointIndex = 5;
var hasgameStarted = false;
var haspressedBegin = false;
var getPlatformVelocity;
var getPlatformPosition;
var getPlatform2Velocity;
var getPlatform3Velocity;
var getExitChapterVelocity;
var hashand1Startedmoving = false;
var hasexitChapterStarted = false;
var isChapter1Finished = false;
var hasOutroStarted = false;
var hasEnteredMenu = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass;

func _process(_delta):
	position = get_global_mouse_position();
