extends AnimatedSprite
var isTweenPlaying = false;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Global.hasexitChapterStarted:
		if !isTweenPlaying:
			$Tween.interpolate_property(self, "modulate",Color(1, 1, 1, 1), Color(1, 1, 1, 0), 10, Tween.TRANS_QUAD, Tween.EASE_IN_OUT);
			$Tween.start()
			isTweenPlaying = true;
