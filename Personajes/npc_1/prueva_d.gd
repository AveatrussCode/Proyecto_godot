extends CharacterBody2D
@export var speed: int = 60
@onready var animations = $AnimationPlayer

var tiempo_direccion := 0.0
var moveDirection := Vector2.ZERO

func handleInput(delta):
	tiempo_direccion -= delta
	if tiempo_direccion <= 0:
		var direcciones = [
			Vector2.LEFT,
			Vector2.RIGHT,
			Vector2.UP,
			Vector2.DOWN,
			Vector2.ZERO  # Para que a veces se quede quieto
		]
		moveDirection = direcciones[randi() % direcciones.size()]
		tiempo_direccion = randf_range(1.0, 3.0)  # Cambia dirección cada 1 a 3 segundos

	velocity = moveDirection * speed

func updateAnimation():
	if velocity.length() == 0:
		if animations.is_playing():
			animations.stop()
	else:
		var direction = "atras"
		if velocity.x < 0: direction = "izquierda" 
		elif velocity.x > 0: direction = "derecha" 
		elif velocity.y < 0: direction = "frente" 
		
		animations.play(direction)
		
func _physics_process(delta):
	handleInput(delta)
	move_and_slide()
	updateAnimation()
