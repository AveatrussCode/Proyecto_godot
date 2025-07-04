extends Area2D

var player_is_near = false

func _ready():
	$Label.hide()

func cambio_escena() ->void:
	GLOBAL.create_transition(self,2)
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://Escenas/Plan_de_Estudio/Primer_Semestre/clase_01/clase_0.tscn")
	
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
