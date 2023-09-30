extends Node3D

@export var NextLevel : String
@export var MainMenu : String
@export var ScoreScene : String

signal LevelEnded

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.CURRENT_LEVEL += 1;

#need to pause game, show score for the level and move to next level or end screen
func _on_player_hit():
	var scoreScene = load(ScoreScene).instantiate() 
	get_tree().current_scene.add_child(scoreScene)
	scoreScene.MainMenuClicked.connect(ChangeToMainMenu)
	scoreScene.NextClicked.connect(ChangeToNextLevel)
	LevelEnded.emit()

func ChangeToMainMenu():
	get_tree().change_scene_to_file(MainMenu)

func ChangeToNextLevel():
	get_tree().change_scene_to_file(NextLevel)
