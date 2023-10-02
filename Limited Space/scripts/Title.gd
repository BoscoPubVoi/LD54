extends Label


var names = ["Balls Deep", "Hole in None", "Bogey", "Dodgegolf", "Ballhole", "Golf!!!"]

var rotationtarget = 0.0
var scaletarget = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	text = names.pick_random()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	scale = lerp(scale, Vector2(scaletarget, scaletarget), .02)
	get_parent().rotation = lerp(get_parent().rotation, rotationtarget, .02)
	if  abs(rotationtarget - get_parent().rotation) < 0.001:
		rotationtarget = randf_range(-PI/10, PI/10)
	if abs(scaletarget - scale.x) < 0.02:
		scaletarget = randf_range(0.8,1.2)

