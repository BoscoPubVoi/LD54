extends basic_ball


#new speed here is the direciton, not a speed
func apply_new_force(direction, new_speed):
	direction = Vector3.BACK.rotated(Vector3.UP, (PI/2) * new_speed)
	direction = direction.normalized()
	direction = direction /16.0
#	direction.x = direction.x * new_speed / 2
	direction.y = .09
	
	apply_impulse(direction)
	global_position = Vector3.ZERO
