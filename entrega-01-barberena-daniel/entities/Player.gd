extends Sprite

export (float) var speed:float = 100

func _process(delta):
#
	var direction = int(Input.is_action_pressed("mover_der")) - int(Input.is_action_pressed("mover_izq"))

	position.x += direction * speed * delta
