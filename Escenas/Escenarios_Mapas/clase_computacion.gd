extends Node2D

func _ready() -> void:
	GLOBAL.create_transition(self,1)
	
	var player = get_node_or_null("Protagonista")
	if player:
		player.global_position = GLOBAL.return_position
