class_name basic_ball
extends RigidBody3D


var speed = 20

@onready var shadowcaster = $ShadowCast
@onready var shadow = $ShadowMesh

func apply_new_force(direction, new_speed):
	
	direction = Vector3(direction.x, 1, direction.z)
	direction = direction.normalized()
	direction = direction * new_speed / 2
#	direction.x = direction.x * new_speed / 2
#	direction.z = direction.z * new_speed / 2
	direction.y = new_speed/4
	
	apply_impulse(direction)
	global_position = Vector3.ZERO


func _physics_process(_delta):
	#makes a drop shadow underneath (better than a normal shadow for perspective)
	shadow.global_position = shadowcaster.get_collision_point()
