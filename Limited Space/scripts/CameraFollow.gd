extends Camera3D

@export var offset : Vector3
@export var speed : float = 1.0
@export var target : Node3D 

func _ready():
	set_physics_process(true)
	look_at_from_position(global_position, target.global_position, Vector3.UP)

func _physics_process(delta):
	var w = ProjectSettings.get_setting("display/window/size/viewport_width")
	var h = ProjectSettings.get_setting("display/window/size/viewport_height")
	
	var targetPos = unproject_position(target.global_position)
	var camPos = Vector2(w/2,h/2)
	
	var d_x = absf(camPos.x - targetPos.x)
	var d_y = absf(camPos.y - targetPos.y)

	if d_x > 100 or d_y > 50:
		global_position = lerp(global_position, target.global_position + offset, delta * (d_x/100 + d_y/50) * speed)
	
	look_at_from_position(global_position, global_position - offset, Vector3.UP)
