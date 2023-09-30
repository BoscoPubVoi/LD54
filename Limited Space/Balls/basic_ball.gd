class_name basic_ball
extends RigidBody3D


var speed = 20

@onready var shadowcaster = $ShadowCast
@onready var shadow = $ShadowMesh

func apply_new_force(direction, new_speed):
	
	direction = Vector3(direction.x, 1, direction.z)
	direction = direction.normalized() * new_speed
	
	apply_impulse(direction)
	global_position = Vector3.ZERO


func _physics_process(delta):
	#makes a drop shadow underneath (better than a normal shadow for perspective)
	shadow.global_position = shadowcaster.get_collision_point()
