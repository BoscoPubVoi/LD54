extends Node

@onready var newgolfertimer = $NewGolfer

@onready var player = get_tree().get_first_node_in_group("player")

var golfer_generic = preload("res://Balls/ball_spitter.tscn")

var distance_from_player = 25

var golfer_array = []

func _ready():
	_on_new_golfer_timeout()

func _on_new_golfer_timeout():
	if golfer_array.size() < Global.MAX_GOLFERS:
		pass
		golfer_array.pop_front()
		
	var newGolfer = golfer_generic.instantiate()
	add_child(newGolfer)
	var direction = Vector2.UP.rotated(randf_range(0, 2*PI))* distance_from_player * randf_range(0.7, 1.4)
	var direction3 = Vector3(direction.x, 2, direction.y)
	newGolfer.global_position = player.global_position + (direction3)
	golfer_array.append(newGolfer)
