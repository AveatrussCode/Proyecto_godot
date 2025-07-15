extends Node2D

func _ready() -> void:
	Dialogic.timeline_ended.connect(_on_dialogic_timeline_end)
	Dialogic.start("res://Plan_de_Estudio/Primer_Semestre/clase_04/clase_04_1.dtl")

func _on_dialogic_timeline_end() -> void:
	GLOBAL.create_transition(self, 2)
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://Escenas/Escenarios_Mapas/clase_computacion.tscn")
