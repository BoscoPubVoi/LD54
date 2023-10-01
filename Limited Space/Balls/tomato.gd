extends basic_ball

var splat = preload("res://Nature/tomato_splatter.tscn")
var scatter_amount = 4

func explode():
	var newsplat = splat.instantiate()
	add_sibling(newsplat)
	newsplat.position = position
	queue_free()

