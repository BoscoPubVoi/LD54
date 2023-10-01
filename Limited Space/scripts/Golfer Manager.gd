extends Node

@onready var newgolfertimer = $NewGolfer

@onready var player = get_tree().get_first_node_in_group("player")
@onready var scene_root = get_tree().get_first_node_in_group("LevelRoot")

var golfer_generic = preload("res://Balls/Golfers/generic_golfer.tscn")
var golfer_scatter = preload("res://Balls/Golfers/scatter_golfer.tscn")
var golfer_tomato = preload("res://Balls/Golfers/tomato_golfer.tscn")
var golfer_seeker = preload("res://Balls/Golfers/seeker_golfer.tscn")

var distance_from_player = 25

var current_golfer_array = []

func _ready():
	scene_root.LevelEnded.connect(_on_level_ended)
	_on_new_golfer_timeout()

func _on_new_golfer_timeout():
	if current_golfer_array.size() < Global.MAX_GOLFERS:
		current_golfer_array.pop_front()
		
	var newGolfer = get_golfer().instantiate()
	add_child(newGolfer)
	var direction = Vector2.UP.rotated(randf_range(-PI/2 + .1, PI/2 - .1))* distance_from_player * randf_range(0.7, 1.4)
	var direction3 = Vector3(direction.x, .5, direction.y)
	newGolfer.global_position = player.global_position + (direction3)
	current_golfer_array.append(newGolfer)


func get_golfer():
	var currentscore =  Global.PLAYER_SCORE[0]
	
	var code = randi() % (currentscore + 1)
	
	if code < 10:
		return golfer_generic
	if code < 40:
		return golfer_scatter
	if code < 50:
		return golfer_tomato
	else:
		return golfer_seeker

func _on_level_ended():
	newgolfertimer.stop()

