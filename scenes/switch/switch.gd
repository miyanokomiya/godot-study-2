extends Area2D

@export var action_target: Node2D

@onready var animation_player = $AnimationPlayer


func activate_target():
	action_target.activate()


func _on_area_entered(area):
	animation_player.play("Activating")
	await animation_player.animation_finished
	animation_player.play("Activated")
