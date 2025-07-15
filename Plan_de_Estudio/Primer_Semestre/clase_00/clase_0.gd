"""extends Node2D

func _ready() -> void:
	Dialogic.start("res://Plan_de_Estudio/Primer_Semestre/clase_00/Inprimir_nuetro_hola_mundo.dtl")
"""

extends Node2D

func _ready() -> void:
	Dialogic.timeline_ended.connect(_on_dialogic_timeline_end)
	Dialogic.start("res://Plan_de_Estudio/Primer_Semestre/clase_00/Inprimir_nuetro_hola_mundo.dtl")

func _on_dialogic_timeline_end() -> void:
	GLOBAL.create_transition(self, 2)
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://Escenas/Escenarios_Mapas/clase_computacion.tscn")
