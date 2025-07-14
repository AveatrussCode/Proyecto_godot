extends Node2D

@export var contenedor_codigo: NodePath

var movible = false
var esta_dentro_del_area_movible = false
var body_ref
var offset: Vector2
var posicion_inicial: Vector2
var copia




func _process(_delta):  
	if movible:
		if Input.is_action_just_pressed("click"):
			posicion_inicial = global_position
			offset = get_global_mouse_position() - global_position
			GLOBAL.is_dragging = true
		elif Input.is_action_pressed("click"):
			global_position = get_global_mouse_position() - offset
		elif Input.is_action_just_released("click"):
			GLOBAL.is_dragging = false

			# ✅ Llamamos a la función _soltar_bloque del nodo Sandbox
			var sandbox := get_tree().get_root().get_node("/root/Area_sanbox") # Ajusta si tu ruta no es esa
			if sandbox:
				sandbox._soltar_bloque(self)
			else:
				push_error("No se encontró el nodo Sandbox. Verifica la ruta.")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("movible"):
		esta_dentro_del_area_movible = true
		body.modulate = Color(Color.REBECCA_PURPLE, 1.0)
		body_ref = body

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("movible"):
		esta_dentro_del_area_movible = false
		body.modulate = Color(Color.REBECCA_PURPLE, 0.7)

func _on_area_2d_mouse_entered() -> void:
	if not GLOBAL.is_dragging:
		movible = true
		var tween = get_tree().create_tween()
		tween.tween_property(self, "scale", Vector2(1.07, 1.07), 0.1)
		


func _on_area_2d_mouse_exited() -> void:
	if not GLOBAL.is_dragging:
		movible = false
		var tween = get_tree().create_tween()
		tween.tween_property(self, "scale", Vector2(1, 1), 0.1)
