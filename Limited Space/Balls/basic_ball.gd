class_name basic_ball
extends RigidBody3D


var speed = 20
var TouchedGround : bool = false;

@onready var shadowcaster = $ShadowCast
@onready var shadow = $ShadowMesh

@onready var audioplayer : AudioStreamPlayer3D = $AudioStreamPlayer3D

func _ready():

	var root = get_tree().get_first_node_in_group("LevelRoot")
	
	if root != null && root.has_signal("LevelEnded") : 
		root.LevelEnded.connect(_on_level_ended)


func apply_new_force(direction, new_speed):
	new_speed = new_speed * randf_range(.9, 1.1)
	direction = Vector3(direction.x * randf_range(.9, 1.1), 1, direction.z * randf_range(.9, 1.1))
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
		var distance_to_ground = (global_position.y - shadowcaster.get_collision_point().y)
		var dist = clamp(remap(distance_to_ground, 0, 10, 0.2, 0.8), 0.2, 0.8)
		var alpha = lerp(255, 0, ease(dist, 0.2))
		var mat = StandardMaterial3D.new()
		mat.albedo_color = Color(0, 0, 0, alpha)
		mat.transparency = true
		$ShadowMesh.set_surface_override_material(0, mat)
	else:
		shadow.hide()
	if linear_velocity.y < 0:
		gravity_scale = 2
	else:
		gravity_scale = 1


func _on_body_entered(body:Node):
#	print("uh oh")
	if body.has_method("BallInHole"):
		body.BallInHole()
	elif !TouchedGround:
		TouchedGround = true
		audioplayer.play()
		Global.IncrementScore()
	
	if body.is_in_group("water"):
		var newsplash = load("res://Nature/splash_particles.tscn").instantiate()
		add_sibling(newsplash)
		newsplash.position = position
		audioplayer.play()
		self.queue_free()
		return
		
	explode()

func slow():
	speed = 7
	
func speedup():
	speed = 14

func _on_level_ended():
	self.call_deferred("set_contact_monitor", false);
	self.continuous_cd = false;

func explode():
	pass



func disable_collisions():
	$CollisionShape3D.queue_free()
