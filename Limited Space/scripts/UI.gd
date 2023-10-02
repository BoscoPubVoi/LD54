extends Control

@onready var labelparent = $Node2D
@onready var label = $Node2D/Label

var particlearray = []

func _ready():
	particlearray.append($Node2D/CPUParticles2D)
	particlearray.append($Node2D/CPUParticles2D2)
	particlearray.append($Node2D/CPUParticles2D3)
	particlearray.append($Node2D/CPUParticles2D4)
	particlearray.append($Node2D/CPUParticles2D5)
	particlearray.append($Node2D/CPUParticles2D6)
	particlearray.append($Node2D/CPUParticles2D7)
	
	var root = get_tree().get_first_node_in_group("LevelRoot")
	root.LevelEnded.connect(end)

func end():
	var h = ProjectSettings.get_setting("display/window/size/viewport_height")
	if Global.PLAYER_SCORE[0] == 1 || Global.PLAYER_SCORE[0] == 0:
		label.text = "Hole in One!"
	var tween := create_tween()
#	tween.tween_property(label, "global_position:y", h/2, 0.4)
#	tween.parallel()
	tween.tween_property(label, "theme_override_font_sizes/font_size", 100, 0.4)
	tween.parallel()
	tween.tween_property(label, "theme_override_constants/outline_size", 50, 0.4)
	tween.parallel()
	tween.tween_property(label, "position:y", 0, 0.4)
	
func updateScore(newscore):
	label.text = Global.boring_bogey_calculator(newscore)
	scale *= 1.1
	scale = clamp(scale, Vector2(1,1), Vector2(12,12))
	labelparent.rotate(randf_range(-.1, .1))
	var num_sparks = randi_range(1,particlearray.size())
	for i in num_sparks:
		particlearray.pick_random().restart()
	
func _process(delta):
	scale = lerp(scale, Vector2(1,1), .03)
	labelparent.rotation = lerp(labelparent.rotation, 0.0, .03)
