extends basic_ball

var splat = preload("res://Nature/tomato_splatter.tscn")
var scatter_amount = 4

func explode():
	var newsplat = splat.instantiate()
	add_sibling(newsplat)
	newsplat.position = position - Vector3.UP * 0.2
	queue_free()

