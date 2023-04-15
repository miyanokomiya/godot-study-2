extends Area2D


func _on_body_entered(body):
	Globals.can_save = true


func _on_body_exited(body):
	Globals.can_save = false
