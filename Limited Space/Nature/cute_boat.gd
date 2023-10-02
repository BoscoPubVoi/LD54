extends Node3D

var limit_left = -7
var limit_right = 7

var speed = .03
var direction = 1

func _ready():
	$AnimationPlayer.play("bob")

func _process(delta):
	if $Node.position.x < limit_left:
		speed *= clamp(randf_range(0.8, 1.2), .01, 0.04) 
		direction = 1
		$Node.position.x = limit_left + .2
	if $Node.position.x >= limit_right:
		speed *= clamp(randf_range(0.8, 1.2), .01, 0.04) 
		direction = -1
		$Node.scale.x = direction
		$Node.position.x = limit_right - .2
	$Node.position.x += speed * direction
