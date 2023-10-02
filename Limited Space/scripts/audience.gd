extends Node3D

@export var colors : Array[Color]

@onready var sprites : Array[Sprite3D] = [
	$AnimationPlayer/torso, 
	$AnimationPlayer/torso/head, 
	$AnimationPlayer/torso/arm_l, 
	$AnimationPlayer/torso/arm_r, 
	$AnimationPlayer/torso/legs]
	
func _ready():
	print(sprites[0])
	sprites[0].modulate = colors.pick_random()

