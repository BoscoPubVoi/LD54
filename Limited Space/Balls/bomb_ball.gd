extends basic_ball

var explosion_size = 5
var ball_array = []



func explode():
	var newsplash = load("res://Nature/explosion_particle.tscn").instantiate()
	newsplash.position = global_position
	add_sibling(newsplash)
	
	for i in ball_array.size():
		var direction = ball_array[i].global_position - global_position
		direction.normalized()
		direction.x = direction.x * 0.2
		direction.z = direction.z * 0.2
		direction.y = 1
		ball_array[i].apply_impulse(direction)
	
	queue_free()


func _on_explosion_area_body_entered(body):
	if body.is_in_group("ball"):
		ball_array.append(body)


func _on_explosion_area_body_exited(body):
	if body.is_in_group("ball"):
		ball_array.erase(body)
