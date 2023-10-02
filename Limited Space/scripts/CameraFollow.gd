extends Camera3D

@export var offset : Vector3
@export var speed : float = 1.0
@export var target : Node3D 

var deadzone : Vector2 = Vector2(0.1, 0.0001)

var resetoffset_z 
var resetoffset_y
var reset_speed
var target_offset_z
var target_speed
var target_offset_y

func _ready():
	resetoffset_z = offset.z
	resetoffset_y = offset.y
	reset_speed = speed
	target_offset_z = offset.z
	target_offset_y = offset.y
	target_speed = speed
	set_physics_process(true)
	look_at_from_position(global_position, target.global_position, Vector3.UP)
	var root = get_tree().get_first_node_in_group("LevelRoot")
	root.LevelEnded.connect(end)

func _physics_process(delta):
	var w = ProjectSettings.get_setting("display/window/size/viewport_width")
	var h = ProjectSettings.get_setting("display/window/size/viewport_height")
	var screen = Vector2(w,h)

	var targetPos = unproject_position(target.global_position) / screen #normalized
	var camPos = Vector2(w/2,h/2) / screen # normalized
	
	var d_x = absf(camPos.x - targetPos.x)
	var d_y = absf(camPos.y - targetPos.y)
	
	if d_x > deadzone.x or d_y > deadzone.y:
		var t = delta * speed * clamp(deadzone.x + deadzone.y * 20, 1, 100)
		global_position = lerp(global_position, target.global_position + offset, t)
	
	look_at_from_position(global_position, global_position - offset, Vector3.UP)
	speed = lerp(speed, target_speed, .1)
	offset.z = lerp(offset.z, target_offset_z, .03)
	offset.y = lerp(offset.y, target_offset_y, .03)

func end():
	deadzone = Vector2.ZERO
	var tween := create_tween()
	tween.tween_property(self, "fov", 20, 0.4)


func set_offset_and_speed():
	target_offset_z = 40.0
	target_offset_y = 20.0
	target_speed = 4.5

func reset_offset_and_speed():
	target_offset_z = resetoffset_z
	target_offset_y = resetoffset_y
	target_speed = reset_speed
