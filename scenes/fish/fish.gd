extends Area2D


const SCREEN_SIZE := Vector2(1280, 720)
const SPACE := 100

export var size := 1.0
export var speed := 200.0

var direction


func _physics_process(delta: float) -> void:
	if direction:
		position += direction * speed * delta
		if direction == Vector2.RIGHT and position.x > SCREEN_SIZE.x + SPACE:
			direction = Vector2.LEFT
			$Sprite.flip_h = true
		elif direction == Vector2.LEFT and position.x < -SPACE:
			direction = Vector2.RIGHT
			$Sprite.flip_h = false
