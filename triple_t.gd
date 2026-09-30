extends CharacterBody2D

const SPEED = 160.0
const JUMP_VELOCITY = -500.0

@onready var sprite: Sprite2D = $Sprite2D

var facing_dir := 1.0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump_a") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var dir := Input.get_axis("left_a", "right_a")
	if dir != 0:
		velocity.x = dir * SPEED
		facing_dir = sign(dir)
		sprite.flip_h = dir > 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
