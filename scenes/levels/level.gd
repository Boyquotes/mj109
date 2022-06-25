extends Node2D


export var fish: PackedScene


func _ready() -> void:
	randomize()
	for i in 20:
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
	
	var total := 0.0
	for fish in get_tree().get_nodes_in_group("fish"):
		total += fish.size
	$Player.set_progress(total)


func _on_Player_all_enemies_died() -> void:
	$CanvasLayer/VBoxContainer/Message.text = "You win!"
	$CanvasLayer/VBoxContainer.show()


func _on_Player_player_died() -> void:
	$CanvasLayer/VBoxContainer/Message.text = "You lose!"
	$CanvasLayer/VBoxContainer.show()


func _on_Restart_pressed() -> void:
	get_tree().reload_current_scene()
