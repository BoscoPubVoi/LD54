class_name basic_ball
extends RigidBody3D


var speed = 20

@onready var shadowcaster = $ShadowCast
@onready var shadow = $ShadowMesh

func apply_new_force(direction, new_speed):
	
	direction = Vector3(direction.x, 1, direction.z)
	direction = direction.normalized()
	direction = direction * new_speed /17
#	direction.x = direction.x * new_speed / 2
#	direction.z = direction.z * new_speed / 2
	direction.y = new_speed/30
	
	apply_impulse(direction)
	global_position = Vector3.ZERO

func _physics_process(_delta):
	#makes a drop shadow underneath (better than a normal shadow for perspective)
	if shadowcaster.is_colliding():
		shadow.show()
		shadow.global_position = shadowcaster.get_collision_point()
	else:
		shadow.hide()


func _on_body_entered(body:Node):
	if body.has_method("BallInHole"):
		body.BallInHole()
	explode()

func slow():
	speed = 7
	
func speedup():
	speed = 14


func explode():
	pass
