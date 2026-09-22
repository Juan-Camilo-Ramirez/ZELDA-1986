extends CharacterBody2D

@export var speed = 120  
@export var return_speed = 40   
@export var margin = 8  

var player: Node2D
var start_pos: Vector2
var target_pos: Vector2

func _ready():
	start_pos = position
	player = get_node("../Player")

func _process(delta):
	if player == null:
		return

	var diff = player.position - start_pos
	var aligned = abs(diff.x) < margin or abs(diff.y) < margin
	var current_speed = speed

	if aligned and diff != Vector2.ZERO:
		if abs(diff.x) < margin:
			target_pos = Vector2(start_pos.x, player.position.y)
		else:
			target_pos = Vector2(player.position.x, start_pos.y)
	else:
		target_pos = start_pos
		current_speed = return_speed

	position = position.move_toward(target_pos, current_speed * delta)
