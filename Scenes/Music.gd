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
	if Global.hasEnteredMenu:
		if $TutorialIntro.playing:
			$TutorialIntro.stop();
		elif $TutorialLoop.playing:
			$TutorialLoop.stop();
		elif $Track1Intro.playing:
			$Track1Intro.stop();
		elif $Track1Loop.playing:
			$Track1Loop.stop();
		elif $Track2Intro.playing:
			$Track2Intro.stop();
		elif $Track2Loop.playing:
			$Track2Loop.stop();
		Global.hasEnteredMenu = false;
	#print($IntroFadeIn.volume_db);
	if Global.hasgameStarted:
		if Global.haspressedBegin:
			if $IntroFadeIn.playing:
				$musicTween.interpolate_property($IntroFadeIn, "volume_db", 0, -50, 3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT);
				$musicTween.start()
				Global.haspressedBegin = false;
			else:
				$musicTween.interpolate_property($IntroLoop, "volume_db", 0, -50, 3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT);
				$musicTween.start();
				Global.haspressedBegin = false;

func _on_IntroFadeIn_finished():
	if !Global.hasgameStarted:
		$IntroLoop.play();
	elif Global.chapterNumber == 1 && Global.checkpointIndex == 0:
		$TutorialIntro.play();	
	elif Global.chapterNumber == 1 && Global.checkpointIndex > 0 && Global.checkpointIndex < 4:
		$Track1Intro.play();
	elif Global.chapterNumber == 0 && Global.checkpointIndex == 0:
		$IntroLoop.play();


func _on_IntroLoop_finished():
	if !Global.hasgameStarted:
		$IntroLoop.play();
	elif Global.chapterNumber == 1 && Global.checkpointIndex == 0:
		$TutorialIntro.play();	
	elif Global.chapterNumber == 1 && Global.checkpointIndex > 0 && Global.checkpointIndex < 4:
		$Track1Intro.play();
	elif Global.chapterNumber == 0 && Global.checkpointIndex == 0:
		$IntroLoop.play();
	elif Global.chapterNumber == 1 && Global.checkpointIndex >= 4:
		$Track2Intro.play();


func _on_TutorialIntro_finished():
	$TutorialLoop.play();


func _on_TutorialLoop_finished():
	if Global.chapterNumber == 0:
		$IntroFadeIn.play();
		$IntroFadeIn.volume_db = 0;
	if Global.chapterNumber == 1 && Global.checkpointIndex == 0:
		$TutorialLoop.play();
	elif Global.chapterNumber == 1 && Global.checkpointIndex > 0 && Global.checkpointIndex < 4:
		$Track1Intro.play();


func _on_musicTween_tween_all_completed():
	if $IntroFadeIn.playing:
		$IntroFadeIn.stop();
		if Global.chapterNumber == 1 && Global.checkpointIndex == 0:
			$TutorialIntro.play();	
		elif Global.chapterNumber == 1 && Global.checkpointIndex > 0 && Global.checkpointIndex < 4:
			$Track1Intro.play();
		elif Global.chapterNumber == 1 && Global.checkpointIndex >= 4:
			$Track2Intro.play();
	elif $IntroLoop.playing:
		$IntroLoop.stop();
		if Global.chapterNumber == 1 && Global.checkpointIndex == 0:
			$TutorialIntro.play();	
		elif Global.chapterNumber == 1 && Global.checkpointIndex > 0 && Global.checkpointIndex < 0:
			$Track1Intro.play();
		elif Global.chapterNumber == 1 && Global.checkpointIndex >= 4:
			$Track2Intro.play();
		



func _on_Track2Intro_finished():
	if Global.chapterNumber == 0:
		$IntroFadeIn.play();
		$IntroFadeIn.volume_db = 0;
	if Global.chapterNumber == 1 && Global.checkpointIndex >= 4:
		$Track2Loop.play();


func _on_Track2Loop_finished():
	if Global.chapterNumber == 0:
		$IntroFadeIn.play();
		$IntroFadeIn.volume_db = 0;
	if Global.chapterNumber == 1 && Global.checkpointIndex >= 4:
		$Track2Loop.play();


func _on_Track1Loop_finished():
	if Global.chapterNumber == 0:
		$IntroFadeIn.play();
		$IntroFadeIn.volume_db = 0;
	if Global.chapterNumber == 1 && Global.checkpointIndex > 0 && Global.checkpointIndex < 4:
		$Track1Loop.play();
	if Global.chapterNumber == 1 && Global.checkpointIndex >= 4:
		$Track2Intro.play();


func _on_Track1Intro_finished():
	if Global.chapterNumber == 0:
		$IntroFadeIn.play();
		$IntroFadeIn.volume_db = 0;
	if Global.chapterNumber == 1 && Global.checkpointIndex > 0 && Global.checkpointIndex < 4:
		$Track1Loop.play();

