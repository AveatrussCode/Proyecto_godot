extends Node2D

func _ready():
	GLOBAL.create_transition(self,1)
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

func interpretar(tokens: Array) -> void:
	var i = 0
	while i < tokens.size():
		var token = tokens[i]

		match token.to_lower():
			"print":
				i += 1
				if i < tokens.size() and tokens[i] == "(":
					i += 1
					var argumento = ""
					while i < tokens.size() and tokens[i] != ")":
						argumento += tokens[i] + " "
						i += 1
					argumento = argumento.strip_edges()
					
					if i < tokens.size() and tokens[i] == ")":
						print("🖨️ Ejecutando: print(", argumento, ")")
					else:
						print("❌ Error: falta cierre de ) después de print")
				else:
					print("❌ Error: se esperaba ( después de print")
			
			_:
				print("❓ Token desconocido o inesperado:", token)
		
		i += 1

		
func _input(event):
	if event.is_action_pressed("ui_accept"):  # Por defecto, "Espacio"
		var tokens = $Area_codigo.parsear_codigo()
		print("🧱 Tokens detectados:", tokens) 
		interpretar(tokens)


func _on_option_button_item_selected(index: int) -> void:
	var valor = $OptionButton.get_item_text(index)
	$Label.text = valor  
