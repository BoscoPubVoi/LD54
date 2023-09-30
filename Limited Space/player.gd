extends RigidBody3D

signal hit

@export var move_speed = 14

var target_velocity = Vector3.ZERO

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = Vector3.ZERO

	if Input.is_action_pressed("right"):
		direction.x += 1
	if Input.is_action_pressed("left"):
		direction.x -= 1
	if Input.is_action_pressed("down"):
		direction.z += 1
	if Input.is_action_pressed("up"):
		direction.z -= 1

	if direction != Vector3.ZERO:
		direction = direction.normalized()

	# Ground Velocity
	target_velocity.x = direction.x * move_speed
	target_velocity.z = direction.z * move_speed

# Called every frame. Used to control the rigidbody through physics
func _integrate_forces(state):
	# Move
	apply_central_force(target_velocity)


func _on_body_entered(body):
	die()
	
func die():
	hit.emit()
