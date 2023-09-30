extends basic_ball

var splat = preload("res://Nature/tomato_splatter.tscn")
var scatter_amount = 4

func explode():
	var newBall = splat.instantiate()
	add_sibling(newBall)
	newBall.position = position
	queue_free()
