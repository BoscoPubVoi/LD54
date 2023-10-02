extends Sprite3D


func _on_area_3d_body_entered(_body):
	$AnimationPlayer.play("rustle")
