extends Node

@onready var newgolfertimer = $NewGolfer

@onready var player = get_tree().get_first_node_in_group("player")

var golfer_generic = preload("res://Balls/Golfers/generic_golfer.tscn")
var golfer_scatter = preload("res://Balls/Golfers/scatter_golfer.tscn")
var golfer_tomato = preload("res://Balls/Golfers/tomato_golfer.tscn")

var distance_from_player = 25

var current_golfer_array = []

func _ready():
	_on_new_golfer_timeout()

func _on_new_golfer_timeout():
	if current_golfer_array.size() < Global.MAX_GOLFERS:
		current_golfer_array.pop_front()
		
	var newGolfer = get_golfer().instantiate()
	add_child(newGolfer)
	var direction = Vector2.UP.rotated(randf_range(0, 2*PI))* distance_from_player * randf_range(0.7, 1.4)
	var direction3 = Vector3(direction.x, 2, direction.y)
	newGolfer.global_position = player.global_position + (direction3)
	current_golfer_array.append(newGolfer)


func get_golfer():
	var currentscore =  Global.PLAYER_SCORE[0]
	
	var code = randi() % (currentscore + 1)
	
	if code < 10:
		return golfer_generic
	if code < 50:
		return golfer_scatter
	else:
		return golfer_tomato
