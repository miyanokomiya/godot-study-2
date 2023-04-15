extends Camera2D


@export var target: Node2D

var speed = 20


func _ready():
	position = target.global_position


func _process(delta):
	global_position = global_position.lerp(get_next_target_position(), 1.0 - exp(-delta * speed))


func get_next_target_position() -> Vector2:
	return target.global_position
