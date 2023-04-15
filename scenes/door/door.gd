extends StaticBody2D

@onready var animation_player = $AnimationPlayer


func activate():
	animation_player.play("Opening")
	await animation_player.animation_finished
	animation_player.play("Opened")
