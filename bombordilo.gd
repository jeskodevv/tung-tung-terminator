extends CharacterBody2D

const SPEED = 160.0
const VELOCITY = 100.0

@onready var sprite: Sprite2D = $Sprite2D

func _physics_process(delta: float) -> void:
	
	# direction; movement/deceleration
	var direction := Input.get_axis("left_b", "right_b")
	if direction:
		velocity.x = direction * SPEED
		sprite.flip_h = direction > 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	var vertical := Input.get_axis("up_b", "down_b")
	if vertical:
		velocity.y = vertical * VELOCITY
	else:
		velocity.y = move_toward(velocity.y, 0, VELOCITY)

	move_and_slide()
