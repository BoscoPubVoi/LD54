extends Node3D

@export var NextLevel : String
@export var MainMenu : String
@export var ScoreScene : String

signal LevelEnded

# Called when the node enters the scene tree for the first time.
func _ready():
	var player = get_tree().get_first_node_in_group("player")
	Global.CURRENT_LEVEL += 1;
	player.hit.connect(_on_player_hit)

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
