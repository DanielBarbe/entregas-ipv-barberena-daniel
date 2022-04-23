extends Sprite

onready var cannon:Sprite = $Cannon

export (float) var acceleration :float = 20.0
export (float) var h_speed_limit :float = 600.0
export (float) var friction_weight :float = 0.1

var velocity:Vector2 = Vector2.ZERO
var projectile_container = Node

func set_projectile_container(container:Node):
	cannon.projectile_container = container
	projectile_container = container

func _physics_process(delta):
	var direction:int = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))

	if direction != 0:
		velocity.x = clamp(velocity.x + (direction * acceleration), -h_speed_limit, h_speed_limit)
	else:
		velocity.x = lerp(velocity.x, 0, friction_weight) if abs(velocity.x) > 1 else 0
	
	var mouse_position:Vector2 =  get_global_mouse_position()
	cannon.look_at(mouse_position)
	
	if Input.is_action_just_pressed("fire"):
		cannon.fire()

	position += velocity * delta
