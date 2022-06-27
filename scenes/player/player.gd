extends KinematicBody2D


signal player_died
signal enemy_died
signal all_enemies_died

export var base_speed := 200
export var speed_mult := 10
export var size := 1.0


var affirms := [
	"That is not true; you are very useful.",
	"Your family loves you.",
	"Your friends love you.",
	"Your friends need you.",
	"You get up every day and that makes you strong.",
	"You create every day.",
	"You drank water in the morning five days in a row.",
]

func _ready() -> void:
	$Label.text = affirms[randi() % affirms.size()]



func _physics_process(_delta: float) -> void:
	if $EatBad.playing:
		return
	var input := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	move_and_slide((base_speed + speed_mult * size) * input)
	if not input.x == 0:
		$Sprite.flip_h = input.x < 0


func set_progress(max_value: float) -> void:
	$CanvasLayer/ProgressBar.max_value = max_value


func _on_Area2D_area_entered(area: Area2D) -> void:
	if area.size > size:
		$EatBad.play()
		emit_signal("player_died")
	else:
		emit_signal("enemy_died")
		$Label.text = affirms[randi() % affirms.size()]
		var new_size = size + area.size
		if new_size >= 100 and size < 100:
			$Sprite.texture = load("res://sprites/Butterfly_fish_affirmation_300_pixels.png")
			$Grow.play()
		elif new_size >= 10 and size < 10:
			$Sprite.texture = load("res://sprites/Butterfly_fish_affirmation.png")
			$Grow.play()
		size = new_size
		$CanvasLayer/ProgressBar.value = size
		area.queue_free()
		$EatGood.play()
		yield(get_tree(), "idle_frame")
		if get_tree().get_nodes_in_group("fish").size() == 0:
			emit_signal("all_enemies_died")


func _on_EatBad_finished() -> void:
	queue_free()
