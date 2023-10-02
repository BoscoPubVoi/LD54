extends Node

var audience = []
@onready var timer : Timer = $Timer

func _ready():
	var scene_root = get_tree().get_first_node_in_group("LevelRoot")
	
	audience = get_tree().get_nodes_in_group("audience")
	if scene_root != null && scene_root.has_signal("LevelEnded") : 
		scene_root.LevelEnded.connect(_on_level_ended)

	timer.start(1)#13

func _on_timer_timeout():
	print("throw tomato")
	audience.pick_random().throw_tomato()
	timer.start(1)#7

func _on_level_ended():
	timer.stop()
