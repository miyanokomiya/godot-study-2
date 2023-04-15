extends Node2D


@export var player: Player

var save_path = "user://savegame.json"


func save_data():
	var data = {
		"player": player.to_dictionary(),
	}
	
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	var json = JSON.new()
	var json_string = json.stringify(data)
	file.store_line(json_string)
	


func load_data():
	if !FileAccess.file_exists(save_path):
		return
	
	var file = FileAccess.open(save_path, FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	
	player.from_dictionary(data["player"])


func _input(event):
	if event.is_action_pressed("ui_save") && Globals.can_save:
		save_data()
			
	if event.is_action_pressed("ui_load"):
		load_data()
