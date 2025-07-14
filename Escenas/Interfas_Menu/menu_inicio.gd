extends Control

func _ready():
	GLOBAL.create_transition(self,1)

func _on_new_game_pressed() -> void:
	GLOBAL.create_transition(self,2)
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://Escenas/Escenarios_Mapas/mapa_principal/mapa_universidad.tscn")


func _on_load_game_pressed() -> void:
	GLOBAL.load_game()
	GLOBAL.create_transition(self,2)
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://Escenas/Escenarios_Mapas/clase_computacion.tscn")


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/Interfas_Menu/Opciones.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
