extends Node2D


export var shark: PackedScene
export var barracuda: PackedScene
export var shark2: PackedScene
export var pufferfish: PackedScene

var fish_left := 30


func _ready() -> void:
	randomize()
	for i in 5:
		spawn_fish()


func spawn_fish() -> void:
	var f
	var ran := randi() % 4
	if ran == 0:
		f = shark.instance()
	elif ran == 1:
		f = barracuda.instance()
	elif ran == 2:
		f = pufferfish.instance()
	else:
		f = shark2.instance()
		
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
		$CanvasLayer/VBoxContainer/Message.text = """Congrats! You made it through your day. Dealing with generalized anxiety is not easy. Affirmations and visualizations are one coping strategy, but there are many strategies to reduce anxiety throughout the day.
		Thank you for playing. You are not alone if you have generalized anxiety disorder or bad mental health days. We’re rooting for you, from the bottom of the ocean."""
		$CanvasLayer/VBoxContainer.show()


func _on_Player_player_died() -> void:
	$CanvasLayer/VBoxContainer/Message.text = "It’s okay; you had a bad day. Don’t worry; let it pass through you, and try again tomorrow."
	$CanvasLayer/VBoxContainer.show()


func _on_Restart_pressed() -> void:
	get_tree().reload_current_scene()


func _on_Timer_timeout() -> void:
	if fish_left <= 0:
		$CanvasLayer/VBoxContainer/Message.text = """Congrats! You made it through your day. Dealing with generalized anxiety is not easy. Affirmations and visualizations are one coping strategy, but there are many strategies to reduce anxiety throughout the day.
		Thank you for playing. You are not alone if you have generalized anxiety disorder or bad mental health days. We’re rooting for you, from the bottom of the ocean."""
		$CanvasLayer/VBoxContainer.show()
		return
	spawn_fish()
	if fish_left > 0:
		$Timer.start()


func _on_Player_enemy_died() -> void:
	fish_left -= 1


func _on_Title_pressed() -> void:
	get_tree().change_scene("res://scenes/title/title.tscn")
