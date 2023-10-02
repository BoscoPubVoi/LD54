extends Node3D

@export var rate_of_fire = 4

@export var balltype : PackedScene
@export var golfer_sprites : Array[CompressedTexture2D]

@onready var golfer : Sprite3D = $Golfer_Sprite
@onready var timer : Timer = $Shot_Timer

@onready var audioplayer = $AudioStreamPlayer3D
@onready var player = get_tree().get_first_node_in_group("player")
var scene_root : Node; 

var being_swallowed = false
var golfer_name

func _ready():
	scene_root = get_tree().get_first_node_in_group("LevelRoot")
	
	if scene_root != null && scene_root.has_signal("LevelEnded") : 
		scene_root.LevelEnded.connect(_on_level_ended)
	
	var chosen_sprite = golfer_sprites[randi()%golfer_sprites.size()]
	golfer.texture = chosen_sprite
	golfer_name = chosen_sprite.resource_path.get_file().replace(".png", "")


func emit():
	audioplayer.play()
	#try and work out a rough speed to shoot towards the player
	var new_speed = position.distance_to(get_tree().get_first_node_in_group("player").position)
	
	#create new ball
	var newBall = balltype.instantiate()
	scene_root.add_child(newBall)
	var facing = transform.basis.z
	var enemy_to_player = get_tree().get_first_node_in_group("player").position - global_transform.origin 
	var newDir = Vector3(enemy_to_player.x, 0, enemy_to_player.z)
	newBall.apply_new_force(newDir, new_speed)
	newBall.position = position
	newBall.position.x -= 1.4
	
func _on_shot_timer_timeout():
	if !Global.isDead:
		$AnimationPlayer.play("swing_" + golfer_name)
		$Shot_Timer.start(rate_of_fire * randf_range(0.8, 1.2))
	if randi() % 40 == 0:
		$Fore.pitch_scale = randf_range(0.7, 1.5)
		$Fore.play()

func _go_to_idle():
	$AnimationPlayer.play("idle_" + golfer_name)


func _on_level_ended():
	timer.stop()
	# golfer.stop()

func swallow():
	being_swallowed = true
	timer.stop()

func _process(delta):
	if being_swallowed:
		position.x = player.position.x
		position.z = player.position.z 
		position.y -= .1


func _on_area_3d_body_entered(body):
	swallow()
