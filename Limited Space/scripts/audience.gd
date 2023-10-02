extends Node3D

@export var colors : Array[Color]

@onready var sprites : Array[Sprite3D] = [
	$torso, 
	$legs,
	$torso/head, 
	$torso/arm_l, 
	$torso/arm_r]

func _ready():
	var torso = sprites[0]
	var legs = sprites[1]
	var color =  colors.pick_random()
	torso.modulate = color
	legs.modulate = color
	scale = Vector3( randf_range(0.9, 1.1), randf_range(0.9,1.1), 1 )

