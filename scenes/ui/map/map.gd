extends Node2D

@export var player: Node2D
@export var camera: Camera2D

@onready var player_head = $PlayerHead


func _ready():
	visible = false


func _process(delta):
	if Input.is_action_just_pressed("ui_map"):
		if visible:
			visible = false
			camera.zoom = Vector2(3, 3)
			get_tree().paused = false
		else:
			visible = true
			camera.zoom = Vector2(1.4, 1.4)
			get_tree().paused = true
	
	if !player:
		return
	
	if visible:
		player_head.position = player.global_position
