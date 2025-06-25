extends Node
var estilos = {
	"print": {
		"color": Color.AZURE,
		"ancho": 45,
		"alto": 25,
		"text_color": Color.BLACK,
		"outline_color": Color.DARK_GRAY,
		"outline_size": 2
	},
	"default": {
		"color": Color.BISQUE,
		"ancho": 200,
		"alto": 60,
		"text_color": Color.DARK_RED,
		"outline_color": Color.LIGHT_GRAY,
		"outline_size": 1
	}
}

func configurar_bloque(nodo: Node2D) -> void:
	if not nodo.has_node("Label"):
		push_error("❌ El nodo ObjetoMovible no tiene un Label hijo.")
		return

	var label_node: Label = nodo.get_node("Label")
	# Usar el texto del Label como base del estilo
	var texto := label_node.text.strip_edges().to_lower()

	# 🔧 Buscar estilo por prefijo
	var clave := "default"
	for key in estilos.keys():
		if texto.begins_with(key):
			clave = key
			break

	var estilo: Dictionary = estilos[clave]

	
	nodo.modulate = estilo["color"]


	var collision: CollisionShape2D = nodo.get_node("Area2D/CollisionShape2D")
	var shape: Shape2D = collision.shape
	if shape is RectangleShape2D:
		var rect_shape := shape as RectangleShape2D
		rect_shape.extents = Vector2(estilo["ancho"] / 2, estilo["alto"] / 2)

	# 🔧 Centrar visualmente el Label
	label_node.position = Vector2(-estilo["ancho"] / 2 + 3, -12)
