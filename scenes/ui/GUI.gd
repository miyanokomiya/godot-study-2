extends CanvasLayer

var heart_scene = preload("res://scenes/ui/heart.tscn")

@onready var heart_container = $HeartContainer
@onready var coin_text = $CoinText


func _ready():
	Globals.player_damaged.connect(on_player_damaged)
	Globals.coin_quantity_changed.connect(on_coin_quanitty_changed)
	
	for c in heart_container.get_children():
		heart_container.remove_child(c)
	
	for i in Globals.player_lives:
		var new_heart = heart_scene.instantiate()
		heart_container.add_child(new_heart)
		new_heart.set_value(1)
	
	update_hearts()


func update_hearts():
	var hearts = heart_container.get_children()
	var lives = Globals.player_lives
	for i in hearts.size():
		if lives >= 1:
			hearts[i].set_value(1)
			lives -= 1
		else:
			hearts[i].set_value(lives)
			lives = 0


func on_player_damaged(damage: float):
	update_hearts()


func on_coin_quanitty_changed(_diff: int):
	coin_text.text = "x%d" % Globals.coin_quantity
