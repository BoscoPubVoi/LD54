extends Control

@onready var labelparent = $Node2D
@onready var label = $Node2D/Label

var particlearray = []

func _ready():
	particlearray.append($Node2D/Label/CPUParticles2D)
	particlearray.append($Node2D/Label/CPUParticles2D2)
	particlearray.append($Node2D/Label/CPUParticles2D3)
	particlearray.append($Node2D/Label/CPUParticles2D4)
	particlearray.append($Node2D/Label/CPUParticles2D5)
	particlearray.append($Node2D/Label/CPUParticles2D6)
	particlearray.append($Node2D/Label/CPUParticles2D7)

func updateScore(newscore):
	label.text = Global.bogey_calculator(newscore)
	scale *= 1.1
	labelparent.rotate(randf_range(-.1, .1))
	var num_sparks = randi_range(1,particlearray.size())
	for i in num_sparks:
		particlearray.pick_random().restart()
	
	
func _process(delta):
	scale = lerp(scale, Vector2(1,1), .03)
	labelparent.rotation = lerp(labelparent.rotation, 0.0, .03)
