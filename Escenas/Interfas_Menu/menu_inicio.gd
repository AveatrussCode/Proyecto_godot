extends Control

func _on_new_game_pressed() -> void:
	pass # Replace with function body.


func _on_load_game_pressed() -> void:
	pass # Replace with function body.


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/Interfas_Menu/Opciones.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
