extends Node3D

@export var NextLevel : String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


#need to pause game, show score for the level and move to next level or end screen
func _on_player_hit():
	get_tree().change_scene_to_file(NextLevel)
