extends Control



var button_pressed: String


func _on_Start_pressed() -> void:
	if not $VBoxContainer/Start/Select.playing:
		$VBoxContainer/Start/Select.play()
		button_pressed = "start"


func _on_Select_finished() -> void:
	if button_pressed == "start":
		get_tree().change_scene("res://scenes/title/cutscene.tscn")
	else:
		get_tree().change_scene("res://scenes/title/credits.tscn")



func _on_Credits_pressed() -> void:
	if not $VBoxContainer/Start/Select.playing:
		$VBoxContainer/Start/Select.play()
		button_pressed = "credits"
