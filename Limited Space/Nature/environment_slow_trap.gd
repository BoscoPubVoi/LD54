extends Area3D


func _process(delta):
	for body in get_overlapping_bodies():
		body.apply_central_force(-body.linear_velocity * 1)
		body.slow()


func _on_body_exited(body):
	body.speedup()
