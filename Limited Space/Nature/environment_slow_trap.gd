extends Area3D

func _ready():
	rotate_y(randf_range(0,180))

func _process(delta):
	for body in get_overlapping_bodies():
		if body as RigidBody3D != null :
			body.apply_central_force(-body.linear_velocity * .5)
			body.apply_central_force(Vector3(0,ProjectSettings.get_setting("physics/3d/default_gravity")/5,0))
			body.reduce_bounce()
		body.slow()


func _on_body_exited(body):
	if body.has_method("speedup"):
		body.speedup()
