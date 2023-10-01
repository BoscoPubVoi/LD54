extends Control

@onready var labelparent = $Node2D
@onready var label = $Node2D/Label

func updateScore(newscore):
	label.text = Global.bogey_calculator(newscore)
	scale *= 1.1
	labelparent.rotate(randf_range(-.1, .1))
	
func _process(delta):
	scale = lerp(scale, Vector2(1,1), .03)
	labelparent.rotation = lerp(labelparent.rotation, 0.0, .03)
