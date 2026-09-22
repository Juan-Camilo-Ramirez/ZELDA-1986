extends CharacterBody2D

#Necesitamos una referencia de las animaciones
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

#Referencia de los raycast
@onready var ray_cast_2d_up: RayCast2D = $RayCast2D_UP
@onready var ray_cast_2d_down: RayCast2D = $RayCast2D_DOWN
@onready var ray_cast_2d_left: RayCast2D = $RayCast2D_LEFT
@onready var ray_cast_2d_right: RayCast2D = $RayCast2D_RIGHT

#Una variable para aplicar velocidad de movimiento
@export var SPEED: float = 30.0

#Varaible para almacenar hacia donde se desplaza el enemigo
var direction : Vector2 = Vector2.DOWN

var array_direction: Array  = [
	Vector2.UP, 
	Vector2.DOWN, 
	Vector2.LEFT, 
	Vector2.RIGHT
	]

#Se ejecuta una sola vez cuando inicia el juego
func _ready() -> void:
	direction = array_direction.pick_random()

#Se evalua en todo momento
func _physics_process(delta: float) -> void:
#	Validar la direccion hacia donde mira el enemigo
	if direction.x > 0:
		animated_sprite_2d.play("walk_right")
	elif direction.x < 0:
		animated_sprite_2d.play("walk_left")
	elif  direction.y > 0:
		animated_sprite_2d.play("walk_up")
	elif  direction.y < 0:
		animated_sprite_2d.play("walk_down")
	
#	luego aplico velocidad al enemigo
	velocity = direction * SPEED
	move_and_slide()
	
#validar la direccion hacia donde se esta moviendo el enemigo
#verificar si el racast detecta un objeto solido
	if direction == Vector2.UP and ray_cast_2d_up.is_colliding():
		change_direction()
	elif direction == Vector2.DOWN and ray_cast_2d_down.is_colliding():
		change_direction()
	elif direction == Vector2.LEFT and ray_cast_2d_left.is_colliding():
		change_direction()
	elif direction == Vector2.RIGHT and ray_cast_2d_right.is_colliding():
		change_direction()

#crear el metodo
func change_direction()-> void:
	var available_directions: Array = []
#	Validamos cada uno de los raycast y los uqe no detecten colison, hacia esa direccion
#	guaradamos ese vector en el arreglo
	if not ray_cast_2d_up.is_colliding():
		available_directions.append(Vector2.UP)
	if not ray_cast_2d_down.is_colliding():
		available_directions.append(Vector2.DOWN)
	if not ray_cast_2d_left.is_colliding():
		available_directions.append(Vector2.LEFT)
	if not ray_cast_2d_right.is_colliding():
		available_directions.append(Vector2.RIGHT)
	
	direction = available_directions.pick_random()
