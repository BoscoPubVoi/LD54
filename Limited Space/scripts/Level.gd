extends Node3D

@export var NextLevel : String
@export var MainMenu : String
@export var ScoreScene : String
@onready var camera = get_tree().get_first_node_in_group("camera")

signal LevelEnded

# Called when the node enters the scene tree for the first time.
func _ready():
	var player = get_tree().get_first_node_in_group("player")
	Global.CURRENT_LEVEL += 1;
	player.hit.connect(_on_player_hit)
	if Global.firstTime:
		$TeeOff.show()
		$TeeOff.grab_focus()
		$"Golfer Manager/NewGolfer".stop()
	else:
		camera.target = player
		$"Golfer Manager/NewGolfer".start()
		$TeeOff.hide()
		$"Golfer Manager/First Golfer"._on_shot_timer_timeout()

#need to pause game, show score for the level and move to next level or end screen
func _on_player_hit():
	var scoreScene = load(ScoreScene).instantiate() 
	get_tree().current_scene.add_child(scoreScene)
	scoreScene.MainMenuClicked.connect(ChangeToMainMenu)
	scoreScene.NextClicked.connect(TryLevelAgain)
	LevelEnded.emit()
	
func ChangeToMainMenu():
	get_tree().change_scene_to_file(MainMenu)

func TryLevelAgain():
	Global.PrepScore()
	Global.CURRENT_LEVEL = 0
	get_tree().change_scene_to_file(NextLevel)


func _on_tee_off_pressed():
	if Global.firstTime:
		camera.target = $"Golfer Manager/First Golfer"
		camera.set_offset_and_speed()
		
#		$"Golfer Manager/NewGolfer".stop()
		$TeeOff.hide()
		$TeeOff/Timer.start()
		


func _on_timer_timeout():
	$"Golfer Manager/First Golfer"._on_shot_timer_timeout()
	$"Golfer Manager/NewGolfer".start()
	$ForeTimer.start()


func _on_fore_timer_timeout():
	$ForeTimer.start(randi_range(8,15))
	AudioManager.say_fore()
	print("fore!")
