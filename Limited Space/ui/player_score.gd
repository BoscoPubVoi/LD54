extends Label

var LabelTxt : String = "Score:"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	self.text = str(LabelTxt, " ", Global.PLAYER_SCORE[Global.CURRENT_LEVEL])