extends CharacterBody2D

@export var speed = 200  
@export var margin = 8  

var player: Node2D
var start_pos: Vector2
var target_pos: Vector2
var going = false       

func _ready():
	start_pos = position
	player = get_node("../Player")

func _process(delta):
	if player == null:
		return

	var diff = player.position - start_pos

	var aligned = abs(diff.x) < margin or abs(diff.y) < margin

	if aligned and diff != Vector2.ZERO:
		going = true
		if abs(diff.x) < margin:
			target_pos = Vector2(start_pos.x, player.position.y)
		else:
			target_pos = Vector2(player.position.x, start_pos.y)
	else:
		going = false
		target_pos = start_pos

	position = position.move_toward(target_pos, speed * delta)
