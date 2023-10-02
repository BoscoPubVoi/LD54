extends Node3D

@export var tomato : PackedScene
@export var colors : Array[Color]
@onready var sprites : Array[Sprite3D] = [
	$torso, 
	$legs,
	$torso/head, 
	$torso/arm_l, 
	$torso/arm_r]
@onready var anim : AnimationPlayer = $AnimationPlayer
@onready var player = get_tree().get_first_node_in_group("player")

func _ready():
	var torso = sprites[0]
	var legs = sprites[1]
	var color =  colors.pick_random()
	torso.modulate = color
	legs.modulate = color
	scale = Vector3( randf_range(0.9, 1.1), randf_range(0.9,1.1), 1 )
	await get_tree().create_timer(randf_range(0, 1.0)).timeout
	anim.play("idle")
	
func throw_tomato():
	anim.play("tomato_throw")
	
	var scene_root = get_tree().get_first_node_in_group("LevelRoot")
	var newBall = tomato.instantiate()
	scene_root.add_child(newBall)
	
	var direction = player.position - position 
	direction.y = 10
	direction = direction.normalized() * position.distance_to(player.position)/randf_range(17.0, 20.0)
	newBall.apply_impulse(direction)
	newBall.position = position
	newBall.position.x -= 1.4
	newBall.position.y += 4.5
	
	await get_tree().create_timer(0.26).timeout
	anim.play("idle")
