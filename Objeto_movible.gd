extends Node2D

#verifica y da le visto bueno al movimiento
var movible = false
#valida el aria
var esta_dentro_del_area_movible = false
var body_ref
#diferencia entre el mouse y el sentro de la caja
var offset: Vector2
#guarda la posicion antes de mover
var posicion_inicial : Vector2

func _process(delta: float) -> void:
	if movible:
		#esto actualisa la posicion y pone el color d ela caja
		if Input.is_action_just_pressed("click"):
			posicion_inicial = global_position
			offset = get_global_mouse_position() - global_position
			GLOBAL.is_dragging = true
		if Input.is_action_pressed("click"):
			global_position = get_global_mouse_position() - offset
		elif Input.is_action_just_released("click"):
			GLOBAL.is_dragging = false
			var tween = get_tree().create_tween()
			if esta_dentro_del_area_movible:
				tween.tween_property(self, "position", body_ref.position,0.2).set_ease(Tween.EASE_OUT)
			else:
				tween.tween_property(self, "global_position", posicion_inicial,0.2).set_ease(Tween.EASE_OUT)
		



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group('movible'):
		esta_dentro_del_area_movible = true
		body.modulate = Color(Color.REBECCA_PURPLE,1)
		body_ref = body


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group('movible'):
		esta_dentro_del_area_movible = false
		body.modulate = Color(Color.REBECCA_PURPLE,0.7)

func _on_area_2d_mouse_entered() -> void:
	if not GLOBAL.is_dragging:
		movible = true
		scale = Vector2(1.07,1.07)
		


func _on_area_2d_mouse_exited() -> void:
	if not GLOBAL.is_dragging:
		movible = false
		scale = Vector2(1,1)
