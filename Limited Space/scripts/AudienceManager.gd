extends Node

var audience = []
@onready var timer : Timer = $Timer

func _ready():
	var scene_root = get_tree().get_first_node_in_group("LevelRoot")
	audience = get_tree().get_nodes_in_group("audience")

func throw_tomato():
	print("throw tomato")
	audience.pick_random().throw_tomato()

#ugly shit, every 10 score
var oldScore = 0
func _process(delta):
	var score = Global.GetTotalScore();
	if score == oldScore:
		return
	if score % 8 == 0:
		throw_tomato()
	oldScore = score
