extends Area2D
var player_is_near = false
var numero_escena = 0;
func _ready():
	$Label.hide()
	$"../Area_ingresar_sanbox/Label".hide()
func cambio_escena() ->void:
	GLOBAL.create_transition(self,2)
	await get_tree().create_timer(1).timeout
	var clase = preload("res://Escenas/Escenarios_Mapas/clase_computacion.tscn")
	var sanbox = preload("res://Escenas/Escenas_Globales/sanbox/area_sanbox.tscn")
	if (numero_escena == 1):
		get_tree().change_scene_to_packed(clase)
	if (numero_escena == 2):
		get_tree().change_scene_to_packed(sanbox)
		
func _process(delta):
	if player_is_near and Input.is_action_just_pressed("ui_accept"):
		cambio_escena()
		



func _on_body_entered(body: Node2D) -> void:
	if body.name == "Protagonista":
		player_is_near = true
		numero_escena = 1;
		$Label.show()
func _on_body_exited(body: Node2D) -> void:
	if body.name == "Protagonista":
		player_is_near = false
		numero_escena = 0;
		$Label.hide()


func _on_area_ingresar_sanbox_body_entered(body: Node2D) -> void:
	if body.name == "Protagonista":
		player_is_near = true
		numero_escena = 2;
		$"../Area_ingresar_sanbox/Label".show()


func _on_area_ingresar_sanbox_body_exited(body: Node2D) -> void:
	if body.name == "Protagonista":
		player_is_near = false
		numero_escena = 0;
		$"../Area_ingresar_sanbox/Label".hide()
