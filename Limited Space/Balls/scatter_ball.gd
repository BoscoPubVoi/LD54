extends basic_ball

var tinyBall = preload("res://Balls/scatter_ball_tiny.tscn")
var scatter_amount = 4

func explode():
	linear_velocity = Vector3.ZERO
	var ball_array = []
	for i in scatter_amount:
		var newBall = tinyBall.instantiate()
		add_sibling(newBall)
		newBall.apply_new_force(get_global_transform().basis.z, i)
		newBall.global_position = global_position
		ball_array.append(newBall)
	$CPUParticles3D.emitting = true
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	$scattershot.hide()
	shadow.hide()


