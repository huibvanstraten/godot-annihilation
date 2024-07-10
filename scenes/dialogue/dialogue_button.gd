extends Control

@onready var button = $Next

func _on_pressed():
	if button.dialogue.options.size() == 0:
		DialogueManager.hide_dialogue()
		return
	
	DialogueManager.dialogue = button.dialogue

