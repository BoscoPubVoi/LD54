extends Node

var audience = []

func _ready():
	audience = get_tree().get_nodes_in_group("audience")

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		print("asdasda")
		audience.pick_random().throw_tomato()

func throw_tomato():
	pass
