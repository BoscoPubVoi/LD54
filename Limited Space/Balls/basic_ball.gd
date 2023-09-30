class_name basic_ball
extends RigidBody3D


var speed = 20

@onready var shadowcaster = $ShadowCast
@onready var shadow = $ShadowMesh

func _ready():
	var root = get_tree().get_first_node_in_group("LevelRoot")
	
	if root != null && root.has_signal("LevelEnded") : 
		root.LevelEnded.connect(_on_level_ended)


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
	shadow.global_position = shadowcaster.get_collision_point()


func _on_body_entered(body:Node):
	if body.has_method("BallInHole"):
		body.BallInHole()


func slow():
	speed = 7
	
func speedup():
	speed = 14

func _on_level_ended():
	self.contact_monitor = false;
	self.continuous_cd = false;
