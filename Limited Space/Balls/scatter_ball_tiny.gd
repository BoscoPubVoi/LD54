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

func _on_body_entered(body:Node):
	if body.has_method("BallInHole"):
		body.BallInHole()
		if body.isPowered():
			apply_impulse(Vector3.UP * .5)
		else:
			being_swallowed = true
	elif !TouchedGround:
		TouchedGround = true
		Global.IncrementScore()
	
	if body.is_in_group("water"):
		var newsplash = load("res://Nature/splash_particles.tscn").instantiate()
		add_sibling(newsplash)
		newsplash.position = position
		AudioManager.play("splash")
		self.queue_free()
