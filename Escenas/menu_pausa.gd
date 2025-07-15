extends Node


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Escape"):  # o "Escape" si lo configuraste así
		get_tree().paused = not get_tree().paused
		$Popup.visible = not $Popup.visible



func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/Interfas_Menu/menu_inicio.tscn")
	pass
