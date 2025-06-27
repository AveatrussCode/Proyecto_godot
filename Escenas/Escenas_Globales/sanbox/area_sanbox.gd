extends Node2D

func _ready():
	call_deferred("_configurar_bloques")

func _configurar_bloques():
	print("📍 Ruta completa de este nodo:", get_path())
	print("▶️ Buscando bloques...")
	for bloque in $codigo_mobible.get_children():
		print("🔍 Revisando bloque:", bloque.name)
		Configurador.configurar_bloque(bloque)

func _soltar_bloque(bloque: Node2D) -> void:
	var area_codigo = $Area_codigo
	if area_codigo.esta_dentro(bloque.global_position):
		print("✅ Está dentro del área")
		area_codigo.agregar_bloque(bloque)
	else:
		print("❌ Fuera del área, se elimina")
		bloque.queue_free()
