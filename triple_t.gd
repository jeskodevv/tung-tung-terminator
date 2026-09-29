extends CharacterBody2D

const SPEED = 160.0
const JUMP_VELOCITY = -500.0

@onready var sprite: Sprite2D = $Sprite2D

func _physics_process(delta: float) -> void:
	# gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# jump
	if Input.is_action_just_pressed("jump_a") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# direction; movement/deceleration
	var direction := Input.get_axis("left_a", "right_a")
	if direction:
		velocity.x = direction * SPEED
		sprite.flip_h = direction > 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# slam
	
	
	move_and_slide()
