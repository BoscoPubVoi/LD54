extends Control

@export var ScoreLabel = RichTextLabel
@export var TotalScoreLabel = Label
@export var NextBtn : Button

signal MainMenuClicked
signal NextClicked

 
func _on_next_level_pressed():
	NextClicked.emit()

func _on_main_menu_pressed():
	MainMenuClicked.emit()

func _ready():
	TotalScoreLabel.text = str(Global.GetTotalScore())
#	ScoreLabel.text = str(Global.PLAYER_SCORE[Global.CURRENT_LEVEL - 1], "x", " BOGEY")
	ScoreLabel.text = Global.bogey_calculator(Global.PLAYER_SCORE[Global.CURRENT_LEVEL - 1])
	
	if Global.CURRENT_LEVEL == Global.LEVEL_COUNT:
		NextBtn.visible = false
	AudioManager.play("applause")
