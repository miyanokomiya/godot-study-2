extends StaticBody2D

@onready var animation_player = $AnimationPlayer


@export var health: int = 3


func _on_hitbox_area_entered(area):
	if area.name == "Sword":
		health -= 1
	
		if health <= 0:
			animation_player.play("Destroyed")
			await animation_player.animation_finished
			queue_free()
		else:
			animation_player.play("Hurt")
			await animation_player.animation_finished
			animation_player.play("Active")
			
