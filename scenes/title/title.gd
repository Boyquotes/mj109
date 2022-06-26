extends Control



func _on_Start_pressed() -> void:
	if not $VBoxContainer/Start/Select.playing:
		$VBoxContainer/Start/Select.play()


func _on_Select_finished() -> void:
	get_tree().change_scene("res://scenes/levels/level.tscn")
