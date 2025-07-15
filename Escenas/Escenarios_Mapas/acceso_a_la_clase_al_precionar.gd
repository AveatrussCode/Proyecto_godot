extends Area2D

var player_is_near = false
var player_es_near_exit = false

func _ready():
	$Label.hide()
	$"../Label".hide()

func cambio_escena() ->void:
	GLOBAL.return_position = get_node("/root/Clase_computacion/Protagonista").global_position
	GLOBAL.create_transition(self,2)
	await get_tree().create_timer(1).timeout
	match GLOBAL.numero_clase:
		0:
			get_tree().change_scene_to_file("res://Plan_de_Estudio/Primer_Semestre/clase_00/clase_0.tscn")
		1:
			get_tree().change_scene_to_file("res://Plan_de_Estudio/Primer_Semestre/clase_01/clase_1.tscn")
		2:
			get_tree().change_scene_to_file("res://Plan_de_Estudio/Primer_Semestre/clase_01/clase_1_2.tscn")
		3: 
			get_tree().change_scene_to_file("res://Plan_de_Estudio/Primer_Semestre/clase_02/clase_02.tscn")
		4:
			get_tree().change_scene_to_file("res://Plan_de_Estudio/Primer_Semestre/clase_03/clase_3_1.tscn")
		5:
			get_tree().change_scene_to_file("res://Plan_de_Estudio/Primer_Semestre/clase_03/clase_3_2.tscn")
		_:
			GLOBAL.numero_clase = 0
			get_tree().change_scene_to_file("res://Plan_de_Estudio/Primer_Semestre/clase_00/clase_0.tscn")
			
			
			
			
			
func _process(delta):
	if player_is_near and Input.is_action_just_pressed("ui_accept"):
		GLOBAL.numero_clase = GLOBAL.numero_clase + 1
		GLOBAL.save_game()
		cambio_escena()
	if player_es_near_exit and Input.is_action_just_pressed("ui_accept"):
		GLOBAL.save_game()
		get_tree().change_scene_to_file("res://Escenas/Escenarios_Mapas/mapa_principal/mapa_universidad.tscn")
		

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Protagonista":
		player_is_near = true
		$Label.show()
func _on_body_exited(body: Node2D) -> void:
	if body.name == "Protagonista":
		player_is_near = false
		$Label.hide()
		


func _on_salida_body_entered(body: Node2D) -> void:
	if body.name == "Protagonista":
		player_es_near_exit = true
		$"../Label".show()


func _on_salida_body_exited(body: Node2D) -> void:
	if body.name == "Protagonista":
		player_es_near_exit = false
		$"../Label".hide()
