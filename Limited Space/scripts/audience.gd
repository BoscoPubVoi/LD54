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
	
	var facing = transform.basis.z
	var enemy_to_player = get_tree().get_first_node_in_group("player").position
	var newDir = Vector3(enemy_to_player.x, 0, enemy_to_player.z).normalized()
	var new_speed = position.distance_to(get_tree().get_first_node_in_group("player").position)
	newBall.apply_new_force(newDir, new_speed * .7)
	newBall.position = position
	newBall.position.x -= 1.4
	newBall.position.y += 4.5
	
	await get_tree().create_timer(0.26).timeout
	anim.play("idle")
