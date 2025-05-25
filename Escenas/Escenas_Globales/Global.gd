extends Node

const layer_trancicion = preload("transicion_layer.tscn")

func create_transition(scene, transition_type):
	var transition = layer_trancicion.instantiate()
	get_tree().root.call_deferred("add_child", transition)
	transition.start(transition_type)
	return transition
