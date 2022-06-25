extends KinematicBody2D


signal player_died
signal all_enemies_died

export var base_speed := 200
export var speed_mult := 25
export var size := 1.0


func _physics_process(_delta: float) -> void:
	var input := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	move_and_slide((base_speed + speed_mult * size) * input)
	if not input.x == 0:
		$Sprite.flip_h = input.x < 0


func set_progress(max_value: float) -> void:
	$CanvasLayer/ProgressBar.max_value = max_value


func _on_Area2D_area_entered(area: Area2D) -> void:
	if area.size > size:
		queue_free()
		emit_signal("player_died")
	else:
		size += area.size
		$CanvasLayer/ProgressBar.value = size
		area.queue_free()
		yield(get_tree(), "idle_frame")
		if get_tree().get_nodes_in_group("fish").size() == 0:
			emit_signal("all_enemies_died")
