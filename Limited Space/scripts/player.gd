extends CharacterBody3D

signal hit

var IsAlive : bool = true

@export var speed : float = 10
@export var acceleration : float = 4

const JUMP_VELOCITY = 4.5
const ANGULAR_ACCELERATION = 10

var push_force = .5;
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var spring_velocity = 0
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

	velocity.x = lerp(velocity.x, target_speed_x, delta * acceleration); 
	velocity.z = lerp(velocity.z, target_speed_z, delta * acceleration); 
	velocity.y -= gravity * delta * 1.5
	move_and_slide()


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
	if !IsAlive:
		return

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
	body.disable_collisions()
	BallInHole()

func spawn_raycaster():
	raycaster = RayCast3D.new()
	raycaster.enabled = true
	raycaster.set_collision_mask_value(1, true)
	raycaster.exclude_parent = false
	raycaster.target_position = Vector3(0, -2, 0)
	self.add_child(raycaster) 
