extends Node2D

const TAM_AREA := Vector2(500, 600)
const ESPACIADO_HORIZONTAL := 170
const ESPACIADO_VERTICAL := 90
const POS_INICIAL := Vector2(100, 10)

# Cada fila es un array de bloques (Node2D)
var filas: Array = []  # Contiene Array[Node2D]

func _draw() -> void:
	draw_rect(Rect2(Vector2.ZERO, TAM_AREA), Color(1, 0, 0, 0.2), true)

func esta_dentro(pos: Vector2) -> bool:
	var rect_area := Rect2(global_position + POS_INICIAL, TAM_AREA)
	return rect_area.has_point(pos)

func on_bloque_soltado(bloque: Node2D) -> void:
	if esta_dentro(bloque.global_position):
		mover_bloque(bloque)
	else:
		eliminar_bloque(bloque)

func mover_bloque(bloque: Node2D) -> void:
	var fila_anterior: Array = []
	for fila in filas:
		if bloque in fila:
			fila.erase(bloque)
			fila_anterior = fila
			break

	filas = filas.filter(func(f): return f.size() > 0)

	if fila_anterior.size() > 0:
		ordenar_fila(fila_anterior)

	agregar_bloque(bloque)

func agregar_bloque(bloque: Node2D) -> void:
	if not bloque.get_parent():
		add_child(bloque)

	var y := bloque.global_position.y
	var fila_objetivo = obtener_fila_mas_cercana(y)

	if fila_objetivo == null:
		var nueva_fila: Array = []
		filas.append(nueva_fila)
		fila_objetivo = nueva_fila

	var insertado := false
	for i in range(fila_objetivo.size()):
		var otro = fila_objetivo[i]
		if is_instance_valid(otro) and bloque.global_position.x < otro.global_position.x:
			fila_objetivo.insert(i, bloque)
			insertado = true
			break

	if not insertado:
		fila_objetivo.append(bloque)

	ordenar_fila(fila_objetivo)

func ordenar_fila(fila: Array) -> void:
	fila = fila.filter(func(b): return is_instance_valid(b))
	if fila.size() == 0:
		return

	var index: int = filas.find(fila)
	var y_fila: float = POS_INICIAL.y + index * ESPACIADO_VERTICAL

	for i in range(fila.size()):
		var destino: Vector2 = Vector2(POS_INICIAL.x + i * ESPACIADO_HORIZONTAL, y_fila)
		var tween: Tween = get_tree().create_tween()
		tween.tween_property(fila[i], "position", destino, 0.15)

func obtener_fila_mas_cercana(y_pos: float):
	var tolerancia: float = ESPACIADO_VERTICAL / 2

	for fila in filas:
		if fila.is_empty():
			continue

		var y_total: float = 0.0
		var count: int = 0
		for b in fila:
			if is_instance_valid(b):
				y_total += b.global_position.y
				count += 1

		if count == 0:
			continue

		var y_promedio: float = y_total / count
		if abs(y_pos - y_promedio) <= tolerancia:
			return fila

	return null

func eliminar_bloque(bloque: Node2D) -> void:
	for fila in filas:
		if bloque in fila:
			fila.erase(bloque)
			break
	filas = filas.filter(func(f): return f.size() > 0)
	bloque.queue_free()
