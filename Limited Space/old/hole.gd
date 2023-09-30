extends CharacterBody3D

var speed = .2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_pressed("left"):
		position.x -= speed
	if Input.is_action_pressed("right"):
		position.x += speed
	if Input.is_action_pressed("up"):
		position.z -= speed
	if Input.is_action_pressed("down"):
		position.z += speed


func BallInHole():
	print("RIP")
