extends CharacterBody3D

signal hit

var IsAlive : bool = true
var powered : bool = false

@onready var mesh = $Mesh
@export var speed : float = 10
@export var acceleration : float = 10

const JUMP_VELOCITY = 4.5
const ANGULAR_ACCELERATION = 10

var push_force = .5;
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var spring_velocity = 0
var spring_velocity_scale_x = 0
var spring_velocity_scale_z = 0
var raycaster

func _ready():
	spawn_raycaster()

func _physics_process(delta):
	move(delta)
	process_collisions()
	align_to_ground(delta)

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
		
	var input_dir = -Input.get_vector("left", "right", "up", "down")
	var direction = (transform.basis * -Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var target_speed_x = 0.0
	var target_speed_z = 0.0
	
	if direction:
		target_speed_x = direction.x * speed
		target_speed_z = direction.z * speed
		acceleration = 10
	else:
		acceleration = 2
	
	if velocity.x > 0 && target_speed_x < 0:
		# mesh.scale.x = lerp(mesh.scale.x, 0.7, .2)
		stretch_mesh(0.7, 1.2, delta)
		acceleration = 3
	elif velocity.x < 0 && target_speed_x > 0:
		# mesh.scale.x = lerp(mesh.scale.x, 0.7, .2)
		stretch_mesh(0.7, 1.2, delta)
		acceleration = 3
	elif velocity.z > 0 && target_speed_z < 0:
		# mesh.scale.z = lerp(mesh.scale.z, 0.7, .2)
		stretch_mesh(1.2, 0.7, delta)
		acceleration = 3
	elif velocity.z < 0 && target_speed_z > 0:
		# mesh.scale.z = lerp(mesh.scale.z, 0.7, .2)
		stretch_mesh(1.2, 0.7, delta)
		acceleration = 3
	else:
		stretch_mesh(1.0, 1.0, delta)
		# mesh.scale.x = lerp(mesh.scale.x, 1.0, .02)
		# mesh.scale.z = lerp(mesh.scale.z, 1.0, .02)

	velocity.x = lerp(velocity.x, target_speed_x, delta * acceleration); 
	velocity.z = lerp(velocity.z, target_speed_z, delta * acceleration); 
	velocity.y -= gravity * delta * 1.5
	move_and_slide()
	

func stretch_mesh(x_scale, z_scale, delta):
	var new_scale = Global.SpringStep(mesh.scale.z, spring_velocity_scale_z, z_scale, delta, 0.3, 5)
	mesh.scale.z = new_scale[0]
	spring_velocity_scale_z = new_scale[1]

	new_scale = Global.SpringStep(mesh.scale.x, spring_velocity_scale_x, x_scale, delta, 0.3, 5)
	mesh.scale.x = new_scale[0]
	spring_velocity_scale_x = new_scale[1]

func align_to_ground(delta):
	var groundNormal = raycaster.get_collision_normal()

	groundNormal.x = Global.SpringStep(self.basis.y.x, spring_velocity, groundNormal.x, delta, 0.4, 60)[0]
	groundNormal.y = Global.SpringStep(self.basis.y.y, spring_velocity, groundNormal.y, delta, 0.4, 60)[0]
	var springZ = Global.SpringStep(self.basis.y.z, spring_velocity, groundNormal.z, delta, 0.4, 60)
	groundNormal.z = springZ[0]
	spring_velocity = springZ[1]

	self.basis.y = groundNormal
	self.basis.x = -basis.z.cross(groundNormal)
	self.basis = basis.orthonormalized()


func BallInHole():
	if !IsAlive || powered:
		return
	Global.isDead = true
	IsAlive = false
	die()

func die():
	print("dead")
	hit.emit()

func slow():
	speed = 5

func speedup():
	speed = 10


func _on_area_3d_body_entered(body):
	print("found somethin")
	if body.is_in_group("powerup"):
		print("found powerup")
		body.get_eaten()
		$Vacuum.emitting = true
		powered = true
		$PowerupTimer.start()
		return
	if !powered:
		body.disable_collisions()
		BallInHole()

func spawn_raycaster():
	raycaster = RayCast3D.new()
	raycaster.enabled = true
	raycaster.set_collision_mask_value(1, true)
	raycaster.exclude_parent = false
	raycaster.target_position = Vector3(0, -2, 0)
	self.add_child(raycaster) 


func _on_powerup_timer_timeout():
	powered = false
	$Vacuum.emitting = false
