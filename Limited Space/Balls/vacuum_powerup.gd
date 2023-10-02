extends RigidBody3D

@onready var player = get_tree().get_first_node_in_group("player")
var being_swallowed = false

func _ready():
	pass # Replace with function body.


func _process(delta):
	if being_swallowed:
		position.x = lerp(position.x, player.position.x, .05)
		position.z = lerp(position.z, player.position.z, .05)
		position.y -= .05


func get_eaten():
	print("whump")
	set_collision_layer_value(9, false)
	being_swallowed = true

func shoot_to_player():
	var direction = position - player.position
	direction.y = (direction.x + direction.z /2)
	direction = direction.normalized() * position.distance_to(player.distance)/2.0
	apply_impulse(direction)
	pass
