extends Node3D

@export var rate_of_fire = 4

@export var balltype : PackedScene

@onready var golfer : AnimatedSprite3D = $Golfer_Sprite
@onready var timer : Timer = $Shot_Timer

@onready var audioplayer = $AudioStreamPlayer3D
var scene_root : Node; 


func _ready():
	scene_root = get_tree().get_first_node_in_group("LevelRoot")
	
	if scene_root != null && scene_root.has_signal("LevelEnded") : 
		scene_root.LevelEnded.connect(_on_level_ended)
	
func emit():
	#try and work out a rough speed to shoot towards the player
	var new_speed = position.distance_to(get_tree().get_first_node_in_group("player").position)
	
	#create new ball
	var newBall = balltype.instantiate()
	scene_root.add_child(newBall)
	newBall.apply_new_force(get_global_transform().basis.z, new_speed)
	newBall.position = position
	
func _on_shot_timer_timeout():
	look_at(get_tree().get_first_node_in_group("player").position)
	rotate_y(3.1415)
	golfer.play("default")
	$Shot_Timer.start(rate_of_fire * randf_range(0.8, 1.2))

func _on_golfer_sprite_frame_changed():
	if golfer.frame == 1:
		audioplayer.play()
		emit()

func _on_level_ended():
	timer.stop()
	golfer.stop()

