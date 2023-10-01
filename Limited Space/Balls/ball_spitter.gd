extends Node3D


@onready var golfer : AnimatedSprite3D = $Golfer_Sprite
@onready var timer : Timer = $Shot_Timer

@onready var audioplayer = $AudioStreamPlayer3D

var ballGeneric = preload("res://Balls/basic_ball.tscn")
var ballScatter = preload("res://Balls/scatter_ball.tscn")
var ballTomato = preload("res://Balls/tomato.tscn")

var ballarray = [ballGeneric, ballScatter, ballTomato]

func _ready():
	var root = get_tree().get_first_node_in_group("LevelRoot")
	
	if root != null && root.has_signal("LevelEnded") : 
		root.LevelEnded.connect(_on_level_ended)

func emit():
	#try and work out a rough speed to shoot towards the player
	var new_speed = position.distance_to(get_tree().get_first_node_in_group("player").position)
	
	#create new ball
	var newBall = ballarray.pick_random().instantiate()
	get_tree().root.add_child(newBall)
	newBall.apply_new_force(get_global_transform().basis.z, new_speed)
	newBall.position = position
	
func _on_shot_timer_timeout():
	look_at(get_tree().get_first_node_in_group("player").position)
	rotate_y(3.1415)
	golfer.play("default")
	$Shot_Timer.start(randi()%5)

func _on_golfer_sprite_frame_changed():
	if golfer.frame == 1:
		audioplayer.play()
		emit()

func _on_level_ended():
	timer.stop()
	golfer.stop()
