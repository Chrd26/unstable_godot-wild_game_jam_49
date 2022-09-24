extends Light2D



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	match Global.checkpointIndex:
		0: 
			self.set_color("#ff0000");
		1:
			self.set_color("#00ff00");
		2:
			self.set_color("#ff0000");
		3:
			self.set_color("#ff0000");
		4:
			self.set_color("#ff0000");
		5:
			self.set_color("#ff0000");
		6:
			self.set_color("#ff0000");
		7:
			self.set_color("#ff0000");
		8:
			self.set_color("#ff0000");
