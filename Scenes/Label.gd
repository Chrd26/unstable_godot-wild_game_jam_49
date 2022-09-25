extends Label
var hasStarted = false;

func _process(_delta):
	if Global.hasOutroStarted:
		if !hasStarted:
			$labelTween.interpolate_property(self, "percent_visible", 0.0, 0.1, 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT);
			$labelTween.interpolate_property(self, "percent_visible", 0.1, 0.2, 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0.3);
			$labelTween.interpolate_property(self, "percent_visible", 0.3, 0.4, 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0.6);
			$labelTween.interpolate_property(self, "percent_visible", 0.4, 0.5, 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0.9);
			$labelTween.interpolate_property(self, "percent_visible", 0.5, 0.6, 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 1.2);
			$labelTween.interpolate_property(self, "percent_visible", 0.7, 0.8, 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 1.5);
			$labelTween.interpolate_property(self, "percent_visible", 0.8, 0.9, 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 1.8);
			$labelTween.interpolate_property(self, "percent_visible", 0.9, 1.0, 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 2.1);
			$labelTween.start();
			hasStarted = true;

func _on_labelTween_tween_completed(_object, _key):
	pass;
