extends StaticBody2D

@onready var animation_player = $AnimationPlayer


func _on_area_2d_body_entered(body):
	animation_player.play("Destroyed")
	await animation_player.animation_finished
	await get_tree().create_timer(3).timeout
	animation_player.play("Respawn")
