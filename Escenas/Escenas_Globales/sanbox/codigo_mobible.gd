extends Node2D

@onready var contenedor_bloques := $"."
var velocidad_scroll := 30
var limite_superior := 0
var limite_inferior := -300  # Puedes ajustar este valor según la cantidad de bloques



func _ready():
	for bloque in get_children():
		if bloque.has_node("Area2D"):
			var area = bloque.get_node("Area2D")
			area.connect("input_event", Callable(self, "_on_bloque_click").bind(bloque))

func _on_bloque_click(viewport, event, shape_idx, bloque):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if bloque.get("es_original") == false:
			return  # No duplicar si ya es copia

		var copia: Node2D = bloque.duplicate()
		copia.set("es_original", false)

		var sandbox = get_parent()  # Asumiendo que codigo_mobible es hijo directo de Area_sandbox
		sandbox.add_child(copia)
		copia.global_position = bloque.global_position

		if copia.has_method("empezar_arrastre"):
			copia.empezar_arrastre()






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

	
