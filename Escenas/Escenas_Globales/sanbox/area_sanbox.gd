extends Node2D

@onready var label := $codigo_mobible/objeto9/Label
@onready var boton := $codigo_mobible/objeto9/Button
@onready var menu := $codigo_mobible/objeto9/OptionButton

@onready var label_n := $codigo_mobible/objeto10/Label
@onready var boton_n := $codigo_mobible/objeto10/Button_n
@onready var menu_n := $codigo_mobible/objeto10/OptionButton_n

func _ready():
	GLOBAL.create_transition(self,1)
	call_deferred("_configurar_bloques")
	# Rellenar opciones por código si quieres letras o números
	menu.clear()
	for letra in "ABCDEFGHIJKLMNOPQRSTUVWXYZ":  # o range(1, 11) para números
		menu.add_item(letra)
	# Ocultar menú al inicio
	menu.visible = false
	menu_n.clear()
	for numero in "1234567890":  # o range(1, 11) para números
		menu_n.add_item(numero)
	# Ocultar menú al inicio
	menu_n.visible = false
	

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
	var texto = menu.get_item_text(index)
	label.text = texto
	menu.visible = false
	boton.visible = true


func _on_button_pressed() -> void:
	menu.visible = not menu.visible
	boton.visible = false


func _on_option_button_n_item_selected(index: int) -> void:
	var numero = menu_n.get_item_text(index)
	label_n.text = numero
	menu_n.visible = false
	boton_n.visible = true


func _on_button_n_pressed() -> void:
	menu_n.visible = not menu_n.visible
	boton_n.visible = false


func _on_salida_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/Escenarios_Mapas/mapa_principal/mapa_universidad.tscn")
