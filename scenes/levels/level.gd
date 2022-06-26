extends Node2D


export var fish: PackedScene

var fish_left := 30


func _ready() -> void:
	randomize()
	for i in 10:
		spawn_fish()
	var total := 0.0
	for f in get_tree().get_nodes_in_group("fish"):
		total += f.size
	$Player.set_progress(total)


func spawn_fish() -> void:
		var f := fish.instance()
		add_child(f)
		if randi() % 2:
			f.position.x = -100
			f.direction = Vector2.RIGHT
		else:
			f.position.x = 1380
			f.direction = Vector2.LEFT
			f.get_node("Sprite").flip_h = true
		f.position.y = rand_range(50, 670)


func _on_Player_all_enemies_died() -> void:
	if fish_left <= 0:
		$CanvasLayer/VBoxContainer/Message.text = "You win!"
		$CanvasLayer/VBoxContainer.show()


func _on_Player_player_died() -> void:
	$CanvasLayer/VBoxContainer/Message.text = "You lose!"
	$CanvasLayer/VBoxContainer.show()


func _on_Restart_pressed() -> void:
	get_tree().reload_current_scene()


func _on_Timer_timeout() -> void:
	spawn_fish()
	if fish_left > 0:
		$Timer.start()


func _on_Player_enemy_died() -> void:
	fish_left -= 1
