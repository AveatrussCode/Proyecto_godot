extends CharacterBody2D

var speed = 120

func _physics_process(delta):
	var direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	if direction.length() > 0:
		velocity = direction.normalized() * speed
	else:
		velocity = Vector2.ZERO
	move_and_slide()


		
func _process(_delta):
	if Input.is_action_pressed("left"):
		$AnimatedSprite2D.play("izquierda")
	elif Input.is_action_pressed("right"):
		$AnimatedSprite2D.play("derecha")
	elif Input.is_action_pressed("up"):
		$AnimatedSprite2D.play("arriba")
	elif Input.is_action_pressed("down"):
		$AnimatedSprite2D.play("abajo")
