extends Node2D

@export var speed = 25

var player: Node2D

func _ready():
	player = get_node("../Player")

func _process(delta):
	if player == null:
		return

	var direction = (player.position - position).normalized()
	position += direction * speed * delta
