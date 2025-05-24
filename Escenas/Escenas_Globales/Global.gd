extends Node

const layer_trancicion = preload("transicion_layer.tscn")

func create_transition(scene, transition_type):
	var transition = layer_trancicion.instantiate()
	transition.star(transition_type)
	scene.call_deferred("add_child", transition)
	return transition
