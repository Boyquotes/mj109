extends KinematicBody2D


export var base_speed := 200
export var size := 1.0


func _physics_process(_delta: float) -> void:
	var input := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	move_and_slide(base_speed * size * input)
	if not input.x == 0:
		$Sprite.flip_h = input.x < 0
