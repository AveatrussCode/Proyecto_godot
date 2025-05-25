extends Area2D
var player_is_near = false

func _ready():
	$Label.hide()

func cambio_escena() ->void:
	var new_esena = preload("res://Escenas/Escenarios_Mapas/clase_computacion.tscn")
	get_tree().change_scene_to_packed(new_esena)
	
func _process(delta):
	if player_is_near and Input.is_action_just_pressed("ui_accept"):
		cambio_escena()
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Protagonista":
		player_is_near = true
		$Label.show()
func _on_body_exited(body: Node2D) -> void:
	if body.name == "Protagonista":
		player_is_near = false
		$Label.hide()
