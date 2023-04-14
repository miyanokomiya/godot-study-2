extends Node

signal player_damaged(damage: float)

var player_lives = 5


func player_damage(damage):
	player_lives -= damage
	player_damaged.emit(damage)
