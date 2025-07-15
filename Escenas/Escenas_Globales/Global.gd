extends Node
# guardado de numero de clase que esta
var numero_clase = -1


var return_position := Vector2.ZERO # Guarda la posición del jugador
#este codigo sera para los objetos movibles
var is_dragging = false
#este codigo es para tranciciones
const layer_trancicion = preload("transicion_layer.tscn")



func create_transition(_scene, transition_type):
	var transition = layer_trancicion.instantiate()
	get_tree().root.call_deferred("add_child", transition)
	transition.start(transition_type)
	return transition
