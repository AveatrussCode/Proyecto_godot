extends Node2D

@onready var contenedor_bloques := $"."
var velocidad_scroll := 30
var limite_superior := 0
var limite_inferior := -300  # Puedes ajustar este valor según la cantidad de bloques

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			mover_bloques(Vector2(0, velocidad_scroll))
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			mover_bloques(Vector2(0, -velocidad_scroll))

func mover_bloques(delta: Vector2):
	var nueva_pos: Vector2 = contenedor_bloques.position + delta

	# Limita el movimiento vertical (esto evita que suba demasiado o se salga de la pantalla)
	if nueva_pos.y > limite_superior:
		nueva_pos.y = limite_superior
	elif nueva_pos.y < limite_inferior:
		nueva_pos.y = limite_inferior
	contenedor_bloques.position = nueva_pos
