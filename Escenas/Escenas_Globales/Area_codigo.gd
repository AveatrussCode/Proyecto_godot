extends Node2D

const TAM_AREA := Vector2(500, 380)
const ESPACIADO_HORIZONTAL := 50
const ESPACIADO_VERTICAL := 28
const POS_INICIAL := Vector2(60, 50)

# Cada fila es un array de bloques (Node2D)
var filas: Array = []  # Contiene Array[Node2D]
func esta_dentro(pos: Vector2) -> bool:
	var rect_area := Rect2(global_position + POS_INICIAL, TAM_AREA)
	return rect_area.has_point(pos)


func agregar_bloque(bloque: Node2D) -> void:
	# Si no tiene padre, lo añadimos al área
	if not bloque.get_parent():
		add_child(bloque)

	# Quitar si ya estaba
	quitar_bloque_si_ya_estaba(bloque)

	# Buscar fila más cercana
	var y = bloque.global_position.y
	var fila = obtener_fila_mas_cercana(y)
	if fila == null:
		fila = []
		filas.append(fila)
		

	# Calcular posición horizontal adecuada
	var index = obtener_posicion_horizontal(fila, bloque)

	# Insertar y reacomodar
	insertar_en_fila(fila, bloque, index)

func insertar_en_fila(fila: Array, bloque: Node2D, indice: int) -> void:
	fila.insert(indice, bloque)
	for i in range(fila.size()):
		if not is_instance_valid(fila[i]):
			continue
		var destino = POS_INICIAL + Vector2(i * ESPACIADO_HORIZONTAL, filas.find(fila) * ESPACIADO_VERTICAL)
		var tween = get_tree().create_tween()
		tween.tween_property(fila[i], "position", destino, 0.15)
	var bloque_a_mover_a_area_codigo = bloque
	bloque.get_parent().remove_child(bloque)
	$".".add_child(bloque_a_mover_a_area_codigo)
	
	
func obtener_posicion_horizontal(fila: Array, bloque: Node2D) -> int:
	var x = bloque.global_position.x
	for i in range(fila.size()):
		var b = fila[i]
		if is_instance_valid(b) and x < b.global_position.x:
			return i
	return fila.size()  # al final
func quitar_bloque_si_ya_estaba(bloque: Node2D) -> void:
	for fila in filas:
		if bloque in fila:
			var idx = fila.find(bloque)
			fila.erase(bloque)
			if fila.size() > idx:
				for i in range(idx, fila.size()):
					var destino = POS_INICIAL + Vector2(i * ESPACIADO_HORIZONTAL, filas.find(fila) * ESPACIADO_VERTICAL)
					var tween = get_tree().create_tween()
					tween.tween_property(fila[i], "position", destino, 0.15)

			break
	# Limpiar filas vacías
	filas = filas.filter(func(f): return f.size() > 0)
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
	
func parsear_codigo() -> Array:
	var tokens: Array = []

	for fila in filas:
		for bloque in fila:
			if not is_instance_valid(bloque):
				continue

			if bloque.has_node("Label"):
				var label_node: Label = bloque.get_node("Label")
				var texto: String = label_node.text.strip_edges()
				tokens.append(texto)
	
	return tokens
