extends Area2D


const SCREEN_SIZE := Vector2(1280, 720)
const SPACE := 100

export var size := 1.0
export var speed := 200.0

var direction
var worries := [
	"You should get up; you’re lazy.",
	"Check your Twitter and learn how useless you are.",
	"You’re a burden on your family.",
	"Your friends are getting tired of you and they will leave you.",
	"You don’t matter in the grand scheme of things.",
	"You’re not strong enough.",
	"People you don’t know are dying.",
	"Why can’t you move off this couch?",
]

func _ready() -> void:
	$Label.text = worries[randi() % worries.size()]


func _physics_process(delta: float) -> void:
	if direction:
		position += direction * speed * delta
		if direction == Vector2.RIGHT and position.x > SCREEN_SIZE.x + SPACE:
			queue_free()
		elif direction == Vector2.LEFT and position.x < -SPACE:
			queue_free()
