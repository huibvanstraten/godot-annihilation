extends Control


func _on_character_test_pressed():
	EventManager.emit_signal("level", 0)

func _on_test_level_pressed():
	EventManager.emit_signal("level", 1)

func _on_moving_level_pressed():
	EventManager.emit_signal("level", 2)

func _on_continue_pressed():
	print("CONTINUE")
