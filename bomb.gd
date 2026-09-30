extends Area2D

const SPEED = 600.0

@onready var sprite: Sprite2D = $Sprite2D

var flying: = false
var direction: = 1.0

func launch(dir: float) -> void:
	direction = dir
	flying = true

func _physics_process(delta: float) -> void:
	if flying:
		position.x += direction * SPEED * delta
		sprite.flip_h = direction > 0

func _on_body_entered(body: Node2D) -> void:
	if not flying:
		return
	if body.has_method("take_damage"):
		body.take_damage(20)
	queue_free()
