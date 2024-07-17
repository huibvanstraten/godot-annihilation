extends Control

func _on_character_test_pressed():
	EventManager.emit_signal("level", 0)
	SfxManager.play("res://assets/audio/sfx/ui/button_press.wav")

func _on_test_level_pressed():
	EventManager.emit_signal("level", 1)
	SfxManager.play("res://assets/audio/sfx/ui/button_press.wav")

func _on_moving_level_pressed():
	EventManager.emit_signal("level", 2)
	SfxManager.play("res://assets/audio/sfx/ui/button_press.wav")
	
func _on_mountain_level_pressed():
	EventManager.emit_signal("level", 3)
	SfxManager.play("res://assets/audio/sfx/ui/button_press.wav")

func _on_continue_pressed():
	print("CONTINUE")
	SfxManager.play("res://assets/audio/sfx/ui/button_press.wav")
	
func _on_quit_pressed():
	get_tree().quit()



