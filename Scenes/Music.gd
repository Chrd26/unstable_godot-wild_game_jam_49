extends Node2D
var hastimerStarted = false;
var loopi = 0;

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(_delta):
	if Global.hasgameStarted && !hastimerStarted:
		$fadeoutTimer.start();
		hastimerStarted = true;
	if Global.hasgameStarted && hastimerStarted:
		if $IntroFadeIn.playing:
			if loopi < 160:
				$IntroFadeIn.volume_db = -1 * loopi /2;
				#print($IntroFadeIn.volume_db)
				loopi += 1;
		else:
			if loopi < 160:
				$IntroLoop.volume_db = -1 * loopi /2;
				#print($IntroLoop.volume_db);
				loopi += 1;
func _on_IntroFadeIn_finished():
	if !Global.hasgameStarted:
		$IntroLoop.play();


func _on_IntroLoop_finished():
	if Global.hasgameStarted:
		if Global.chapterNumber == 1 && !Global.isTutorialFinished:
			$TutorialIntro.play();	
		elif Global.chapterNumber == 1 && Global.isTutorialFinished:
			$Chapter1Intro.play();


func _on_TutorialIntro_finished():
	$TutorialLoop.play();


func _on_TutorialLoop_finished():
	if Global.chapterNumber == 1 && !Global.isTutorialFinished:
		$TutorialLoop.play();
	elif Global.chapterNumber == 1 && Global.isTutorialFinished:
		$TutorialtoLevel1.play();

func _on_Chapter1Intro_finished():
	if Global.chapterNumber == 1:
		$Chapter1Loop.play();


func _on_Chapter1Loop_finished():
	if Global.chapterNumber == 1:
		$Chapter1Loop.play();


func _on_TutorialtoLevel1_finished():
	if Global.chapterNumber == 1:
		$Chapter1Intro.play();


func _on_fadeoutTimer_timeout():
	if $IntroFadeIn.playing:
		$IntroFadeIn.stop();
		if Global.chapterNumber == 1 && !Global.isTutorialFinished:
			$TutorialIntro.play();	
		elif Global.chapterNumber == 1 && Global.isTutorialFinished:
			$Chapter1Intro.play();
	elif $IntroLoop.playing:
		$IntroLoop.stop();
		if Global.chapterNumber == 1 && !Global.isTutorialFinished:
			$TutorialIntro.play();	
		elif Global.chapterNumber == 1 && Global.isTutorialFinished:
			$Chapter1Intro.play();
