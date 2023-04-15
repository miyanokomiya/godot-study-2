extends Area2D

@onready var animation_player = $AnimationPlayer


func _on_body_entered(body):
	if body.name == "Player":
		animation_player.play("Picked")
		Globals.add_coin(1)
