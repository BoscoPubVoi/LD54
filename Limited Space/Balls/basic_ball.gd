class_name basic_ball
extends RigidBody3D


var speed = 20

@onready var shadowcaster = $ShadowCast
@onready var shadow = $ShadowMesh

func apply_new_force(direction):
	print("wiggle")
	direction = Vector3(direction.x, 1, direction.z)
	direction = direction.normalized() * speed
	apply_impulse(direction)
	global_position = Vector3.ZERO
	show()

func _physics_process(delta):
	shadow.global_position = shadowcaster.get_collision_point()
