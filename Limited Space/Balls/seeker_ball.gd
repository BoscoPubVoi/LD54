extends basic_ball



func _on_timer_timeout():
	linear_velocity = Vector3.ZERO
	gravity_scale = 0
	$AnimationPlayer.play("Get_ready")


func _on_animation_player_animation_finished(anim_name):
	apply_impulse((get_tree().get_first_node_in_group("player").global_position - global_position).normalized() * 3)
