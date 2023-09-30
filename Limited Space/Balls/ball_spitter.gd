extends Node3D


@onready var golfer = $Golfer_Sprite
var ballGeneric = preload("res://Balls/basic_ball.tscn")

func emit():
	#try and work out a rough speed to shoot towards the player
	var new_speed = position.distance_to(get_tree().get_first_node_in_group("player").position)
	
	#create new ball
	var newBall = ballGeneric.instantiate()
	add_sibling(newBall)
	newBall.apply_new_force(get_global_transform().basis.z, new_speed)
	newBall.position = position
	

func _on_shot_timer_timeout():

	look_at(get_tree().get_first_node_in_group("player").position)
	rotate_y(3.1415)
	golfer.play("default")
	$Shot_Timer.start(randi()%5)

func _on_golfer_sprite_frame_changed():
	if golfer.frame == 1:
		emit()
