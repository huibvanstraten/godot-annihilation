extends Area2D

func _on_body_entered(_body):
	EventManager.emit_signal("player_died")
