extends Area3D

func _ready():
	rotate_y(randf_range(0,180))

func _process(delta):
	for body in get_overlapping_bodies():
		if body as RigidBody3D != null :
			body.apply_central_force(-body.linear_velocity * 1)
			
		body.slow()


func _on_body_exited(body):
	if body.has_method("speedup"):
		body.speedup()
