extends Node

@onready var newgolfertimer = $NewGolfer

@onready var player = get_tree().get_first_node_in_group("player")

var golfer_generic = preload("res://Balls/ball_spitter.tscn")

var distance_from_player = 25

func _ready():
	_on_new_golfer_timeout()

func _on_new_golfer_timeout():
	var newGolfer = golfer_generic.instantiate()
	add_child(newGolfer)
	var direction = Vector2.UP.rotated(randf_range(0, 2*PI))* distance_from_player * randf_range(0.7, 1.4)
	var direction3 = Vector3(direction.x, 2, direction.y)
	newGolfer.global_position = player.global_position + (direction3)
