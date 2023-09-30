extends CharacterBody3D

signal hit

var IsAlive : bool = true

@export var speed : float = 10
@export var acceleration : float = 10

const JUMP_VELOCITY = 4.5
const ANGULAR_ACCELERATION = 10

var push_force = .5;
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	move(delta)
	process_collisions()

func process_collisions():
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		for k in range(collision.get_collision_count()):
			var body = collision.get_collider(k) as RigidBody3D
			if body == null:
				continue
			var point = collision.get_position(k) - body.global_position
			body.apply_impulse(-collision.get_normal(k) * push_force, point)

func move(delta):
	if !IsAlive:
		return
	
#	if not is_on_floor():
#		velocity.y -= gravity * delta

	var input_dir = -Input.get_vector("left", "right", "up", "down")
	var direction = (transform.basis * -Vector3(input_dir.x, 0, input_dir.y)).normalized()

	var target_speed_x = 0.0
	var target_speed_z = 0.0

	if direction:
		target_speed_x = direction.x * speed
		target_speed_z = direction.z * speed

	velocity.x = lerp(velocity.x, target_speed_x, delta * acceleration); 
	velocity.z = lerp(velocity.z, target_speed_z, delta * acceleration); 

	move_and_slide()

func BallInHole():
	if !IsAlive:
		return
	IsAlive = false
	die()

func die():
	print("dead")
	hit.emit()
