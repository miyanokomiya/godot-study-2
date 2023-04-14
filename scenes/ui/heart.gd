extends Control

@onready var sprite_2d = $Sprite2D

@export_range(0, 1, 0.25) var value: float = 1


func _read():
	set_value(value)


func set_value(v: float):
	if v < 0.25:
		sprite_2d.frame = 0
	elif v < 0.5:
		sprite_2d.frame = 1
	elif v < 0.75:
		sprite_2d.frame = 2
	elif v < 1:
		sprite_2d.frame = 3
	else:
		sprite_2d.frame = 4
