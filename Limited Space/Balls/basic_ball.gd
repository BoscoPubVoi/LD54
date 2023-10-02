class_name basic_ball
extends RigidBody3D


var speed = 20
var TouchedGround : bool = false;

@onready var shadowcaster = $ShadowCast
@onready var shadow = $ShadowMesh

@export var land_sounds : Array[AudioStreamWAV]
@onready var audioplayer : AudioStreamPlayer3D = $AudioStreamPlayer3D
@onready var player = get_tree().get_first_node_in_group("player")

var down_grav = 2
var being_swallowed = false

func _ready():

	var root = get_tree().get_first_node_in_group("LevelRoot")
	
	if root != null && root.has_signal("LevelEnded") : 
		root.LevelEnded.connect(_on_level_ended)

func _process(delta):
	if being_swallowed:
		position.x = lerp(position.x, player.position.x, .05)
		position.z = lerp(position.z, player.position.z, .05)
		position.y -= .05
	
	if position.y < 10:
		queue_free()

func apply_new_force(direction, new_speed):
	new_speed = new_speed * randf_range(.9, 1.1)
	direction = Vector3(direction.x * randf_range(.9, 1.1), 1, direction.z * randf_range(.9, 1.1))
	direction = direction.normalized()
	direction = direction * new_speed /17
	direction.y = new_speed/30
	
	apply_impulse(direction)
	global_position = Vector3.ZERO

func _physics_process(_delta):
	#makes a drop shadow underneath (better than a normal shadow for perspective)
	if shadowcaster.is_colliding():
		shadow.show()
		shadow.global_position = shadowcaster.get_collision_point()
		var distance_to_ground = (global_position.y - shadowcaster.get_collision_point().y)
		var dist = clamp(remap(distance_to_ground, 0, 10, 0.2, 1.0), 0.2, 1.0)
		var alpha = lerp(1.0, 0.1, ease(dist, 0.2))
		var mat = StandardMaterial3D.new()
		mat.albedo_color = Color(0, 0, 0, alpha)
		mat.transparency = true
		$ShadowMesh.set_surface_override_material(0, mat)
	else:
		shadow.hide()
	if linear_velocity.y < 0:
		gravity_scale = down_grav
	else:
		gravity_scale = 1


func _on_body_entered(body:Node):
#	print("uh oh")
	if body.has_method("BallInHole"):
		body.BallInHole()
		if body.isPowered():
			apply_impulse(Vector3.UP * .5)
		else:
			being_swallowed = true
		
	elif !TouchedGround:
		TouchedGround = true
		var land_clip = land_sounds[randi() % land_sounds.size()]
		audioplayer.set_stream(land_clip)
		audioplayer.pitch_scale = randf_range(0.8, 1.2)
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
	if !being_swallowed:
		#freeze
		speed = 0
		set_physics_process(false)
		gravity_scale = 0
		linear_velocity = Vector3.ZERO

func explode():
	down_grav += .3
	pass

func reduce_bounce():
	linear_velocity *= 0.5

func disable_collisions():
	$CollisionShape3D.queue_free()
