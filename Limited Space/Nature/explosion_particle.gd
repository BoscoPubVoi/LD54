extends CPUParticles3D


# Called when the node enters the scene tree for the first time.
func _ready():
	print(position)
	emitting = true


func _on_timer_timeout():
	queue_free()
