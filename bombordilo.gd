extends CharacterBody2D

const SPEED = 160.0
const VELOCITY = 100.0

@onready var sprite: Sprite2D = $Sprite2D
@onready var bomb: Area2D = $Bomb
@onready var bomb_sprite: Sprite2D = $Bomb/Sprite2D

var facing_dir := 1.0
var can_launch := true
var initial_x := 0.0

func _ready() -> void:
	initial_x = bomb.position.x

func _physics_process(_delta: float) -> void:
	var dir := Input.get_axis("left_b", "right_b")
	if dir != 0:
		velocity.x = dir * SPEED
		facing_dir = sign(dir)
		sprite.flip_h = dir > 0
		bomb_sprite.flip_h = sprite.flip_h
		bomb.position.x = facing_dir * abs(initial_x)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	var vert := Input.get_axis("up_b", "down_b")
	if vert != 0:
		velocity.y = vert * VELOCITY
	else:
		velocity.y = move_toward(velocity.y, 0, VELOCITY)

	if Input.is_action_pressed("up_b") and Input.is_action_pressed("down_b") and can_launch:
		launch()

	move_and_slide()

func launch() -> void:
	can_launch = false

	var spawned = bomb.duplicate()
	get_tree().current_scene.add_child(spawned)
	spawned.global_position = bomb.global_position

	bomb.visible = false
	spawned.launch(facing_dir)

	await get_tree().create_timer(1.5).timeout

	bomb.visible = true
	can_launch = true
