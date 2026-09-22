extends Node2D

@export var speed = 60
@export var move_distance = 32
@export var margin = 8

@export var player_path: NodePath  # Aquí arrastras el nodo Player desde el Inspector

var player: Node2D
var start_pos: Vector2
var moving = false
var direction = Vector2.ZERO

func _ready():
	start_pos = position
	player = get_node(player_path)  # Toma directamente el nodo que arrastraste

func _process(delta):
	if player == null:
		return

	if not moving:
		var diff = player.position - start_pos
		if abs(diff.x) < margin and diff.y != 0:
			direction = Vector2(0, sign(diff.y))
			moving = true
		elif abs(diff.y) < margin and diff.x != 0:
			direction = Vector2(sign(diff.x), 0)
			moving = true
	else:
		position += direction * speed * delta
		if position.distance_to(start_pos) >= move_distance:
			moving = false
			position = start_pos
