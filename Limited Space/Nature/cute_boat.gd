extends Node3D

var limit_left = -7
var limit_right = 7

var speed = -.02

func _ready():
	$AnimationPlayer.play("bob")

func _process(delta):
	if $Node.position.x <= limit_left || $Node.position.x >= limit_right:
		speed *= clamp(randf_range(0.8, 1.2), -0.25, 0.25) 
		speed *= -1
		$Node.scale.x *= -1
	$Node.position.x += speed
