extends Control


var dialogue := [
	"My anxiety is bad today. I thought I could handle it, but my body is exhausted. Worries are rushing across my mind, and my shoulders are hunched. Breathe. Remember the visualization your therapist taught you…",
	"It’s one of those days. I’m staring at my hands, wondering if they reflect me. Am I the person that made it through my workday, or just an anxious fraud?",
	"Anxiety feels like drowning, and drowning is one of my phobias. I used to have nightmares about being trapped underwater in a flooding room or a sinking ship. Breathe, just breathe…",
]

var current := -1

func _ready() -> void:
	advance()
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		if $Timer.is_stopped():
			advance()
		else:
			$Timer.stop()
			$Label.percent_visible = 1.0
	

func advance() -> void:
	current += 1
	if current >= dialogue.size():
		get_tree().change_scene("res://scenes/levels/level.tscn")
		return
	$Label.text = dialogue[current]
	$Label.visible_characters = 0
	$Timer.start()


func _on_Timer_timeout() -> void:
	$Label.visible_characters += 1
	if $Label.percent_visible != 1.0:
		$Timer.start()
