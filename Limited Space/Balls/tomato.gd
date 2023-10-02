extends basic_ball

@export var model : Node
var splat = preload("res://Nature/tomato_splatter.tscn")
var scatter_amount = 4

func explode():
	var newsplat = splat.instantiate()
	add_sibling(newsplat)
	newsplat.position = position - Vector3.UP * 0.2
	queue_free()

func _process(delta):
	model.look_at(transform.origin + linear_velocity + Vector3.RIGHT, Vector3.UP)
	pass

func apply_new_force(direction, new_speed):
	super.apply_new_force(direction, new_speed)
