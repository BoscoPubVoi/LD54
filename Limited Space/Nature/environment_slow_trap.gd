extends Area3D


func _process(delta):
	for body in get_overlapping_bodies():
		if body as RigidBody3D != null :
			body.apply_central_force(-body.linear_velocity * 1)
			
		# TODO:Player was changed to characterBody3D, needs different handling 
		body.slow()


func _on_body_exited(body):
	if body.has_method("speedup"):
		body.speedup()
