extends Node

signal player_damaged(damage: float)
signal coin_quantity_changed(diff: int)

var player_lives = 5
var coin_quantity = 0


func player_damage(damage):
	player_lives -= damage
	player_damaged.emit(damage)


func add_coin(diff):
	coin_quantity += diff
	coin_quantity_changed.emit(diff)
