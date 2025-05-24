extends ColorRect


func star(transition_type):
	match transition_type:
		1:
			$AnimationPlayer.play("Animacion_trancicion")
		2:
			$AnimationPlayer.play("leave_out")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
