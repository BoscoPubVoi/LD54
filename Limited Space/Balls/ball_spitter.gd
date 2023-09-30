extends Node3D

var ballGeneric = preload("res://Balls/basic_ball.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func emit():
	var newBall = ballGeneric.instantiate()
	add_sibling(newBall)
	newBall.apply_new_force(get_global_transform().basis.z)
	newBall.position = position
	

func _on_shot_timer_timeout():
	look_at(get_tree().get_first_node_in_group("hole").position)
	rotate_y(135)
	emit()
	$Shot_Timer.start(randi()%5)
