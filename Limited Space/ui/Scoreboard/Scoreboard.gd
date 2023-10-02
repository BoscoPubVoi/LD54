extends Control

@export var ScoreLabel = RichTextLabel
@export var TotalScoreLabel = Label
@export var NextBtn : Button

signal MainMenuClicked
signal NextClicked

 
func _on_next_level_pressed():
	NextClicked.emit()
	AudioManager.stop_music("applause", 1)

func _on_main_menu_pressed():
	MainMenuClicked.emit()
	AudioManager.stop_music("applause", 1)

func _ready():
	TotalScoreLabel.text = str(Global.GetTotalScore())
#	ScoreLabel.text = str(Global.PLAYER_SCORE[Global.CURRENT_LEVEL - 1], "x", " BOGEY")
	ScoreLabel.text = "[center]" + Global.fun_bogey_calculator(Global.PLAYER_SCORE[Global.CURRENT_LEVEL - 1]) + "[/center]"
	$"buttons/Try again".grab_focus()
	AudioManager.play_music("applause")
	$"Fancy Bogey".text = Global.fun_bogey_calculator(Global.PLAYER_SCORE[0])
	
	if Global.PLAYER_SCORE[0] > Global.hiscore:
		Global.hiscore = Global.PLAYER_SCORE[0]
	$"Hi Score".text = "High Score: " + str(Global.hiscore - 5)
